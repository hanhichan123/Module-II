-- Thực hành sử dụng các hàm SUM và AVG.

CREATE DATABASE BT5_3;
USE BT5_3;

CREATE TABLE EmployeeSalaries(
employeeID INT PRIMARY KEY AUTO_INCREMENT,
departmentID INT NOT NULL,
salary DECIMAL(10,2) NOT NULL
);

-- VIẾT TRUY VẤN ĐỂ TÍNH TỔNG LƯƠNG VÀ LƯƠNG TRUNG BÌNH CHO MỖI departmentID
SELECT 
departmentID,
SUM(salary) AS toTal_salary
FROM EmployeeSalaries
GROUP BY departmentID;

SELECT 
departmentID,
AVG(salary) AS toTal_salary
FROM EmployeeSalaries
GROUP BY departmentID;

-- GOM 2 BẢNG THÀNH 1 
SELECT 
departmentID,
SUM(salary) AS toTal_salary,
AVG(salary) AS avg_salary
FROM EmployeeSalaries
GROUP BY departmentID;