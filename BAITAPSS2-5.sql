CREATE DATABASE BT5;
USE BT5;

CREATE TABLE Products (
ProductID INT PRIMARY KEY AUTO_INCREMENT,
ProductNAME VARCHAR(100),
Category VARCHAR(50),
Price DECIMAL(10,2),
StockQuantity INT
);
-- DROP TABLE Orders;
CREATE TABLE Orders(
OrderID INT PRIMARY KEY AUTO_INCREMENT,
OrderDATE DATE,
ProductID INT NOT NULL,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
Quantity INT,
TotalAmount DECIMAL(10,2),
CHECK (TotalAmount >= 0)
);

-- TRUY VẤN VÀO BẢNG

INSERT INTO products(ProductNAME,Category,Price,StockQuantity) VALUES ('ÁO','CLOTHES',100,50);
INSERT INTO products(ProductNAME,Category,Price,StockQuantity) VALUES ('QUẦN','CLOTHES',300,10);
INSERT INTO products(ProductNAME,Category,Price,StockQuantity) VALUES ('MŨ','CLOTHES',50,0);


INSERT INTO orders(OrderDATE,ProductID,Quantity,TotalAmount) VALUES ('2025-10-11',2,10,0);
INSERT INTO orders(OrderDATE,ProductID,Quantity,TotalAmount) VALUES ('2025-11-12',1,5,0);

SET SQL_SAFE_UPDATES = 0;

UPDATE Orders o
JOIN Products p ON o.ProductID = p.ProductID
SET o.TotalAmount = o.Quantity * p.Price;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM products;
SELECT * FROM orders;

SELECT * FROM products WHERE StockQuantity > 0;