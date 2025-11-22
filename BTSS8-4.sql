-- Xây dựng một stored procedure nhận đầu vào là OrderID để xóa đơn hàng và tất cả các bản ghi liên quan từ bảng Sales.
-- Hãy tạo các bảng Customers, Products, Orders, Promotions, Sales trong cơ sở dữ liệu SalesDB 
-- và thêm chỉ số vào một số cột để cải thiện hiệu suất truy vấn.

CREATE DATABASE BT8_4_SalesDB;
USE BT8_4_SalesDB;

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY AUTO_INCREMENT,
FirstNAME VARCHAR(50) NOT NULL,
LastNAME VARCHAR(50) NOT NULL,
EMAIL VARCHAR(100) NOT NULL
);

CREATE TABLE Promotions(
PromotionID INT PRIMARY KEY AUTO_INCREMENT,
PromotionNAME VARCHAR(100) NOT NULL,
DiscountPercentage DECIMAL(10,2) NOT NULL
);

CREATE TABLE Products(
ProductID INT PRIMARY KEY AUTO_INCREMENT,
ProductNAME VARCHAR(100) NOT NULL,
Price DECIMAL(10,2)NOT NULL,
PromotionID INT NOT NULL,
FOREIGN KEY(PromotionID) REFERENCES Promotions(PromotionID)
);

CREATE TABLE Orders(
OrderID INT PRIMARY KEY AUTO_INCREMENT,
CustomerID INT NOT NULL,
FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
OrderDATE DATETIME,
TotalAMOUNT DECIMAL(10,2) NOT NULL
);

CREATE TABLE OrderDetaIlS (
OrderDetaIlID INT PRIMARY KEY AUTO_INCREMENT,
OrderID INT NOT NULL,
FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
ProductID INT NOT NULL,
FOREIGN KEY(ProductID) REFERENCES Products(ProductID),
Quantity INT NOT NULL,
UnitPrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE Sales(
SaleID INT PRIMARY KEY AUTO_INCREMENT,
OrderID INT NOT NULL,
FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
SaleDATE DATE,
SaleAmount DECIMAL(10,2) NOT NULL
);

INSERT INTO Customers (FirstNAME, LastNAME, EMAIL)
VALUES 
('Tung', 'Nguyen', 'tung@example.com'),
('Minh', 'Tran', 'minh@example.com'),
('Hoa', 'Le', 'hoa@example.com');

INSERT INTO Promotions (PromotionNAME, DiscountPercentage)
VALUES
('New Year Sale', 10.00),
('Summer Discount', 15.50),
('Black Friday', 25.00);

INSERT INTO Products (ProductNAME, Price, PromotionID)
VALUES
('Laptop Lenovo', 150000.00, 1),
('iPhone 14', 220000.00, 2),
('AirPods Pro', 60000.00, 3);

INSERT INTO Orders (CustomerID, OrderDATE, TotalAMOUNT)
VALUES
(1, '2025-11-21 10:00:00', 150000.00),
(2, '2025-11-21 11:30:00', 220000.00),
(3, '2025-11-21 12:45:00', 60000.00);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 1, 150000.00),
(2, 2, 1, 220000.00),
(3, 3, 1, 60000.00);

INSERT INTO Sales (OrderID, SaleDATE, SaleAmount) VALUES
(1, '2024-11-01', 2500.00),
(1, '2024-11-05', 1800.00),

(2, '2024-11-02', 3200.50),
(2, '2024-11-07', 1500.00),

(3, '2024-11-03', 500.00),
(3, '2024-11-10', 1200.75),
(3, '2024-11-11', 900.00),

(4, '2024-11-04', 2700.20),

(5, '2024-11-06', 3100.00),
(5, '2024-11-08', 800.00);
-- Thêm chỉ số vào một số cột để cải thiện hiệu suất truy vấn.
CREATE INDEX ORDER_SALES_INDEX
ON Sales(OrderID,SaleDATE);



-- Tạo stored procedure DeleteOrderAndSales với một tham số:
-- inOrderID (INT) – ID của đơn hàng cần xóa.
-- Procedure sẽ xóa tất cả các bản ghi liên quan từ bảng Sales trước, sau đó xóa đơn hàng từ bảng Orders.

DELIMITER $$
CREATE PROCEDURE DeleteOrderAndSales(
IN inOrderID INT
)
BEGIN 
DELETE FROM OrderDetails WHERE OrderID = inOrderID;
DELETE FROM Sales WHERE OrderID = inOrderID;
DELETE FROM Orders WHERE OrderID = inOrderID;

END $$
DELIMITER ;


CALL DeleteOrderAndSales(2);