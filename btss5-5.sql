-- Sử dụng các hàm tổng hợp và câu lệnh JOIN để xác định các sản phẩm bán chạy nhất.
CREATE DATABASE BT5_5;
USE BT5_5;

CREATE TABLE Products(
productID INT PRIMARY KEY AUTO_INCREMENT,
productNAME VARCHAR(100) NOT NULL
);

CREATE TABLE OrderDetails(
orderdetailID INT PRIMARY KEY AUTO_INCREMENT,
productID INT NOT NULL,
FOREIGN KEY (productID) REFERENCES Products(productID),
quantity INT NOT NULL,
price DECIMAL(10,2) NOT NULL
);

INSERT INTO Products (productNAME) VALUES
('Cà phê sữa'),
('Trà đào'),
('Bánh mì gối'),
('Sữa tươi'),
('Nước cam');

INSERT INTO OrderDetails (productID, quantity, price) VALUES
(1, 2, 45000),  -- CÀ PHÊ SỮA
(1, 5, 45000),

(2, 3, 30000),  -- TRÀ ĐÀO 
(2, 1, 30000),

(3, 4, 25000), -- BÁNH MỲ GỐI

(4, 2, 28000),   -- SỮA TƯƠI
(4, 6, 28000),

(5, 3, 35000); -- NƯỚC CAM


-- Viết truy vấn để lấy danh sách các sản phẩm cùng với tổng số lượng bán được, sắp xếp theo số lượng bán giảm dần.

SELECT 
p.productID,
p.productNAME,
SUM(o.quantity) AS TOTAL
FROM OrderDetails o
JOIN Products p ON p.productID = o.productID
GROUP BY  p.productID,p.productNAME
ORDER BY TOTAL DESC;
