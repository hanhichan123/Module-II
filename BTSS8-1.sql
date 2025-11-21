-- Xây dựng một stored procedure nhận đầu vào là CustomerID, startDate, và endDate 
-- để tính tổng doanh thu của khách hàng trong khoảng thời gian đó.
-- Hãy tạo các bảng Customers, Products, Orders, Promotions, Sales trong cơ sở dữ liệu SalesDB 
-- và thêm chỉ số vào một số cột để cải thiện hiệu suất truy vấn.

CREATE DATABASE BT_8_SalesDB;
USE BT_8_SalesDB;

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


-- Tạo stored procedure GetCustomerTotalRevenue với các tham số:
-- inCustomerID (INT) – ID của khách hàng.
-- inStartDate (DATE) – Ngày bắt đầu của khoảng thời gian.
-- inEndDate (DATE) – Ngày kết thúc của khoảng thời gian.
-- Procedure sẽ tính tổng doanh thu của khách hàng trong khoảng thời gian từ inStartDate đến inEndDate.
-- Procedure sẽ trả về tổng doanh thu.
DELIMITER $$
CREATE PROCEDURE GetCustomerTotalRevenue(
IN inCustomerID INT,
IN inStartDate DATE,
IN inEndDate DATE
)
BEGIN 
SELECT 
	SUM(TotalAMOUNT) AS TOTAL
    FROM Orders
    WHERE CustomerID = inCustomerID
    AND DATE(OrderDATE) BETWEEN inStartDate AND inEndDate;
END $$
DELIMITER ;

CALL GetCustomerTotalRevenue(1, '2025-01-01', '2025-12-31');