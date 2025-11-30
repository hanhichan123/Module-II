-- Tạo Trigger để ghi lại thông tin thay đổi số lượng sản phẩm vào bảng InventoryChanges mỗi khi có cập nhật số lượng trong bảng Products.
-- Tạo CSDL InventoryManagement gồm các bảng:
-- Bảng Products,InventoryChanges

CREATE DATABASE InventoryManagement;
USE InventoryManagement;

CREATE TABLE Products(
ProductID INT PRIMARY KEY AUTO_INCREMENT,
ProductNAME VARCHAR(100),
Quantity INT 
);

CREATE TABLE InventoryChanges(
ChangeID INT PRIMARY KEY AUTO_INCREMENT,
ProductID INT NOT NULL,
FOREIGN KEY(ProductID) REFERENCES Products(ProductID),
OldQuantity INT,
NewQuantity INT,
ChangeDATE DATETIME
);

INSERT INTO Products (ProductNAME, Quantity)
VALUES
('Iphone 15 Pro Max', 50),
('MacBook Air M2', 30),
('iPad Mini 6', 40),
('Apple Watch S9', 20),
('AirPods Pro 2', 60);

INSERT INTO InventoryChanges (ProductID, OldQuantity, NewQuantity, ChangeDATE)
VALUES
(1, 50, 45, '2025-01-10 10:30:00'),
(2, 30, 28, '2025-01-12 14:15:00'),
(3, 40, 42, '2025-01-15 09:00:00'),
(4, 20, 18, '2025-01-18 16:45:00'),
(5, 60, 65, '2025-01-20 11:20:00');

-- Tạo Trigger để ghi lại thông tin thay đổi số lượng sản phẩm vào bảng InventoryChanges mỗi khi có cập nhật số lượng trong bảng Products.
-- Tạo Trigger AfterProductUpdate để ghi lại các thay đổi số lượng hàng:\

DELIMITER $$
CREATE TRIGGER AfterProductUpdate
AFTER UPDATE ON Products 
FOR EACH ROW
BEGIN 

INSERT INTO InventoryChanges(ProductID,OldQuantity,NewQuantity,ChangeDATE)
VALUES (OLD.ProductID,OLD.Quantity,NEW.Quantity,NOW());
END $$
DELIMITER ; 

UPDATE Products
SET Quantity = 70
WHERE ProductID = 1;

SELECT * FROM Products;



																--   BÀI 2 --
-- Tạo Trigger BeforeProductDelete để kiểm tra số lượng sản phẩm trước khi xóa:
-- Kiểm tra xóa một sản phẩm có số lượng lớn hơn 10 và kiểm tra thông báo lỗi.

DELIMITER $$
CREATE TRIGGER BeforeProductDelete
BEFORE DELETE ON Products
FOR EACH ROW

BEGIN 
IF OLD.Quantity > 10 
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'LỖI';
END IF;

END $$ 
DELIMITER ; 

DELETE FROM Products WHERE ProductID = 1;

																-- BÀI 3 --\
															

-- Thay đổi cấu trúc bảng Products để bao gồm một trường LastUpdated

ALTER TABLE Products
ADD COLUMN LastUpdated DATETIME;


-- Tạo Trigger AfterProductUpdateSetDate để cập nhật trường LastUpdated khi có thay đổi

DELIMITER $$

CREATE TRIGGER AfterProductUpdateLog
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    
END $$

DELIMITER ;
DROP TRIGGER AfterProductUpdateLog;
UPDATE Products
SET ProductNAME = 'NAM'
WHERE ProductID = 1;



SELECT * FROM Products WHERE ProductID = 1;

										-- BÀI 10-4 -- 
                                        
-- Tạo Trigger để tự động cập nhật tổng số lượng hàng trong kho vào bảng tổng hợp khi có thay đổi trong bảng Products.
-- Tạo CSDL InventoryManagement gồm các bảng:
-- Bảng Products: Chứa thông tin về sản phẩm.
-- Bảng InventoryChanges: Ghi lại các thay đổi về số lượng hàng trong kho.

CREATE TABLE ProductSummary(
SummaryID INT PRIMARY KEY AUTO_INCREMENT,
TotalQuantity INT,
ProductID INT NOT NULL,
FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);

INSERT INTO ProductSummary (TotalQuantity, ProductID)
VALUES
(150, 1),
(320, 2),
(75,  3),
(210, 4),
(500, 5);

-- Tạo Trigger AfterProductUpdateSummary để cập nhật tổng số lượng hàng trong ProductSummary 
-- mỗi khi có thay đổi số lượng hàng trong Products:

DELIMITER $$
CREATE TRIGGER AfterProductUpdateSummary
AFTER UPDATE ON Products
FOR EACH ROW 
BEGIN 
UPDATE productsummary
SET TotalQuantity = NEW.Quantity
WHERE ProductID = NEW.ProductID; 

END $$
DELIMITER ;

UPDATE products
SET Quantity = 50
WHERE ProductID = 2;

