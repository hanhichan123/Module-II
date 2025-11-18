-- Thực hành sử dụng hàm COUNT và câu lệnh GROUP BY

-- TẠO BẢNG SALES 

CREATE DATABASE BT5_2;
USE BT5_2;

CREATE TABLE Sales(
saleID INT PRIMARY KEY AUTO_INCREMENT,
productID INT NOT NULL UNIQUE,
saleDATE DATE NOT NULL,
quantity INT NOT NULL,
amount DECIMAL(10,2) NOT NULL
);

-- Viết truy vấn để đếm số lượng đơn hàng (SaleID) cho mỗi ProductID.

SELECT 
ProductID,
COUNT(saleID) AS totalORDERS
FROM Sales
GROUP BY ProductID;

