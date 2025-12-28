CREATE DATABASE KT0720_64123456
GO
USE KT0720_64123456
GO
CREATE TABLE Lop
(
	MaLop nvarchar(15) PRIMARY KEY,
	TenLop nvarchar(50) NOT NULL
)
GO
CREATE TABLE SinhVien
(
	MaSV char(8) PRIMARY KEY,
	HoSV nvarchar(50) NOT NULL,
	TenSV nvarchar(10) NOT NULL,
	NgaySinh date,
	GioiTinh bit DEFAULT(1),
	AnhSV nvarchar(100),
	DiaChi nvarchar(100) NOT NULL,
	MaLop nvarchar(15) NOT NULL FOREIGN KEY REFERENCES Lop(MaLop)
	ON UPDATE CASCADE
	ON DELETE CASCADE
)
GO

INSERT INTO Lop VALUES('64.TTQL',N'Lớp HTTTQL-Khóa 64'),(N'66.KHMT',N'Lớp Khoa học máy tính-Khóa 66')
GO
INSERT SinhVien VALUES (N'63131824', N'Nguyễn Ngọc Phương', N'Anh', '09/23/2003',0,  N'employee.png', N'Nha Trang, Khánh Hòa', N'64.TTQL'),
						(N'64130070', N'Nguyễn Tuấn', N'Anh', '09/26/2004',1,  N'employee.png', N'Nha Trang, Khánh Hòa', N'64.TTQL')
GO
CREATE PROC SinhVien_DS
@MaSV char(8)
AS
BEGIN
	SELECT * FROM SinhVien WHERE MaSV=@MaSV
END