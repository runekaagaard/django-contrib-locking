from django.db.models.deletion import Collector
from django.db.models.sql.where import OR
from django.db.models.sql.constants import GET_ITERATOR_CHUNK_SIZE, CURSOR
from django.db.models.query_utils import Q
from django.db.models.manager import Manager
from django.db.models.sql.subqueries import UpdateQuery, DeleteQuery
from django.db.models.base import Model
from django.db.models.fields import IntegerField
from django.db.models.query import QuerySet


class OptimisticLockingManager(Manager):
    use_for_related_fields = True

    def get_queryset(self):
        return OptimisticLockingQueryset(self.model, using=self._db)


class VersionField(IntegerField):
    def get_db_prep_save(self, value, connection):
        assert type(value) is int or type(value) is Increment
        return value


class OptimisticLockingModel(Model):
    class Meta:
        abstract = True
        version_field = 'version'

    objects = OptimisticLockingManager()

    def save(self, *args, **kwargs):
        self.version += 1
        return super(OptimisticLockingModel, self).save(*args, **kwargs)


class OptimisticLockingUpdateQuery(UpdateQuery):
    def add_update_fields(self, values_seq):
        version_field_name = self.get_meta().version_field
        for field, _, value in values_seq:
            if field.attname == version_field_name:
                self.add_q(Q(**{field.attname: value-1}))
                break
        else:
            raise Exception("VersionField '{}' is missing from values".format(
                version_field_name))

        return super(OptimisticLockingUpdateQuery, self).add_update_fields(
            values_seq)

    def add_update_values(self, values):
        attname = self.get_meta().get_field(
            self.get_meta().version_field).attname
        values[attname] = Increment(attname, self.model)
        return super(OptimisticLockingUpdateQuery, self).add_update_values(
            values)

    def update_batch(self, pk_list, values, using):
        raise NotImplementedError()


class OptimisticLockingDeleteQuery(DeleteQuery):
    def do_query(self, table, where, using, expected_rowcount):
        self.tables = [table]
        self.where = where
        cursor = self.get_compiler(using).execute_sql(CURSOR)
        if cursor.rowcount != expected_rowcount:
            raise StaleDataError()

    def delete_batch(self, instances, using, field=None):
        if field is None:
            field = self.get_meta().pk
        version_field = self.get_meta().get_field(
            self.get_meta().version_field)

        values = [(obj.pk, obj.version) for obj in instances]
        for offset in range(0, len(values), GET_ITERATOR_CHUNK_SIZE):
            self.where = self.where_class()
            values_chunk = values[offset:offset + GET_ITERATOR_CHUNK_SIZE]
            for pk, version in values_chunk:
                self.where.add(PkAndVersion(self.model, pk, field.attname,
                    version, version_field.attname), OR)
            self.do_query(self.get_meta().db_table, self.where, using=using,
                          expected_rowcount=len(values_chunk))

    def delete_qs(self, query, using):
        raise NotImplementedError()


class StaleDataError(Exception):
    pass


class OptimisticLockingCollector(Collector):
    update_query = OptimisticLockingUpdateQuery

    def can_fast_delete(self, *args, **kwargs):
        return False


class OptimisticLockingQueryset(QuerySet):
    update_query = OptimisticLockingUpdateQuery
    delete_query = OptimisticLockingDeleteQuery
    collector = OptimisticLockingCollector

    def _update(self, values):
        row_count = super(OptimisticLockingQueryset, self)._update(values)
        if row_count == 0:
            raise StaleDataError()
        else:
            return row_count


class PkAndVersion(object):
    def __init__(self, model, pk, pk_field, version, version_field):
        self.model = model
        self.pk = pk
        self.pk_field = pk_field
        self.version = version
        self.version_field = version_field
        self.model = model

    def as_sql(self, compiler, connection):
        table = compiler.quote_name_unless_alias(self.model._meta.db_table)
        qn = connection.ops.quote_name
        pk, version_field = qn(self.pk_field), qn(self.version_field)

        return ('({0}.{1}=? AND {0}.{2}=?)'.format(table, pk, version_field),
                [self.pk, self.version])


class Increment(object):
    def __init__(self, version_field, model):
        self.version_field = version_field
        self.model = model

    def as_sql(self, compiler, connection):
        lhs = compiler.quote_name_unless_alias(self.model._meta.db_table)
        rhs = connection.ops.quote_name(self.version_field)

        return '{}.{}+?'.format(lhs, rhs), [1]