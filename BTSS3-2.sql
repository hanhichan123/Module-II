CREATE DATABASE THUVIEN;
USE THUVIEN;

CREATE TABLE Sach(
MaSach INT PRIMARY KEY,
TenSach VARCHAR(100),
NamXuatBan DATE
);

CREATE TABLE TacGia(
MaTacGia INT PRIMARY KEY,
TenTacGia VARCHAR(100)
);

CREATE TABLE Sach_Tacgia(
MaSach INT NOT NULL,
FOREIGN KEY (MaSach) REFERENCES Sach(MaSach),
MaTacGia INT NOT NULL,
FOREIGN KEY (MaTacGia) REFERENCES TacGia(MaTacGia)
);

-- Chèn 2 bản ghi mẫu vào các bảng
INSERT INTO Sach(MaSach,TenSach,NamXuatBan)
VALUES (1, 'Tấm Cám', '2023-11-11'),
(2, 'Truyện Kiều', '2021-12-20');

INSERT INTO TacGia(MaTacGia,TenTacGia)
VALUES (1, 'Truyện cổ tích'),
(2,'Nguyễn Du');

INSERT INTO Sach_Tacgia(MaSach,MaTacGia)
VALUES (1,1),
(2,2);

SELECT * FROM Sach_Tacgia;
SELECT * FROM TacGia;
SELECT * FROM Sach;
