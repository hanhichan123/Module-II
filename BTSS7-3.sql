-- Hãy tạo ba bảng Customers, Products, Orders, OrderItems trong cơ sở dữ liệu SalesDB 
-- Và thêm chỉ số vào một số cột để cải thiện hiệu suất truy vấn.

CREATE DATABASE BT7_2_SalesDB;
USE BT7_2_SalesDB;

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY AUTO_INCREMENT,
FirstNAME VARCHAR(50),
LastNAME VARCHAR(50),
Email VARCHAR(100)
);

CREATE TABLE Products(
ProductID INT PRIMARY KEY AUTO_INCREMENT,
ProductNAME VARCHAR(100),
Price DECIMAL(10,2)
);

CREATE TABLE Orders(
OrderID INT PRIMARY KEY AUTO_INCREMENT,
CustomerID INT NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
OrderDATE DATE,
TotalAmount DECIMAL(10,2)
);

CREATE TABLE OrderItems(
OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
OrderID INT NOT NULL,
FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
ProductID INT NOT NULL,
FOREIGN KEY(ProductID) REFERENCES Products(ProductID),
Quantity INT,
Price DECIMAL(10,2)
);

INSERT INTO Customers (FirstNAME, LastNAME, Email) VALUES
('Nguyen', 'An', 'an.nguyen@example.com'),
('Tran', 'Binh', 'binh.tran@example.com'),
('Le', 'Hoa', 'hoa.le@example.com'),
('Pham', 'Khanh', 'khanh.pham@example.com'),
('Do', 'Minh', 'minh.do@example.com');
INSERT INTO Products (ProductNAME, Price) VALUES
('Coffee Arabica', 120.00),
('Coffee Robusta', 90.00),
('Tea Oolong', 70.00),
('Green Tea', 60.00),
('Black Tea', 80.00);

INSERT INTO Orders (CustomerID, OrderDATE, TotalAmount) VALUES
(1, '2025-01-10', 240.00),
(2, '2025-01-12', 150.00),
(3, '2025-01-15', 300.00),
(4, '2025-01-18', 180.00),
(5, '2025-01-20', 90.00);

INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 2, 120.00),   -- Order 1 mua Arabica
(2, 2, 1, 90.00),    -- Order 2 mua Robusta
(3, 3, 3, 70.00),    -- Order 3 mua Oolong
(4, 4, 2, 60.00),    -- Order 4 mua Green Tea
(5, 5, 1, 80.00);    -- Order 5 mua Black Tea
-- Tạo chỉ số cho cột OrderID trong bảng OrderItems

CREATE INDEX OrderID_INDEX
ON OrderItems (OrderID);


