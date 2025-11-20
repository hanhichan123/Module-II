-- Hãy tạo các bảng Customers, Products, Orders, OrderItems, Sales trong cơ sở dữ liệu SalesDB 
-- Và thêm chỉ số vào một số cột để cải thiện hiệu suất truy vấn.

CREATE DATABASE BT7_5_Sales;
USE BT7_5_Sales;

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
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
ProductID INT NOT NULL,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
Quantity INT,
Price DECIMAL(10,2)
);

CREATE TABLE Sales(
SaleID  INT PRIMARY KEY AUTO_INCREMENT,
OrderID INT NOT NULL,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
SaleDATE DATE,
SaleAmount DECIMAL(10,2)
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
(1, 1, 2, 120.00),   
(2, 2, 1, 90.00),    
(3, 3, 3, 70.00),   
(4, 4, 2, 60.00), 
(5, 5, 1, 80.00); 

INSERT INTO Sales (OrderID, SaleDATE, SaleAmount) VALUES
(1, '2025-01-11', 240.00),
(2, '2025-01-13', 150.00),
(3, '2025-01-16', 300.00),
(4, '2025-01-19', 180.00),
(5, '2025-01-21', 90.00);   
-- Hãy tạo view CustomerOrderSummary để hiển thị:
-- CustomerID
-- CustomerName (tên đầy đủ của khách hàng)
-- TotalOrders (số lượng đơn hàng của khách hàng)
-- TotalAmountSpent (tổng số tiền đã chi tiêu)
 -- DROP VIEW CustomerOrderSummary;
CREATE VIEW CustomerOrderSummary
AS 
SELECT 
C.CustomerID,
CONCAT(C.FirstNAME,' ',C.LastNAME) AS CustomerName,
COUNT(O.OrderID) AS TotalOrders,
SUM(O.TotalAmount) AS TotalAmountSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstNAME, C.LastNAME;
-- Truy vấn từ view CustomerOrderSummary để tìm các khách hàng có tổng số tiền chi tiêu trên 50
SELECT *
FROM CustomerOrderSummary
WHERE TotalAmountSpent > 50;

