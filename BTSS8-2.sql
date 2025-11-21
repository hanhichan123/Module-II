-- Xây dựng một stored procedure nhận đầu vào là thông tin của khách hàng và thêm thông tin đó vào bảng Customers.
-- Hãy tạo các bảng Customers, Products, Orders, Promotions, Sales trong cơ sở dữ liệu SalesDB 
-- và thêm chỉ số vào một số cột để cải thiện hiệu suất truy vấn.

CREATE DATABASE BT8_2_SalesDB;
USE BT8_2_SalesDB;

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

-- Tạo stored procedure AddNewCustomer với các tham số:
-- inFirstName (VARCHAR) – Tên của khách hàng.
-- inLastName (VARCHAR) – Họ của khách hàng.
-- inEmail (VARCHAR) – Email của khách hàng.
-- Procedure sẽ thêm một bản ghi mới vào bảng Customers.

DELIMITER $$
CREATE PROCEDURE AddNewCustomer(
IN inFirstName VARCHAR(100),
IN inLastName VARCHAR(100),
IN inEmail VARCHAR(255)
)
BEGIN 
INSERT INTO Customers(FirstNAME,LastNAME,EMAIL)
VALUES (inFirstName,inLastName,inEmail);
END $$
DELIMITER ;



CALL AddNewCustomer('NGUYEN','TUNG','TUNG@GMAIL.COM');

