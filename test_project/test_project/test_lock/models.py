from django.contrib.locking.optimistic import (OptimisticLockingModel,
                                               VersionField)
from django.db import models


class FastDel(OptimisticLockingModel):
    version = VersionField(default=0)
    x = models.CharField(max_length=24)


class Author(OptimisticLockingModel):
    version = VersionField(default=0)
    name = models.CharField(max_length=24)

    def __unicode__(self):
        return self.name


class Book(OptimisticLockingModel):
    version = VersionField(default=0)
    author = models.ForeignKey(Author)
    title = models.CharField(max_length=24)

    def __unicode__(self):
        return self.title