CREATE DATABASE lab14_normal WITH TEMPLATE lab14;
-- Creates a new database from the existing lab14 database, so as to not overwrite existing data.

\c lab14_normal
-- Connects to the copied lab14_normal database

CREATE TABLE bookshelves (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255))
);
-- Creates a new table in the lab14_normal database with two columsn, one for id and one for name (varying characters up to 255 in length)

INSERT INTO bookshelves(name) SELECT DISTINCT bookshelf FROM books;
-- Copies the unique/distinct entries from the bookshelf column in the books table and inserts those into the name columnof the bookshelves table

ALTER TABLE books ADD COLUMN bookshelf_id INT;
-- creates a new column in the books table called bookshelf_id, which is an integer.

UPDATE books SET bookshelf_id=shelf.id FROM (SELECT * FROM bookshelves) AS shelf WHERE books.bookshelf = bookshelves.name;
-- For each entry in books, finds the name of the bookshelf, and sets that particular book's bookshelf_id to equal the id of the matching bookshelf name, from the bookshelves table

ALTER TABLE books DROP COLUMN bookshelf;
-- Now that the bookshelf column in books is referenced in a separate table, the column needs to be dropped (removed)

ALTER TABLE books ADD CONSTRAINT fk_bookshelves FOREIGN KEY (bookshelf_id) REFERENCES bookshelves(id);
-- Adds a link from the books table to point from the bookshelf_id column over to the id column of the bookshelves table.

