CREATE DATABASE QLKH6;
USE QLKH6;


CREATE TABLE Customers(
CustomerID INT PRIMARY KEY AUTO_INCREMENT,
CustomerName VARCHAR (100) NOT NULL UNIQUE,
Email VARCHAR(100) NOT NULL UNIQUE,
Phone VARCHAR(15)
); 


CREATE TABLE Orders(
OrderID INT PRIMARY KEY AUTO_INCREMENT,
OrderDATE DATE,
CustomerID INT NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE OrderDetails(
OrderdeailID INT PRIMARY KEY AUTO_INCREMENT,
OrderID INT NOT NULL,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
ProductID INT,
Quantity INT,
UnitPrice DECIMAL(10,2)
);


-- Chèn 2 khách hàng vào bảng Customers

INSERT INTO Customers(CustomerName,Email,Phone)
 VALUES ('Nguyen Van A','ABC@gmail.com',090334443),
 ('Tran Van B','CD@gmail.com',090344334);
 
 -- Chèn ít nhất 3 đơn hàng vào bảng Orders
 
 INSERT INTO Orders(OrderDATE,CustomerID)
 VALUES ('2025-12-11', 1),
 ('2025-10-20', 1),
 ('2025-12-5', 2);
 
-- Chèn ít nhất 5 chi tiết đơn hàng vào bảng OrderDetails
INSERT INTO OrderDetails(OrderID,ProductID,Quantity,UnitPrice)
 VALUES (1, 1, 2,100),
 (1, 2, 1,300),
 (2, 3, 0,200),
 (2, 4, 3,500),
 (3, 1, 2,100);
 
 -- cập nhật số điện thoại của 1 khách hàng cụ thể 
 
 UPDATE Customers SET Phone = 0700777777 WHERE CustomerID = 1;
 
 -- xóa tất cả đơn hàng của khách hàn không còn hoạt động 
 
 DELETE FROM Customers WHERE CustomerID = 3;
 
 -- truy vấn để lấy danh sách toàn bộ khách hàng cùng tổng đơn hàng mà họ đã đặt 
SELECT 
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o 
    ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.CustomerName;

