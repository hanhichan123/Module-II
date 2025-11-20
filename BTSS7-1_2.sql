-- Hãy tạo ba bảng Customers, Products, Orders, OrderDetails trong cơ sở dữ liệu SalesDB
-- Và thêm chỉ số vào một số cột để cải thiện hiệu suất truy vấn.

CREATE DATABASE BT7_1_SalesDB;
USE BT7_1_SalesDB;

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY AUTO_INCREMENT,
CustomerNAME VARCHAR(100) NOT NULL,
Phone VARCHAR(15),
CreateDATE DATETIME
);

CREATE TABLE Products(
ProductID INT PRIMARY KEY AUTO_INCREMENT,
ProductNAME VARCHAR(255) NOT NULL,
Category VARCHAR(255),
Price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Orders(
OrderID INT PRIMARY KEY AUTO_INCREMENT,
CustomerID INT NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
ToTalAmount DECIMAL(10,2) NOT NULL
);

CREATE TABLE OrderDetails(
OrderDetailID INT PRIMARY KEY,
OrderID INT NOT NULL,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
ProductID INT NOT NULL,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
Quantity INT NOT NULL,
Unitprice DECIMAL(10,2) NOT NULL
);

INSERT INTO Customers (CustomerNAME, Phone, CreateDATE)
VALUES
('Nguyen Van A', '0901111222', '2025-01-01 10:00:00'),
('Tran Thi B', '0903333444', '2025-02-15 09:30:00'),
('Le Van C', '0805555666', '2025-03-10 14:20:00');

INSERT INTO Products (ProductNAME, Category, Price)
VALUES
('Cà phê hòa tan', 'Đồ uống', 45.50),
('Sữa tươi 1L', 'Thực phẩm', 32.00),
('Bánh quy bơ', 'Bánh kẹo', 27.80);

INSERT INTO Orders (CustomerID, ToTalAmount)
VALUES
(1, 78.30),
(2, 150.00),
(3, 55.60);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Unitprice)
VALUES
(1, 1, 1, 2, 45.50),
(2, 2, 3, 5, 27.80),
(3, 3, 2, 1, 32.00);

-- Thêm chỉ số cho cột Email trong bảng Customers và cột OrderDate trong bảng Orders.
ALTER TABLE Customers ADD EMAIL VARCHAR (255);
SELECT * FROM Customers;
ALTER TABLE Orders ADD OrderDate DATE;
SELECT * FROM Orders;

-- BT 7 - 2 

-- Hãy tạo một view CustomerOrders với các cột: OrderID, CustomerName (họ và tên của khách hàng), OrderDate, TotalAmount

 CREATE VIEW CustomerOrders
 AS 
 SELECT O.OrderID, C.CustomerName, O.OrderDate, O.TotalAmount
 FROM Orders O
 JOIN Customers C ON O.CustomerID = C.CustomerID;
 
-- DROP VIEW CustomerOrders;

SELECT * FROM CustomerOrders;

