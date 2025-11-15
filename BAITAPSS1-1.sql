CREATE DATABASE CHS;
USE CHS;

CREATE TABLE Books(
bookID INt,
title VARCHAR(255),
autthor VARCHAR(255),
price DECIMAL(10,2),
publicationDATE DATE
);

-- Truy vấn các cột từ bảng BOOKS

SELECT * FROM Books;

-- Truy vấn vào cột tên sách và tác giả

SELECT 
title, autthor 
FROM 
Books
WHERE Price > 50;

