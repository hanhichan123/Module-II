-- Hãy tạo ba bảng Customers, Products, Orders trong cơ sở dữ liệu SalesDB 
-- Và thêm chỉ số vào một số cột để cải thiện hiệu suất truy vấn

CREATE DATABASE BT7_4_SalesDB;
USE BT7_4_SalesDB;

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY AUTO_INCREMENT,
CustomerNAME VARCHAR(100) NOT NULL,
EMAIL VARCHAR(100) NOT NULL,
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
OrderDATE DATETIME,
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

INSERT INTO Customers (CustomerNAME,EMAIL, Phone, CreateDATE)
VALUES
('Nguyen Van A','A@GMAIL.COM', '0901111222', '2025-01-01 10:00:00'),
('Tran Thi B','B@GMAIL.COM', '0903333444', '2025-02-15 09:30:00'),
('Le Van C','C@GMAIL.COM', '0805555666', '2025-03-10 14:20:00');

INSERT INTO Products (ProductNAME, Category, Price)
VALUES
('Cà phê hòa tan', 'Đồ uống', 45.50),
('Sữa tươi 1L', 'Thực phẩm', 32.00),
('Bánh quy bơ', 'Bánh kẹo', 27.80);

INSERT INTO Orders (CustomerID, OrderDATE, ToTalAmount)
VALUES
(1,'2025-11-01 10:00:00', 78.30),
(2,'2025-12-01 09:00:00', 150.00),
(3,'2025-09-01 10:00:00', 55.60);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Unitprice)
VALUES
(1, 1, 1, 2, 45.50),
(2, 2, 3, 5, 27.80),
(3, 3, 2, 1, 32.00);

-- Tạo một view CustomerOrders với các cột: OrderID, CustomerName (họ và tên của khách hàng), OrderDate, TotalAmount 
-- Cập nhật TotalAmount cho đơn hàng có OrderID là 1 thành 250.00.

 CREATE VIEW CustomerOrders
 AS 
 SELECT
 O.OrderID,
 C.CustomerName,
 O.OrderDate,
 O.TotalAmount
 FROM Orders O
 JOIN Customers C ON O.CustomerID = C.CustomerID;
 SELECT * FROM CustomerOrders;
 
 UPDATE CustomerOrders SET TotalAmount = 100 
 WHERE OrderID = 1;