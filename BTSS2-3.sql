USE COMPANYDB;


CREATE TABLE Departments(
DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
DepartmentName VARCHAR(100)
);

CREATE TABLE Employees(
EmployeeID INT,
FirstName VARCHAR(255),
LastName VARCHAR(255),
HireDate DATE,
Salary DECIMAL(10,2),
DepartmentID INT NOT NULL,
FOREIGN KEY  (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Làm việc với bảng Employees và Departments. Thực hiện các thao tác như truy vấn thông tin, cập nhật dữ liệu và xóa dữ liệu.
-- Truy vấn tất cả nhân viên thuộc phòng ban cụ thể.
-- Cập nhật thông tin lương của một nhân viên.
-- Xóa tất cả nhân viên có mức lương thấp hơn một giá trị nhất định.
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'Sales'),
(2, 'Marketing'),
(3, 'HR'),
(4, 'IT'),
(5, 'Finance');


INSERT INTO Employees (EmployeeID, FirstName, LastName, HireDate, Salary, DepartmentID)
VALUES
(1, 'Tung', 'Nguyen', '2020-05-01', 50000.00, 1),
(2, 'Minh', 'Tran', '2019-03-15', 60000.00, 2),
(3, 'Hoa', 'Le', '2021-07-20', 45000.00, 3),
(4, 'An', 'Pham', '2018-11-10', 70000.00, 4),
(5, 'Linh', 'Nguyen', '2022-01-05', 48000.00, 5);

-- TRUY VẤN THÔNG TIN 

SELECT * FROM Departments;
SELECT * FROM Employees;

-- cập nhật dữ liệu và xóa dữ liệu.
-- SET SQL_SAFE_UPDATES = 0
UPDATE Employees SET HireDate = '2021-07-21' WHERE EmployeeID = 3;
UPDATE Departments SET DepartmentName = 'BANKER' WHERE DepartmentID = 3;

DELETE FROM  Employees WHERE EmployeeID = 5;
