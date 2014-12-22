import os
import sys

import django

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "test_project.settings")
django.setup()

from django.contrib.locking.optimistic import StaleDataError
from test_project.test_lock.models import Author, FastDel, Book

author = Author(name="Famous")
assert author.version == 0
author.save()
assert author.version == 1
assert Author.objects.get(pk=author.pk).version == 1
author.save()
author.save()
assert author.version == 3
assert Author.objects.get(pk=author.pk).version == 3

pk = Author.objects.get(pk=author.pk).pk
try:
    a1 = Author.objects.get(pk=pk)
    a2 = Author.objects.get(pk=pk)
    a1.name = "Hej"
    a1.save()
    a2.name = "Nej"
    a2.save()
except StaleDataError:
    print "OK1"

try:
    a1 = Author.objects.get(pk=pk)
    a2 = Author.objects.get(pk=pk)
    a1.name = "Hej"
    a1.save()

    a2.delete()
except StaleDataError:
    print "OK2"

try:
    a1 = Author.objects.get(pk=pk)
    a2 = Author.objects.get(pk=pk)
    Author.objects.filter(pk=pk).update(name="foooooooooooo")
    assert Author.objects.get(pk=pk).name == "foooooooooooo"
    a2.save()
except StaleDataError:
    print "OK3"
#import sys; sys.exit()

try:
    fd = FastDel(x=42)
    fd.save()
    fd1 = FastDel.objects.get(pk=fd.pk)
    fd2 = FastDel.objects.get(pk=fd.pk)
    fd1.x = "NEW"
    fd1.save()
    fd2.delete()
except StaleDataError:
    print "OK4"

try:
    a1 = Author.objects.get(pk=pk)
    Author.objects.filter(pk=pk).delete()
    a1.delete()
except StaleDataError:
    print "OK5"

Author.objects.create(name="Famous").save()
Author.objects.create(name="Famous")
Author.objects.create(name="Famous")
Author.objects.create(name="Famous")
Author.objects.create(name="Famous")
Author.objects.create(name="Famous")
Author.objects.create(name="Famous")
Author.objects.all().delete()
assert Author.objects.count() == 0

'''
author = Author.objects.create(name="Famous")
pk = author.pk

a1 = Author.objects.get(pk=pk)
book = Book.objects.create(title="Book", author=a1)

b1 = Book.objects.get(pk=book.pk)
b2 = Book.objects.get(pk=book.pk)
b1.author.name = "New"
b1.author.save()
b1.save()
print Book.objects.get(pk=book.pk).author.name
assert Book.objects.get(pk=book.pk).author.name == "New"
b2.author.name = "New2"
b2.save()
'''