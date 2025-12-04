CREATE DATABASE ecommerce;
USE ecommerce;
-- 1. Bảng customers (Khách hàng)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Bảng orders (Đơn hàng)
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) DEFAULT 0,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- 3. Bảng products (Sản phẩm)
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Bảng order_items (Chi tiết đơn hàng)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 5. Bảng inventory (Kho hàng)
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- 6. Bảng payments (Thanh toán)
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash') NOT NULL,
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);
INSERT INTO customers (name, email, phone, address) VALUES
('Nguyễn Văn A', 'a@gmail.com', '0901111111', 'Hà Nội'),
('Trần Thị B', 'b@gmail.com', '0902222222', 'TP.HCM'),
('Lê Văn C', 'c@gmail.com', '0903333333', 'Đà Nẵng');
INSERT INTO products (name, price, description) VALUES
('Laptop Dell', 15000000, 'Laptop văn phòng'),
('Chuột Logitech', 300000, 'Chuột không dây'),
('Bàn phím cơ', 800000, 'Bàn phím gaming');
INSERT INTO inventory (product_id, stock_quantity) VALUES
(1, 10),
(2, 50),
(3, 20);
INSERT INTO orders (customer_id, total_amount, status) VALUES
(1, 0, 'Pending'),
(2, 0, 'Completed'),
(3, 0, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 15000000),
(1, 2, 2, 300000),
(2, 3, 1, 800000),
(3, 2, 3, 300000);
INSERT INTO payments (order_id, amount, payment_method, status) VALUES
(1, 15600000, 'Cash', 'Pending'),
(2, 800000, 'Credit Card', 'Completed'),
(3, 900000, 'PayPal', 'Pending');
DELIMITER $$
-- Tạo Trigger kiểm tra số lượng tồn kho trước khi thêm sản phẩm vào order_items. Nếu không đủ, báo lỗi SQLSTATE '45000'.
CREATE TRIGGER quantity_BEFORE_TRIGGER
BEFORE INSERT 
ON order_items 
FOR EACH ROW
BEGIN 
IF(SELECT COUNT(*) FROM products WHERE product_id = NEW.product_id) = 0
THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR';
END IF;
END; 
$$ DELIMITER ;
drop trigger quantity_BEFORE_TRIGGER;
INSERT INTO order_items(order_id,product_id,quantity,price)
VALUES (1, 1,50,100);

-- Tạo Trigger cập nhật total_amount trong bảng orders sau khi thêm một sản phẩm mới vào order_items. 

DELIMITER $$
CREATE TRIGGER IN_AFTER_TRIGGER
BEFORE INSERT 
ON order_items 
FOR EACH ROW
BEGIN 
UPDATE orders SET total_amount = total_amount + 1 WHERE order_id = NEW.order_id;
END; 
$$ DELIMITER ;
drop trigger IN_AFTER_TRIGGER;
INSERT INTO order_items(order_id,product_id,quantity,price)
VALUES (1, 1,50,100);
-- Tạo Trigger kiểm tra số lượng tồn kho trước khi cập nhật số lượng sản phẩm trong order_items. Nếu không đủ, báo lỗi SQLSTATE '45000'.
DELIMITER $$
CREATE TRIGGER UP_BEFORE_TRIGGER
BEFORE UPDATE 
ON order_items 
FOR EACH ROW
BEGIN 
IF(SELECT COUNT(*) FROM products WHERE product_id = NEW.product_id) = 0
THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR';
END IF;
END; 
$$ DELIMITER ;
drop trigger UP_BEFORE_TRIGGER;
UPDATE order_items 
SET quantity = 100 
WHERE order_item_id = 1;
-- Tạo Trigger cập nhật lại total_amount trong bảng orders khi số lượng hoặc giá của một sản phẩm trong order_items thay đổi.

DELIMITER $$
CREATE TRIGGER UP_ORDER_AFTER
AFTER UPDATE 
ON order_items
FOR EACH ROW 
BEGIN 
IF OLD.quantity <> NEW.quantity OR OLD.price <> NEW.price THEN 
UPDATE orders SET total_amount = (
SELECT SUM(quantity * price)
FROM order_items 
WHERE order_id = NEW.order_id
)
WHERE order_id = NEW.order_id;
END IF;
END $$ 
DELIMITER ;
drop trigger UP_ORDER_AFTER;
-- Tạo Trigger ngăn chặn việc xóa một đơn hàng có trạng thái Completed trong bảng orders. Nếu cố gắng xóa, báo lỗi SQLSTATE '45000'.

DELIMITER $$

CREATE TRIGGER prevent_delete_completed_order
BEFORE DELETE
ON orders
FOR EACH ROW
BEGIN
    IF OLD.status = 'Completed' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Đơn hàng đã hoàn thành, không thể xóa';
    END IF;
END $$

DELIMITER ;
DELETE FROM orders WHERE order_id = 5;
drop trigger prevent_delete_completed_order;

-- Tạo Trigger hoàn trả số lượng sản phẩm vào kho (inventory) sau khi một sản phẩm trong order_items bị xóa.

DELIMITER $$

CREATE TRIGGER AFTER_DELETE_inventory
AFTER DELETE 
ON order_items
FOR EACH ROW 
BEGIN
UPDATE inventory 
SET stock_quantity = stock_quantity + OLD.quantity
WHERE product_id = OLD.product_id;
END $$
DELIMITER ;

DELETE FROM order_items WHERE order_item_id = 2;

DROP TRIGGER AFTER_DELETE_inventory;

