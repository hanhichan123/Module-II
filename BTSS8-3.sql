-- Xây dựng một stored procedure nhận đầu vào là OrderID và newTotalAmount để cập nhật tổng số tiền của đơn hàng..
-- Hãy tạo các bảng Customers, Products, Orders, Promotions, Sales trong cơ sở dữ liệu SalesDB 
-- và thêm chỉ số vào một số cột để cải thiện hiệu suất truy vấn.

CREATE DATABASE BT8_3_SalesDB;
USE BT8_3_SalesDB;

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
-- chỉ số vào một số cột để cải thiện hiệu suất truy vấn.
CREATE INDEX ORDER_INDEX
ON Orders(OrderID);
-- Tạo stored procedure UpdateOrderTotalAmount với các tham số:
-- inOrderID (INT) – ID của đơn hàng.
-- inNewTotalAmount (DECIMAL) – Tổng số tiền mới của đơn hàng.
-- Procedure sẽ cập nhật tổng số tiền của đơn hàng trong bảng Orders.

DELIMITER $$
CREATE PROCEDURE UpdateOrderTotalAmount(
IN inOrderID INT,
IN inNewTotalAmount DECIMAL(10,2)
)
BEGIN
UPDATE Orders
	SET TotalAMOUNT = inNewTotalAmount
	WHERE OrderID = inOrderID;
SELECT TotalAMOUNT AS NEW_TOTAL
    FROM Orders
    WHERE OrderID = inOrderID;
END $$ 
DELIMITER ;


CALL UpdateOrderTotalAmount(1, 100);


