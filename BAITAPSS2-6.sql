CREATE DATABASE TMDT;
USE TMDT;




-- TẠO BẢNG Customers
CREATE TABLE Customers(
CustomerID INT PRIMARY KEY AUTO_INCREMENT,
CustomerNAME VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15)
);

-- TẠO BẢNG Orders
CREATE TABLE Orders(
OrderID INT PRIMARY KEY AUTO_INCREMENT,
OrderDate DATE,
CustomerID INT NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- TẠO BẢNG OrderDetails
CREATE TABLE OrderDetails(
OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
OrderID INT NOT NULL,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
ProductID INT NOT NULL,
Quantity INT,
UnitPrice DECIMAL(10,2),
CHECK (UnitPrice >= 0)
);

INSERT INTO Customers (CustomerNAME, Email, Phone)
VALUES 
('Nguyen Van A', 'a@example.com', '0901111111'),
('Tran Thi B', 'b@example.com', '0902222222');

INSERT INTO Orders (OrderDate, CustomerID)
VALUES
('2025-11-10', 1),
('2025-11-11', 1),
('2025-11-12', 2);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1 , 2, 200),
(1, 2 , 1, 500),
(2, 1, 1, 800),
(2, 2, 1, 400),
(3, 1, 2, 150);

SELECT * FROM Customers;
-- CẬP NHẬT SỐ ĐIỆN THOẠI CỦA 1 KHÁCH HÀNG TRONG CUSTOMER
UPDATE Customers SET Phone = '090900009' WHERE CustomerID = 1;
-- XÓA 1 KHÁCH HÀNG
DELETE FROM Customers WHERE CustomerID = 4;
SELECT * FROM Orders;