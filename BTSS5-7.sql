-- TẠO CSDL

CREATE DATABASE HSBH;
USE HSBH;

-- TẠO BẢNG

CREATE TABLE Products(
productID INT PRIMARY KEY AUTO_INCREMENT,
productNAME VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Regions(
regionID INT PRIMARY KEY AUTO_INCREMENT,
regionNAME VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Sales(
saleID INT PRIMARY KEY AUTO_INCREMENT,
productID INT NOT NULL,
FOREIGN KEY(productID) REFERENCES Products(productID),
regionID INT NOT NULL,
FOREIGN KEY(regionID) REFERENCES Regions(regionID),
saleDATE DATE NOT NULL,
quantity INT NOT NULL,
amount DECIMAL(10,2) NOT NULL
);

INSERT INTO Products(productNAME) 
VALUES ('ÁO POLO'), ('QUẦN KAKI');
INSERT INTO Regions(regionNAME) 
VALUES ('HN'),('HCM'),('DN');

SELECT * FROM Products;
SELECT * FROM Regions;

INSERT INTO Sales(productID,regionID,saleDATE,quantity,amount)
VALUES (1,1,'2025-11-12',1,100),
(2,3,'2025-11-12',1,200),
(1,2,'2025-11-12',1,300),
(2,2,'2025-11-12',1,500);
SELECT * FROM Sales;

-- VIẾT TRUY VẤN ĐỂ LẤY THÔNG TIN VỀ TỔNG DOANH THU VÀ SLSP BÁN RA, VÀ SẢN PHẨM BÁN CHẠY NHẤT

-- B1 : TÍNH TỔNG SỐ LƯỢNG CỦA TỪNG SẢN PHẨM ĐƯỢC BÁN RA THEO TỪNG KHU VỰC 
SELECT 
    r.regionName,
    p.productName,
    SUM(s.quantity) AS total_qty
FROM sales s
JOIN products p ON s.productID = p.productID
JOIN regions r ON r.regionID = s.regionID
GROUP BY r.regionID, r.regionName, p.productID, p.productName
HAVING SUM(s.quantity) =
(
    SELECT MAX(qty_total)
    FROM (
        SELECT 
            s2.regionID,
            s2.productID,
            SUM(s2.quantity) AS qty_total
        FROM sales s2
        GROUP BY s2.regionID, s2.productID
    ) AS x
    WHERE x.regionID = r.regionID
);
-- CHỈ LẤY RA NHỮNG SẢN PHẨM CÓ TỔNG QUATITY = SỐ LƯỢNG LỚN NHẤT


