USE ecommerce;

-- Tạo một Stored Procedure có tên sp_create_order.
-- Thủ tục này sẽ nhận các tham số đầu vào: customer_id, product_id, quantity, và price.
-- Bên trong thủ tục, sử dụng Transaction để quản lý:
-- Bắt đầu giao dịch bằng lệnh BEGIN.
-- Kiểm tra số lượng tồn kho. Nếu không đủ, ROLLBACK và thông báo lỗi.
-- Nếu đủ, thực hiện các thao tác sau:
-- Thêm một đơn hàng mới vào bảng orders.
-- Lấy order_id vừa tạo bằng LAST_INSERT_ID().
-- Thêm sản phẩm vào bảng order_items.
-- Cập nhật (giảm) số lượng tồn kho trong bảng inventory.
-- COMMIT giao dịch.

DELIMITER $$
CREATE PROCEDURE sp_create_order(
IN _customer_id INT,
IN _product_id INT,
IN _quantity INT,
IN _price DECIMAL(10,2)
)
BEGIN 
START TRANSACTION;
-- Kiểm tra số lượng tồn kho. Nếu không đủ, ROLLBACK và thông báo lỗi.
 SELECT stock_quantity
    INTO @stock
    FROM inventory
    WHERE product_id = _product_id
    FOR UPDATE;
IF @stock < _quantity THEN
ROLLBACK;
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR';

END IF ; 
-- Nếu đủ, thực hiện các thao tác sau:
-- Thêm một đơn hàng mới vào bảng orders.

INSERT INTO orders(customer_id,order_date,total_amount,status)
VALUES (_customer_id,NOW(),1,'PENDING');
-- Lấy order_id vừa tạo bằng LAST_INSERT_ID().
SET @order_id = LAST_INSERT_ID();
-- Thêm sản phẩm vào bảng order_items.
INSERT INTO order_items(order_id,product_id,quantity,price)
VALUES (@order_id,_product_id,_quantity,_price);

-- Cập nhật (giảm) số lượng tồn kho trong bảng inventory.
UPDATE inventory 
SET stock_quantity = stock_quantity - _quantity
WHERE product_id = _product_id;
COMMIT;


END $$
DELIMITER ;
-- DROP PROCEDURE sp_create_order;
CALL sp_create_order(1,1,1,100);

-- Tạo một Stored Procedure có tên sp_pay_order.
-- Thủ tục này sẽ nhận hai tham số: order_id và payment_method.
-- Sử dụng Transaction để quản lý:
-- Bắt đầu giao dịch.
-- Kiểm tra trạng thái đơn hàng. Nếu không phải 'Pending', ROLLBACK và thông báo lỗi.
-- Nếu là 'Pending', thực hiện các thao tác:
-- Thêm bản ghi thanh toán vào bảng payments.
-- Cập nhật trạng thái đơn hàng trong bảng orders thành 'Completed'.
-- COMMIT giao dịch.

DELIMITER $$
CREATE PROCEDURE sp_pay_order (
IN _order_id INT,
IN _payment_method enum('Credit Card','PayPal','Bank Transfer','Cash')
)
BEGIN 
START TRANSACTION;
-- TRUY VẪN VÀO status.  Kiểm tra trạng thái đơn hàng.
SELECT status 
INTO @PAYMENT_STATUS 
FROM orders
WHERE order_id = _order_id;
-- Nếu không phải 'Pending', ROLLBACK và thông báo lỗi.
IF @PAYMENT_STATUS <> 'Pending' THEN 
ROLLBACK;
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'not Pending';
END IF;
-- Nếu là 'Pending', thực hiện các thao tác:
-- Thêm bản ghi thanh toán vào bảng payments.
SELECT total_amount
INTO @amount
FROM orders
WHERE order_id = _order_id;
INSERT INTO payments(order_id,payment_date,amount,payment_method,status) 
VALUES (_order_id,NOW(),@amount,_payment_method,'Pending');
-- Cập nhật trạng thái đơn hàng trong bảng orders thành 'Completed'.
UPDATE orders
SET status = 'Completed'
WHERE order_id = _order_id;
-- COMMIT giao dịch.
COMMIT ;
END $$
DELIMITER ;

CALL sp_pay_order(6,'PayPal');
DROP PROCEDURE sp_pay_order;

-- Tạo một Stored Procedure có tên sp_cancel_order.
-- Thủ tục này sẽ nhận tham số order_id.
-- Sử dụng Transaction để quản lý:
-- Bắt đầu giao dịch.
-- Kiểm tra trạng thái đơn hàng. Nếu không phải 'Pending', ROLLBACK và thông báo lỗi.
-- Nếu là 'Pending', thực hiện các thao tác:
-- Hoàn trả số lượng hàng vào kho bằng cách cập nhật bảng inventory.
-- Xóa các sản phẩm liên quan khỏi bảng order_items.
-- Cập nhật trạng thái đơn hàng trong bảng orders thành 'Cancelled'.
-- COMMIT giao dịch.

DELIMITER $$
CREATE PROCEDURE sp_cancel_order(
IN _order_id INT
)
BEGIN 
START TRANSACTION;
-- Kiểm tra trạng thái đơn hàng. Nếu không phải 'Pending', ROLLBACK và thông báo lỗi.
SELECT status
INTO @STA_TUS
FROM orders
WHERE order_id = _order_id
FOR UPDATE;
IF @STA_TUS <> 'Pending' THEN 
		ROLLBACK;
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ĐƠN ĐÃ XỬ LÝ';
END IF;
-- Nếu là 'Pending', thực hiện các thao tác:
-- Hoàn trả số lượng hàng vào kho bằng cách cập nhật bảng inventory.
UPDATE inventory I
JOIN order_items O ON I.product_id = O.product_id
SET I.stock_quantity = I.stock_quantity + O.quantity
WHERE O.order_id = _order_id;
-- Xóa các sản phẩm liên quan khỏi bảng order_items.
DELETE FROM order_items
WHERE order_id = _order_id;
-- Cập nhật trạng thái đơn hàng trong bảng orders thành 'Cancelled'.
UPDATE orders
SET status = 'Cancelled'
WHERE order_id = _order_id;
-- COMMIT giao dịch.
COMMIT;
END $$
DELIMITER ;
DROP PROCEDURE sp_cancel_order;
SET SQL_SAFE_UPDATES = 0;
CALL sp_cancel_order(1);