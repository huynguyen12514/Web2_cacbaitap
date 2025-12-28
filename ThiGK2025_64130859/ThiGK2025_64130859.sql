CREATE DATABASE ThiGK2025_64130859
GO
USE ThiGK2025_64130859
GO
CREATE TABLE LoaiTaiSan
(
	MaLTS nvarchar(15) PRIMARY KEY,
	TenLTS nvarchar(50) NOT NULL
)
GO
CREATE TABLE TaiSan
(
	MaTS char(8) PRIMARY KEY,
	TenTS nvarchar(50) NOT NULL,
	DVT nvarchar(20) NOT NULL,
	XuatXu bit DEFAULT(1),
	DonGia int,
	AnhMH nvarchar(100),
	GhiChu nvarchar(100) NOT NULL,
	MaLTS nvarchar(15) NOT NULL FOREIGN KEY REFERENCES LoaiTaiSan(MaLTS)
	ON UPDATE CASCADE
	ON DELETE CASCADE
)
GO

INSERT INTO LoaiTaiSan (MaLTS, TenLTS)
VALUES ('LTS001', N'Thi?t b? ?i?n t?'),('LTS002', N'?? n?i th?t'), ('LTS003', N'Ph??ng ti?n giao thông');
	GO
INSERT INTO TaiSan (MaTS, TenTS, DVT, XuatXu, DonGia, AnhMH, GhiChu, MaLTS)
VALUES
   ('TS000001', N'Máy tính xách tay', N'Cái', 1, 20000000, N'laptop.jpg', N'Máy dùng v?n phòng', 'LTS001'),
    ('TS000002', N'Bàn làm vi?c', N'Chi?c', 0, 3000000, N'ban.jpg', N'Bàn g? s?i', 'LTS002'),
    ('TS000003', N'Xe máy', N'Chi?c', 1, 25000000, N'xemay.jpg', N'Xe Honda SH', 'LTS003');
	GO
CREATE PROC TaiSan_DS
@TenTS nvarchar(50)
AS
BEGIN
	SELECT * FROM TaiSan WHERE TenTS=@TenTS
END