CREATE DATABASE QLSP;
USE QLSP;

-- TẠO BẢNG Suppliers VÀ Products

CREATE TABLE Suppliers(
supplierID INT PRIMARY KEY AUTO_INCREMENT,
supplierNAME VARCHAR(100) NOT NULL,
contactEMAIL VARCHAR(100) NOT NULL
);

CREATE TABLE Products(
productID INT PRIMARY KEY AUTO_INCREMENT,
productNAME VARCHAR(100) NOT NULL,
supplierID INT NOT NULL,
FOREIGN KEY (supplierID) REFERENCES Suppliers(supplierID)
);

-- LÀM THIẾU CỘT TRONG BẢNG NÊN CHÈN THÊM VÀO
ALTER TABLE Products ADD COLUMN price DECIMAL(10,2);
ALTER TABLE Products ADD COLUMN stock INT NOT NULL;


-- THÊM 3 NHÀ CUNG CẤP VÀO BẢNG Suppliers
INSERT INTO Suppliers(supplierNAME,contactEMAIL) 
VALUES
('D&G','DANDG@GMAIL.COM'),
('NIKE','NIKE@GMAIL.COM'),
('ADIDAS','ADIDAS@GMAIL.COM');

-- Thêm 4 sản phẩm vào bảng Products với liên kết đến nhà cung cấp.
INSERT INTO Products(productNAME,supplierID)
VALUES
('T-SHIRT',1),
('SHOES',2),
('HAT',3),
('PANTS',1);

-- Cập nhật giá của sản phẩm có ProductID = 2 thành 45.99

UPDATE Products SET price = 45.99 WHERE productID = 2;

-- Cập nhật tên nhà cung cấp có SupplierID = 1.

UPDATE Suppliers SET supplierNAME = 'CHANEL' WHERE supplierID = 1;

-- Xóa nhà cung cấp với SupplierID = 3 khỏi bảng Suppliers.
DELETE FROM Products WHERE supplierID = 3;
DELETE FROM Suppliers WHERE supplierID = 3;

-- Xóa sản phẩm với ProductID = 4 khỏi bảng Products.

DELETE FROM Products WHERE productID = 4;

SELECT 
p.productID,
p.productNAME,
p.supplierID,
s.supplierNAME
FROM Products p
JOIN Suppliers s
ON 
p.productID = s.supplierNAME;

SELECT * FROM Products;
SELECT * FROM Suppliers;