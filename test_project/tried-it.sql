BEGIN None
INSERT INTO "test_lock_author" ("version", "name") VALUES (?, ?) [1, 'Famous']
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" WHERE "test_lock_author"."id" = ? LIMIT 21 (17,)
BEGIN None
UPDATE "test_lock_author" SET "version" = ?, "name" = ? WHERE ("test_lock_author"."id" = ? AND "test_lock_author"."version" = ?) (2, 'Famous', 17, 1)
BEGIN None
UPDATE "test_lock_author" SET "version" = ?, "name" = ? WHERE ("test_lock_author"."id" = ? AND "test_lock_author"."version" = ?) (3, 'Famous', 17, 2)
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" WHERE "test_lock_author"."id" = ? LIMIT 21 (17,)
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" WHERE "test_lock_author"."id" = ? LIMIT 21 (17,)
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" WHERE "test_lock_author"."id" = ? LIMIT 21 (17,)
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" WHERE "test_lock_author"."id" = ? LIMIT 21 (17,)
BEGIN None
UPDATE "test_lock_author" SET "version" = ?, "name" = ? WHERE ("test_lock_author"."id" = ? AND "test_lock_author"."version" = ?) (4, 'Hej', 17, 3)
BEGIN None
UPDATE "test_lock_author" SET "version" = ?, "name" = ? WHERE ("test_lock_author"."id" = ? AND "test_lock_author"."version" = ?) (4, 'Nej', 17, 3)
OK1
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" WHERE "test_lock_author"."id" = ? LIMIT 21 (17,)
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" WHERE "test_lock_author"."id" = ? LIMIT 21 (17,)
BEGIN None
UPDATE "test_lock_author" SET "version" = ?, "name" = ? WHERE ("test_lock_author"."id" = ? AND "test_lock_author"."version" = ?) (5, 'Hej', 17, 4)
SELECT "test_lock_book"."id", "test_lock_book"."version", "test_lock_book"."author_id", "test_lock_book"."title" FROM "test_lock_book" WHERE "test_lock_book"."author_id" IN (?) (17,)
BEGIN None
DELETE FROM "test_lock_author" WHERE ("test_lock_author"."id"=? AND "test_lock_author"."version"=?) (17, 4)
OK2
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" WHERE "test_lock_author"."id" = ? LIMIT 21 (17,)
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" WHERE "test_lock_author"."id" = ? LIMIT 21 (17,)
BEGIN None
UPDATE "test_lock_author" SET "version" = "test_lock_author"."version"+?, "name" = ? WHERE "test_lock_author"."id" = ? (1, 'foooooooooooo', 17)
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" WHERE "test_lock_author"."id" = ? LIMIT 21 (17,)
BEGIN None
UPDATE "test_lock_author" SET "version" = ?, "name" = ? WHERE ("test_lock_author"."id" = ? AND "test_lock_author"."version" = ?) (6, u'Hej', 17, 5)
OK3
BEGIN None
INSERT INTO "test_lock_fastdel" ("version", "x") VALUES (?, ?) [1, u'42']
SELECT "test_lock_fastdel"."id", "test_lock_fastdel"."version", "test_lock_fastdel"."x" FROM "test_lock_fastdel" WHERE "test_lock_fastdel"."id" = ? LIMIT 21 (3,)
SELECT "test_lock_fastdel"."id", "test_lock_fastdel"."version", "test_lock_fastdel"."x" FROM "test_lock_fastdel" WHERE "test_lock_fastdel"."id" = ? LIMIT 21 (3,)
BEGIN None
UPDATE "test_lock_fastdel" SET "version" = ?, "x" = ? WHERE ("test_lock_fastdel"."id" = ? AND "test_lock_fastdel"."version" = ?) (2, 'NEW', 3, 1)
BEGIN None
DELETE FROM "test_lock_fastdel" WHERE ("test_lock_fastdel"."id"=? AND "test_lock_fastdel"."version"=?) (3, 1)
OK4
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" WHERE "test_lock_author"."id" = ? LIMIT 21 (17,)
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" WHERE "test_lock_author"."id" = ? (17,)
SELECT "test_lock_book"."id", "test_lock_book"."version", "test_lock_book"."author_id", "test_lock_book"."title" FROM "test_lock_book" WHERE "test_lock_book"."author_id" IN (?) (17,)
BEGIN None
DELETE FROM "test_lock_author" WHERE ("test_lock_author"."id"=? AND "test_lock_author"."version"=?) (17, 6)
SELECT "test_lock_book"."id", "test_lock_book"."version", "test_lock_book"."author_id", "test_lock_book"."title" FROM "test_lock_book" WHERE "test_lock_book"."author_id" IN (?) (17,)
BEGIN None
DELETE FROM "test_lock_author" WHERE ("test_lock_author"."id"=? AND "test_lock_author"."version"=?) (17, 6)
OK5
BEGIN None
INSERT INTO "test_lock_author" ("version", "name") VALUES (?, ?) [1, 'Famous']
BEGIN None
UPDATE "test_lock_author" SET "version" = ?, "name" = ? WHERE ("test_lock_author"."id" = ? AND "test_lock_author"."version" = ?) (2, 'Famous', 18, 1)
BEGIN None
INSERT INTO "test_lock_author" ("version", "name") VALUES (?, ?) [1, 'Famous']
BEGIN None
INSERT INTO "test_lock_author" ("version", "name") VALUES (?, ?) [1, 'Famous']
BEGIN None
INSERT INTO "test_lock_author" ("version", "name") VALUES (?, ?) [1, 'Famous']
BEGIN None
INSERT INTO "test_lock_author" ("version", "name") VALUES (?, ?) [1, 'Famous']
BEGIN None
INSERT INTO "test_lock_author" ("version", "name") VALUES (?, ?) [1, 'Famous']
BEGIN None
INSERT INTO "test_lock_author" ("version", "name") VALUES (?, ?) [1, 'Famous']
SELECT "test_lock_author"."id", "test_lock_author"."version", "test_lock_author"."name" FROM "test_lock_author" ()
SELECT "test_lock_book"."id", "test_lock_book"."version", "test_lock_book"."author_id", "test_lock_book"."title" FROM "test_lock_book" WHERE "test_lock_book"."author_id" IN (?, ?, ?, ?, ?, ?, ?) (18, 19, 20, 21, 22, 23, 24)
BEGIN None
DELETE FROM "test_lock_author" WHERE (("test_lock_author"."id"=? AND "test_lock_author"."version"=?) OR ("test_lock_author"."id"=? AND "test_lock_author"."version"=?) OR ("test_lock_author"."id"=? AND "test_lock_author"."version"=?) OR ("test_lock_author"."id"=? AND "test_lock_author"."version"=?) OR ("test_lock_author"."id"=? AND "test_lock_author"."version"=?) OR ("test_lock_author"."id"=? AND "test_lock_author"."version"=?) OR ("test_lock_author"."id"=? AND "test_lock_author"."version"=?)) (24, 1, 23, 1, 22, 1, 21, 1, 20, 1, 19, 1, 18, 2)
SELECT COUNT(?) AS "__count" FROM "test_lock_author" ('*',)
