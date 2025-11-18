-- Sử dụng các hàm tổng hợp và các kỹ thuật nhóm dữ liệu để phân tích doanh thu theo tháng.
CREATE DATABASE BT5_6;
USE BT5_6;

CREATE TABLE Sales(
saleID INT PRIMARY KEY AUTO_INCREMENT,
saleDATE DATE NOT NULL,
price DECIMAL(10,2) NOT NULL
);

INSERT INTO Sales (saleDATE, price) VALUES
('2025-11-01', 1200),
('2025-11-02', 850),
('2025-11-03', 430),
('2025-11-04', 950),
('2025-11-05', 1500);

-- Viết truy vấn để tính tổng doanh thu, số lượng đơn hàng và doanh thu trung bình mỗi đơn hàng cho từng tháng.

SELECT
MONTH(s.saleDATE) AS sale_month,
COUNT(*) AS num_orders,           -- số đơn hàng trong tháng
SUM(s.price) AS total_revenue,    -- tổng doanh thu
AVG(s.price) AS avg_revenue       -- doanh thu trung bình mỗi đơn hàng
FROM Sales s
GROUP BY MONTH(s.saleDATE)
ORDER BY sale_month;