CREATE DATABASE BAITAP2_2;
USE BAITAP2_2;
-- TẠO BẢNG Products
CREATE TABLE Products (
ProductID INT,
ProductName VARCHAR(100),
Category VARCHAR(150),
Price DECIMAL(10,2),
StockQuantity INT
);

-- CHÈN BẢN GHI VÀO BẢNG PRODUCTS 

INSERT INTO Products(ProductID,ProductName,Category,Price,StockQuantity) VALUE (1,'T-SHIRT','CLOTHERS',100,50);
INSERT INTO Products(ProductID,ProductName,Category,Price,StockQuantity) VALUE (2,'PANTS','CLOTHERS',150,30);
INSERT INTO Products(ProductID,ProductName,Category,Price,StockQuantity) VALUE (3,'HAT','CLOTHERS',90,10);