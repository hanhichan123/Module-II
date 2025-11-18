-- [Bài tập] Quản lý sản phẩm & danh mục

CREATE DATABASE QLSP6_1;
USE QLSP6_1;

CREATE TABLE categories(
categorieID INT PRIMARY KEY AUTO_INCREMENT,
categorieNAME VARCHAR(100)
);

CREATE TABLE products(
productID INT PRIMARY KEY AUTO_INCREMENT,
productNAME VARCHAR(100) NOT NULL,
price FLOAT,
categorieID INT NOT NULL,
FOREIGN KEY (categorieID) REFERENCES categories(categorieID)
);


-- THÊM 3 SP VÀO BẢNG products
INSERT INTO categories (categorieNAME) VALUES
('Đồ uống'),
('Trà và cà phê'),
('Đồ ngọt');

INSERT INTO products (productNAME, price, categorieID) VALUES
('Cà phê Arabica', 120.50, 1),
('Trà xanh matcha', 80.00, 2),
('Socola đen', 150.75, 3);

-- Cập nhật giá của một sản phẩm đã có.
UPDATE products SET price = 100 WHERE productID = 1;
-- Xóa một sản phẩm.
DELETE FROM products WHERE productID = 3;
-- Hiển thị tất cả sản phẩm, sắp xếp theo giá.
SELECT 
productID,
productNAME,
price,
categorieID
FROM products
ORDER BY price ASC;

-- Thống kê số lượng sản phẩm cho từng danh mục.

SELECT
    c.categorieNAME,
    COUNT(p.productID) AS SoLuongSanPham
FROM
    categories c
LEFT JOIN
    products p ON c.categorieID = p.categorieID
GROUP BY
    c.categorieNAME;