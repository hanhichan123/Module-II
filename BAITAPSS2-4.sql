CREATE DATABASE BT3;
USE BT3;

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY auto_increment
);

CREATE TABLE Orders (
OrderID INT PRIMARY KEY auto_increment,
OrderDate DATE,
CustomerID INT NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
TotalAmount DECIMAL(10,2),
CHECK (TotalAmount > 0)
);
