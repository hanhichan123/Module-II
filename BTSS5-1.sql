-- truy vâsn với JOIN
CREATE DATABASE BT5_1;
USE BT5_1;

CREATE TABLE Customers(
customerID INT PRIMARY KEY AUTO_INCREMENT,
custommerNAME VARCHAR(100) NOT NULL,
contactEMAIL VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Orders(
orderID INT PRIMARY KEY AUTO_INCREMENT,
customerID INT NOT NULL,
FOREIGN KEY (customerID) REFERENCES Customers(customerID),
orderDATE DATE,
totalAMOUNT DECIMAL(10,2) NOT NULL
);

-- Viết truy vấn để lấy danh sách các đơn hàng cùng với tên khách hàng và email của họ.
SELECT 
    o.OrderID,
    o.OrderDate,
    c.custommerNAME,
    c.contactEMAIL
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;


