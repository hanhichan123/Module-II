-- Thực hành sử dụng các hàm MAX và MIN.
CREATE DATABASE BT5_4;
USE BT5_4;

CREATE TABLE Products(
productID INT PRIMARY KEY AUTO_INCREMENT,
productNAME VARCHAR(100) NOT NULL,
price DECIMAL(10,2) NOT NULL
);

INSERT INTO Products (productNAME, price) VALUES
('Cà phê hòa tan', 45000),
('Trà xanh Nhật', 30000),
('Sữa tươi nguyên kem', 28000),
('Bánh quy bơ', 25000),
('Mì ăn liền đặc biệt', 12000),
('Nước tăng lực', 18000),
('Gạo thơm Jasmine', 180000),
('Dầu ăn hướng dương', 65000),
('Nước mắm truyền thống', 55000),
('Đường tinh luyện', 23000);

-- Viết truy vấn để tìm sản phẩm có giá cao nhất và thấp nhất.
SELECT 
MAX(price) AS max_PRICE,
MIN(price) AS min_PRICE
FROM Products;