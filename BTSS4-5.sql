CREATE DATABASE QLSV;
USE QLSV;

-- TẠO BẢNG Students

CREATE TABLE Students(
studentID INT PRIMARY KEY AUTO_INCREMENT,
studentName VARCHAR(50) NOT NULL,
major VARCHAR(50) NOT NULL
);

-- TẠO BẢNG Courses

CREATE TABLE Courses(
courseID INT PRIMARY KEY AUTO_INCREMENT,
courseNAME VARCHAR(100) NOT NULL,
instructor VARCHAR(100) NOT NULL
);

-- THÊM 4 SINH VIÊN VÀO BẢNG STUDENTS

INSERT INTO Students(studentName,major)
VALUES
('NGUYEN VAN A','JAVASCRIPT'),
('PHAN THI B','PHP'),
('TRAN THI C','PYTHON'),
('PHAM VAN D','JAVA');

-- THÊM 3 MÔN HỌC VÀO BẢNG Courses

INSERT INTO Courses(courseNAME,instructor)
VALUES 
('JAVASCPIT','MR.LUAN'),
('PHP','MRS.MINH'),
('PYTHON','MR.CUONG');

-- CẬP NHẬT TÊN MÔN HỌC CÓ CourseID = 2 thành 'Advanced Mathematics'.
UPDATE Courses SET courseNAME = 'Advanced Mathematics' WHERE CourseID = 2;

-- CẬP NHẬT CHUYÊN NGÀNH CỦA  StudentID = 3 thành 'Engineering'.
UPDATE Students SET major = 'Engineering' WHERE StudentID = 3;

-- Xóa sinh viên với StudentID = 1 khỏi bảng Students.
DELETE FROM Students WHERE StudentID = 1;

-- Xóa môn học với CourseID = 3 khỏi bảng Courses.
DELETE FROM Courses WHERE CourseID = 3;

-- VIẾT TRUY VẤN ĐỂ LẤY TẤT CẢ THÔNG TIN TỪ BẢNG Students VÀ Courses

SELECT * FROM Students;
SELECT * FROM Courses;