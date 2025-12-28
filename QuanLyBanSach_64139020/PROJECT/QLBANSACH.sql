CREATE DATABASE QLBANSACH_64139020
GO
USE QLBANSACH_64139020

GO
CREATE TABLE KHACHHANG
(
MaKH INT IDENTITY(1,1) PRIMARY KEY,
HoTen NVARCHAR(50) NOT NULL,
Taikhoan Varchar(50) UNIQUE,
Matkhau Varchar(50) NOT NULL,
Email Varchar(100) UNIQUE,
DiachiKH NVARCHAR(200),
DienthoaiKH Varchar(50),
Ngaysinh DATETIME
)

GO
CREATE TABLE LOAISACH
(
MaLoai INT IDENTITY(1,1) PRIMARY KEY,
TenLoai NVARCHAR(50) NOT NULL
)

GO
CREATE TABLE NHAXUATBAN
(
MaNXB INT IDENTITY(1,1) PRIMARY KEY,
TenNXB NVARCHAR(50) NOT NULL,
Diachi NVARCHAR(200),
DienThoai VARCHAR(50)
)

GO
CREATE TABLE TACGIA
(
MaTG INT IDENTITY(1,1) PRIMARY KEY,
TenTG NVARCHAR(50) NOT NULL,
Diachi NVARCHAR(100),
Tieusu NVARCHAR(Max),
Dienthoai VARCHAR(50)
)


GO
CREATE TABLE SACH
(
Masach INT IDENTITY(1,1) PRIMARY KEY,
Tensach NVARCHAR(100) NOT NULL,
Giaban Decimal(18,0) CHECK (Giaban>=0),
Mota NVARCHAR(Max),
Anhbia VARCHAR(50),
Ngaycapnhat DATETIME,
Soluongton INT,
MaLoai INT,
MaNXB INT,
Constraint FK_Loai_SACH Foreign Key(MaLoai) References LOAISACH(MaLoai),
Constraint FK_NhaXB_SACH Foreign Key(MaNXB)References NHAXUATBAN(MANXB)
)

GO
CREATE TABLE VIETSACH
(
MaTG INT,
Masach INT,
Vaitro NVARCHAR(50),
CONSTRAINT PK_VietSach PRIMARY KEY(MaTG, Masach),
Constraint FK_TG_VIETSACH Foreign Key(MaTG) REFERENCES TACGIA(MaTG),
Constraint FK_SACH_VIETSACH Foreign Key(Masach) REFERENCES SACH(Masach)
)

GO
CREATE TABLE DONDATHANG
(
MaDonHang INT IDENTITY(1,1) PRIMARY KEY,
Dathanhtoan BIT,
Tinhtranggiaohang BIT,
Ngaydat DATETIME,
Ngaygiao DATETIME,
MaKH INT,
CONSTRAINT FK_Khachhang FOREIGN KEY (MaKH) REFERENCES Khachhang(MaKH)
)

GO
CREATE TABLE CHITIETDONTHANG
(
MaDonHang INT,
Masach INT,
Soluong Int Check(Soluong>0),
Dongia Decimal(18,0) Check(Dongia>=0),
CONSTRAINT PK_CTDatHang PRIMARY KEY(MaDonHang,Masach),
CONSTRAINT FK_Donhang FOREIGN KEY (MaDonHang) REFERENCES Dondathang(MaDonHang),
CONSTRAINT FK_Sach1 FOREIGN KEY (Masach) REFERENCES Sach(Masach)
)
GO
CREATE TABLE Admin (
UserAdmin VARCHAR (30)  NOT NULL PRIMARY KEY,
PassAdmin VARCHAR (30)  NOT NULL,
Hoten     NVARCHAR (50) NULL
)

INSERT INTO Admin VALUES 
('Admin', 'Admin123','Tester')

INSERT INTO KHACHHANG VALUES 
(N'Nguyễn Thị Diễn', N'DienNguyen','123','diennguyen@gmail.com',N'Bình Thuận','01654374455','2000-08-08'),
('Nguyễn Thị Thanh Tuyền', N'TuyenNguyen','234','tuyennguyen@gmail.com',N'Phú Yên','01654374466','2000-05-08'),
(N'Hồ Nguyễn Hồng Huệ', N'HoNguyen','345','honguyen@gmail.com',N'Ninh Hòa- Khánh Hòa','01654374478','2000-05-25'),
(N'Nguyễn Văn Hải Long', N'LongNguyen','456','longnguyen@gmail.com',N'Hải Dương','01654374412','2000-10-08'),
(N'Nguyễn Thị Bích Triều', N'TrieuNguyen','567','trieunguyen@gmail.com',N'Khánh Hòa','01654374565','2000-02-12'),
(N'Nguyễn Phan Nhật Linh', N'LinhNguyen','678','linhnguyen@gmail.com',N'Khánh Hòa','01654374246','2000-12-20'),
(N'Phạm Văn An', N'AnPham', '789', 'anpham@gmail.com', N'Hà Nội', '01654374001', '1995-01-15'),
(N'Lê Thị Bích', N'BichLe', '890', 'bichle@gmail.com', N'Đà Nẵng', '01654374002', '1994-02-20'),
(N'Vũ Đức Cường', N'CuongVu', '901', 'cuongvu@gmail.com', N'Hồ Chí Minh', '01654374003', '1993-03-10'),
(N'Đặng Thị Dung', N'DungDang', '012', 'dungdang@gmail.com', N'Hải Phòng', '01654374004', '1992-04-25'),
(N'Hồ Văn Em', N'EmHo', '123', 'emho@gmail.com', N'Cần Thơ', '01654374005', '1991-05-30'),
(N'Ngô Thu Hà', N'HaNgo', '234', 'hango@gmail.com', N'Nam Định', '01654374006', '1990-06-15'),
(N'Bùi Văn Khoa', N'KhoaBui', '345', 'khoabui@gmail.com', N'Quảng Ninh', '01654374007', '1989-07-20'),
(N'Trần Thị Lan', N'LanTran', '456', 'lantran@gmail.com', N'Thừa Thiên Huế', '01654374008', '1988-08-05'),
(N'Phan Văn Mạnh', N'ManhPhan', '567', 'manhphan@gmail.com', N'Bắc Ninh', '01654374009', '1987-09-10'),
(N'Hoàng Thị Nga', N'NgaHoang', '678', 'ngahoang@gmail.com', N'Bình Dương', '01654374010', '1986-10-15'),
(N'Nguyễn Văn Phước', N'PhuocNguyen', '789', 'phuocnguyen@gmail.com', N'Vĩnh Phúc', '01654374011', '1985-11-20'),
(N'Võ Thị Quỳnh', N'QuynhVo', '890', 'quynhvo@gmail.com', N'Long An', '01654374012', '1984-12-05'),
(N'Cao Văn Sơn', N'SonCao', '901', 'soncao@gmail.com', N'Hậu Giang', '01654374013', '1983-01-10'),
(N'Lý Thị Thu', N'ThuLy', '012', 'thuly@gmail.com', N'Gia Lai', '01654374014', '1982-02-15'),
(N'Trương Văn Tài', N'TaiTruong', '123', 'taitruong@gmail.com', N'Lâm Đồng', '01654374015', '1981-03-20'),
(N'Hứa Thị Uyên', N'UyenHua', '234', 'uyenhua@gmail.com', N'Cao Bằng', '01654374016', '1980-04-25'),
(N'Dương Văn Vinh', N'VinhDuong', '345', 'vinhduong@gmail.com', N'Tuyên Quang', '01654374017', '1979-05-30'),
(N'Tạ Thị Xinh', N'XinhTa', '456', 'xinh.ta@gmail.com', N'Yên Bái', '01654374018', '1978-06-15'),
(N'Hồ Văn Yên', N'YenHo', '567', 'yenho@gmail.com', N'Quảng Bình', '01654374019', '1977-07-20'),
(N'Nguyễn Thị Hòa', N'HoaNguyen', '678', 'hoanguyen@gmail.com', N'Phú Thọ', '01654374020', '1976-08-25'),
(N'Nguyễn Văn Tùng', N'TungNguyen', '789', 'tungnguyen@gmail.com', N'Thái Nguyên', '01654374021', '1995-09-15'),
(N'Phạm Thị Hương', N'HuongPham', '890', 'huongpham@gmail.com', N'Hà Giang', '01654374022', '1994-10-20'),
(N'Vũ Văn Kiên', N'KienVu', '901', 'kienvu@gmail.com', N'Hà Tĩnh', '01654374023', '1993-11-25'),
(N'Đỗ Thị Mai', N'MaiDo', '012', 'maido@gmail.com', N'Ninh Bình', '01654374024', '1992-12-30');

INSERT INTO NHAXUATBAN VALUES 
(N'NXB Kim Đồng',N'55 Quang Trung, Hai Bà Trưng, Hà Nội','02439434730'),
(N'NXB Trẻ',N'161B Lý Chính Thắng, Phường 7, Quận 3, Thành phố Hồ Chí Minh.','(028) 39316289 - 39316211 - 39317849'),
(N'NXB Hội Nhà văn',N'Số 65 Nguyễn Du, Hà Nội','024.38222135'),
(N'NXB Giáo dục Việt Nam',N'81 Trần Hưng Đạo, Hà Nội','024.38220801'),
(N'NXB Tổng hợp TP.HCM',N' 62 Nguyễn Thị Minh Khai, Phường Đa Kao, Quận 1, TP.HCM',' (028) 38 225 340 – 38 296 764'),
(N'Báo Sinh Viên VN - Hoa Học Trò',N'502 Lê Văn Sỹ, P. 14, Q. 3, Tp. Hồ Chí Minh (TPHCM)','(028) 39312190.'),
(N'NXB Văn học',N'18 Nguyễn Trường Tộ, phường Trúc Bạch, quận Ba Đình, thành phố Hà Nội ','0243. 7161518  - 0243. 7163409'),
(N'NXB Văn hóa - Văn nghệ', N'69 Nguyễn Du, Hà Nội', '02439451234'),
(N'NXB Lao Động', N'28 Trần Hưng Đạo, Hà Nội', '02439481234'),
(N'NXB Phương Đông', N'205 Trần Huy Liệu, phường 8, Phú Nhuận, TP.HCM', '0831712819'),
(N'NXB Đại học Quốc gia', N'144 Xuân Thủy, Cầu Giấy, Hà Nội', '02437512222'),
(N'NXB Thế Giới',N'59 Thợ Nhuộm, Hoàn Kiếm, Hà Nội.','0914439904'),
(N'NXB Phụ Nữ Việt Nam',N'39 Hàng Chuối, Q. Hai Bà Trưng, Hà Nội','(024) 39710717'),
(N'NXB Nhã Nam', N'12 Nguyễn Thị Minh Khai, Q.1, TP.HCM', '02838220000'),
(N'NXB Văn hóa Thông tin', N'123 Trần Hưng Đạo, Hà Nội', '02439430000');

INSERT INTO LOAISACH VALUES 
(N'Kinh tế'),
(N'Tâm lý - Kỹ năng sống'),
(N'Tiểu thuyết'),
(N'Manga - Comic'),
(N'Truyện Thiếu Nhi'),
(N'Sách Giáo Khoa'),
(N'Thể Loại Khác');

INSERT INTO TACGIA VALUES
(N'J.K.Rowling',N'Anh', N'thường được biết đến với bút danh J. K. Rowling, Là một nhà văn, nhà từ thiện, nhà sản xuất phim và truyền hình, nhà biên kịch người Anh. Bà nổi tiếng là tác giả của bộ truyện giả tưởng Harry Potter từng đoạt nhiều giải thưởng và bán được hơn 500 triệu bản, trở thành bộ sách bán chạy nhất trong lịch sử.',''),
(N'Paulo Coelho',N'Brasil', N'Là nhà văn người Brazil, bậc thầy kể chuyện với lối viết đậm chất triết lý. Ông là tác giả của nhiều tác phẩm truyền cảm hứng, trong đó "Nhà Giả Kim" là cuốn sách nổi tiếng nhất, được dịch ra hơn 80 ngôn ngữ và bán hàng triệu bản trên toàn thế giới. ',''),
(N'Vân Võ',N'Việt Nam', N'Là một tác giả 8x, VanVo55 vẫn giữ được tâm hồn trẻ trung, yêu đời, mang niềm đam mê mãnh liệt với những câu chuyện tình cảm tha thiết',''),
(N'Tô Hoài', N'Việt Nam', N'Tô Hoài (1920–2014) là nhà văn nổi tiếng với những tác phẩm văn học viết về nông thôn, thiếu nhi và lịch sử. Tác phẩm nổi bật nhất của ông là Dế Mèn phiêu lưu ký.', N''),
(N'Nguyễn Huy Thiệp', N'Việt Nam', N'Nguyễn Huy Thiệp là cây bút nổi bật trong văn học Việt Nam hiện đại, với nhiều truyện ngắn sâu sắc, phản ánh các vấn đề xã hội và triết lý sống.', N''),
(N'Trần Đức Tiến', N'Việt Nam', N'Trần Đức Tiến là một nhà văn Việt Nam nổi tiếng chuyên viết cho thiếu nhi. Ông sinh năm 1957 tại Hà Tĩnh và là hội viên Hội Nhà văn Việt Nam. Trần Đức Tiến từng làm việc tại NXB Kim Đồng – nơi chuyên xuất bản sách dành cho trẻ em.', N''),
(N'Muriel Barbery', N'Pháp', N'Bà là nhà văn và triết gia người Pháp, nổi bật với tiểu thuyết "Sự tao nhã của nhím" (L’Élégance du hérisson), một tác phẩm gây tiếng vang toàn cầu.', N''),
(N'Ngô Tất Tố', N'Việt Nam', N'Ngô Tất Tố (1894–1954) là nhà văn, nhà báo, nhà Nho nổi tiếng đầu thế kỷ 20. Ông là tác giả tiểu thuyết phê phán xã hội tiêu biểu như "Tắt đèn", phản ánh số phận người nông dân dưới chế độ thực dân phong kiến.', N''),
(N'Riichiro Inagaki', N'Nhật Bản', N'Riichiro Inagaki là một tác giả truyện tranh Nhật Bản đến từ Tokyo. Anh bắt đầu sự nghiệp của mình vào năm 2001 khi xuất bản tác phẩm cho tạp chí Big Comic Spirits của Shogakukan.', N''),
(N'Nguyễn Nhật Ánh', N'Việt Nam', N'Nguyễn Nhật Ánh là nhà văn nổi tiếng viết cho thanh thiếu niên Việt Nam. Ông được yêu thích với các tác phẩm như "Kính vạn hoa", "Tôi thấy hoa vàng trên cỏ xanh", "Mắt biếc", nhiều tác phẩm được chuyển thể thành phim.', N''),
(N'Thích Nhất Hạnh', N'Việt Nam', N'Thích Nhất Hạnh (1926–2022) là thiền sư, học giả và nhà hoạt động vì hòa bình. Ông có ảnh hưởng sâu rộng toàn cầu về Phật giáo ứng dụng và chánh niệm, với nhiều sách được dịch ra hàng chục ngôn ngữ như "Phép lạ của sự tỉnh thức", "Giận".', N''),
(N'Jim Collins ', N'Mỹ', N'Jim Collins là một nhà nghiên cứu, tác giả và diễn giả nổi tiếng người Mỹ trong lĩnh vực kinh doanh và quản trị chiến lược. Ông sinh năm 1958, từng giảng dạy tại Trường Kinh doanh Stanford và là người sáng lập phòng nghiên cứu quản trị Jim Collins Lab.', N''),
(N'Bộ Giáo dục và Đào tạo',N'',N'',''),
(N'Paul Kalanithi',N'',N'',''),
(N'Linda Sue Park',N'',N'',''),
(N'Albert Rutherford',N'',N'','');

-- J.K. Rowling
INSERT INTO SACH VALUES
(N'Harry Potter Và Đứa Trẻ Bị Nguyền Rủa', 120000, 
N'Phù thủy nổi tiếng nhất thế giới đã quay trở lại. Tập truyện "Harry Potter và Đứa Trẻ bị Nguyền rủa”- phần thứ 8 được chính thức phát hành. Khác với bảy phần trước của tiểu thuyết Harry Potter, "Harry Potter và Đứa Trẻ bị Nguyền rủa" phần I và II là kịch bản gốc của vở kịch mới của tác giả Rowling cùng Jack Thorne và John Tiffany.
Từ những nhân vật quen thuộc trong bộ Harry Potter, kịch bản nói về cuộc phiêu lưu của những hậu duệ, sự can thiệp vào dòng thời gian đã gây ra những thay đổi không ngờ cho tương lai tưởng chừng đã yên ổn sau khi vắng bóng chúa tể Voldermort.
Câu chuyện lấy bối cảnh 19 năm sau khi Harry Potter là Giám đốc Sở Thần Sáng tại Bộ Pháp Thuật và đã có ba con cùng vợ là Ginny Weasley, em gái của người bạn thân là Ron Weasley. Albus Severus Potter là đứa con duy nhất của Harry thừa hưởng đôi mắt màu xanh nước biển của bà nội Lily. và Albus Potter bắt đầu nhập học ở Hogwarts cùng Scorpius Malfoy và Rose Granger-Weasley.
Phần này sẽ đưa bạn quay trở lại trường Hogwarts, quay trở lại những chuyến phiêu lưu của Harry, quay trở lại thế giới phép thuật quyến rũ.',
'HarryPotter12.gif',2018/03/12,40,3,2);

INSERT INTO SACH VALUES
(N'Harry Potter và Hòn Đá Phù Thủy', 185000,
N'Khi một lá thư được gởi đến cho cậu bé Harry Potter bình thường và bất hạnh, cậu khám phá ra một bí mật đã được che giấu suốt cả một thập kỉ. Cha mẹ cậu chính là phù thủy và cả hai đã bị lời nguyền của Chúa tể Hắc ám giết hại khi Harry mới chỉ là một đứa trẻ, và bằng cách nào đó, cậu đã giữ được mạng sống của mình. 
Thoát khỏi những người giám hộ Muggle không thể chịu đựng nổi để nhập học vào trường Hogwarts, một trường đào tạo phù thủy với những bóng ma và phép thuật, Harry tình cờ dấn thân vào một cuộc phiêu lưu đầy gai góc khi cậu phát hiện ra một con chó ba đầu đang canh giữ một căn phòng trên tầng ba. 
Rồi Harry nghe nói đến một viên đá bị mất tích sở hữu những sức mạnh lạ kì, rất quí giá, vô cùng nguy hiểm, mà cũng có thể là mang cả hai đặc điểm trên.',
'HarryPotter1.jpg', '2017-06-20', 30, 3, 2);

INSERT INTO SACH VALUES
(N'Harry Potter và Hoàng Tử Lai', 195000,
N'Đây là năm thứ 6 của Harry Potter tại trường Hogwarts. Trong lúc những thế lực hắc ám của Voldemort gieo rắc nỗi kinh hoàng và sợ hãi ở khắp nơi, mọi chuyện càng lúc càng trở nên rõ ràng hơn đối với Harry, rằng cậu sẽ sớm phải đối diện với định mệnh của mình. Nhưng liệu Harry đã sẵn sàng vượt qua những thử thách đang chờ đợi phía trước?
Trong cuộc phiêu lưu tăm tối và nghẹt thở nhất của mình, J.K.Rowling bắt đầu tài tình tháo gỡ từng mắc lưới phức tạp mà cô đã mạng lên, cũng là lúc chúng ta khám phá ra sự thật về Harry, cụ Dumblebore, thầy Snape và, tất nhiên, Kẻ Chớ Gọi Tên Ra…','HarryPotter6.jpg', 
2017-06-20, 20, 3, 2);

-- Paulo Coelho
INSERT INTO SACH VALUES
(N'Nhà Giả Kim', 89000,
N'Một hành trình kỳ diệu khám phá kho báu của chính mình. Cuốn sách triết lý sâu sắc về ước mơ và định mệnh.',
'NhagiaKim.jpg', '2019-01-01', 15, 2, 3);

INSERT INTO SACH VALUES
(N'Cẩm Nang Của Người Chiến Binh Ánh Sáng', 40000,
N'Trong mỗi chúng ta đều có một người chiến binh ánh sáng. Trong mỗi chúng ta đều có một giấc mơ cần trở thành hiện thực. Bạn hãy đọc cuốn sách này của Paulo Coelho để khơi dậy người chiến binh ánh sáng tràn đầy niềm tin vào bản thân và vũ trụ trong mỗi tâm mình, để sống cuộc đời mơ ước, để làm những gì tâm hồn mách bảo. 
“Khi ai đó quyết chí muốn điều gì thì toàn vũ trụ chung sức giúp anh ta đạt được điều ấy”',
'ChienBinhAnhSang.jpg', '2020-07-10', 10, 2, 14);

-- Vân Võ
INSERT INTO SACH VALUES
(N'Tình Yêu Thứ Ba', 59000,
N'Câu chuyện tình nhẹ nhàng, sâu sắc của người trẻ, nơi niềm tin và yêu thương được thử thách bởi cuộc sống hiện đại.',
'TinhYeuThuBa.jpg', '2019-08-22', 12, 3, 8);

INSERT INTO SACH VALUES
(N'Thằng Huyện - Con Hàu', 59000,
N'Thời cuộc nhiễu nhương, trăm đường yêu nước. Có kẻ hộ gia bằng giáo, có người vệ quốc bằng đao, có bậc anh hào thà thác vinh còn hơn sống nhục. Thế nhưng cũng có những kẻ thà rước vào oan nhục ngàn đời cũng không buông tay bỏ rơi cái gốc.

Câu chuyện lấy bối cảnh ở làng Ẻn xứ Thanh Ba, nơi phép vua còn thua lệ làng. Trong cái làng nhỏ đó có một ông Huyện với một nàng hầu, danh tiếng xấu xa chẳng ai bằng, kẻ bán nước cầu vinh, kẻ bán thân xin tội. Thế nhưng câu chuyện qua miệng đời, thực hư thế nào có mấy ai tỏ tường.','Thanghuyenconhau.jpg', '2019-08-22',
15, 3, 3);

-- Tô Hoài
INSERT INTO SACH VALUES
(N'Dế Mèn Phiêu Lưu Ký', 50000,
N'“Một con dế đã từ tay ông thả ra chu du thế giới tìm những điều tốt đẹp cho loài người. Và con dế ấy đã mang tên tuổi ông đi cùng trên những chặng đường phiêu lưu đến với cộng đồng những con vật trong văn học thế giới, đến với những xứ sở thiên nhiên và văn hóa của các quốc gia khác. Dế Mèn Tô Hoài đã lại sinh ra Tô Hoài Dế Mèn, một nhà văn trẻ mãi không già trong văn chương...”',
'Demenplk.jpg', '2017-10-15', 25,3, 6);

INSERT INTO SACH VALUES
(N'Chiều Chiều', 165000,
N'Chiều chiều là câu chuyện kể ôn lại kỷ niệm của một con người đã đi dọc chiều dài lịch sử. Tô Hoài đưa chúng ta về một làng quê Bắc bộ với những câu chuyện từ “cải cách ruộng đất” rồi “sửa sai”, từ “thời bao cấp”, “làm hợp tác xã” đến “đổi mới sang kinh tế thị trường”… Cả một thời kỳ lịch sử đầy biến động hiện lên chân thực với bao số phận, bao cảm xúc buồn vui lẫn những điều oái ăm, ngang trái….',
'ChieuChieu.jpg', '2014-03-25', 20, 3, 3);

-- Nguyễn Huy Thiệp
INSERT INTO SACH VALUES
(N'Tướng Về Hưu', 65000,
N'Một truyện ngắn phản ánh sâu sắc xã hội Việt Nam thời hậu chiến, đầy triết lý và hiện thực sắc lạnh.',
'TuongVeHuu.jpg', '2017-10-15', 25, 3, 7);

-- Trần Đức Tiến
INSERT INTO SACH VALUES
(N'Xóm Bờ Giậu', 125000,
N'Xóm Bờ Giậu gần gũi thân thuộc, mang trong mình hình bóng của bao làng quê yêu dấu. Đến Xóm Bờ Giậu, bạn sẽ được làm quen với những nhân vật rất thú vị: cụ giáo Cóc thông thái về hưu, nhạc sĩ trứ danh Dế Lửa, chú thợ săn nhiều tâm sự Thằn Lằn, cô người mẫu đáng yêu Ốc Sên, chuyên gia dự báo thời tiết Tắc Kè, vận động viên bận bịu Nhái Xanh, cô nàng điệu đàng Hoa Cúc Áo, thi sĩ nghiệp dư lãng mạn Dế Còm... Nhân vật nào cũng dễ thương. Và nhân vật nào cũng sẵn sàng kể cho bạn nghe một câu chuyện hấp dẫn.',
'Xombogiau.jpg', '2018-04-12', 15, 5, 1);

INSERT INTO SACH VALUES
(N'A Lô! Cậu Đấy À?', 140000,
N'“Con người là một phần của thiên nhiên, không thể sống tách rời thiên nhiên. Nhà văn phải biết cách nghe thấy tiếng hát của con Thằn Lằn, tiếng thở dài của con Ốc Sên, và đọc được bài thơ của con Dế trên chiếc lá mít... Hơn thế, còn phải làm cho bạn đọc nhỏ tuổi tin vào những điều đó, để cùng học cách “nghe” và “đọc” nhiều thứ khác. Đấy là thử thách khó vượt qua nhất, nhưng cũng là tham vọng lớn lao của những người viết truyện đồng thoại.” - Trần Đức Tiến',
'AloCauDayA.jpg', '2018-04-12', 15, 5, 1);

-- Muriel Barbery
INSERT INTO SACH VALUES
(N'Sự Tao Nhã Của Nhím', 105000,
N'Một tiểu thuyết triết lý sâu sắc, kể về cuộc sống nội tâm của một bà lao công và cô bé thiên tài trong cùng một chung cư Pháp.',
'SuTaoNha.jpg', '2020-11-05', 10, 3, 1);

INSERT INTO SACH VALUES
(N'A Single Rose - Một bông hồng đơn độc', 145000,
N'A Single Rose bắt đầu bằng một câu chuyện thần thoại Trung Quốc về một hoàng tử và một cánh đồng hoa. Mỗi chương đều bắt đầu theo cùng một cách: với một câu chuyện Đông Á về hệ thực vật, thơ ca và vẻ đẹp. Câu chuyện chính liên quan đến Rose; một người phụ nữ Pháp ở Kyoto. ',
'SuTaoNha.jpg', '2020-11-05', 15, 3, 4);


-- Ngô Tất Tố
INSERT INTO SACH VALUES
(N'Tắt Đèn', 59000,
N'"Tắt Đèn" là câu chuyện đầy cảm xúc về đời sống của một gia đình nông dân nghèo trong thời kỳ phong kiến. Ngô Tất Tố đã khéo léo khắc họa sự đấu tranh và đau khổ của các nhân vật, từ những khó khăn trong cuộc sống hàng ngày đến những mâu thuẫn xã hội và sự bất công. Tác phẩm không chỉ phản ánh những vấn đề xã hội mà còn mở ra những góc nhìn sâu sắc về tâm lý con người và các khát vọng vươn lên trong cuộc sống.',
'TatDen.jpg', '2016-09-01', 40, 3, 7);

INSERT INTO SACH VALUES
(N'Việc Làng (Phụng Sự)', 45000,
N'Từ ngạc nhiên này đến bất ngờ khác, phóng sự Việc Làng giới thiệu với độc giả, nhất là bạn đọc trẻ ở các vùng miền khác trong nước ta về cuộc đời và con người trong bức tranh làng quê Bắc Bộ.

Việc Làng lôi cuốn bạn đọc với khối lượng hiểu biết sâu rộng về bộ mặt làng quê, được ghi lại sinh động với biết bao “phong tục, hủ tục” , phổ biến trong cuộc sống của làng quê Việt Nam cách đây non thế kỷ.',
'ViecLang.jpg', '2016-09-01', 40, 3, 7);

--Riichiro Inagaki
INSERT INTO SACH VALUES(N'DR. STONE - TẬP 1', 25000,N'Ngày nọ, cậu học sinh cấp Ba Taiju bị cuốn vào một hiện tượng kì bí khiến toàn nhân loại hóa đá.

Khoảng 3.700 năm sau, Taiju tỉnh dậy và hội ngộ người bạn thân Senku đã hồi sinh trước đó.

Bằng “sức trâu” của Taiju và “đầu óc” của Senku, cả hai người đã cùng nhau bắt tay vào xây dựng lại nền văn minh từ con số 0 ở thế giới đá...

Một tác phẩm cực kì ấn tượng thuộc dòng thương hiệu Manga Shonen Jump trứ danh!! Ngoài những điểm đặc trưng vốn có của dòng truyện Jump, bạn sẽ phải trầm trồ đầy kinh ngạc trước những kiến thức hóa học, vật lí, sinh học và toán học... được lồng ghép vô cùng khéo léo và tự nhiên!!

Hãy cùng bước vào chuyến phiêu lưu sinh-tồn-viễn-tưởng vô tiền khoáng hậu với Dr. Stone nhé!!','SACH-dr-stone-tap-1.jpg',2021/4/2,20,4,1)

INSERT INTO SACH VALUES(N'DR. STONE - TẬP 2', 25000,N'Senku cùng Taiju và Yuzuriha gấp gáp tiến hành điều chế thuốc súng. Giữa lúc ấy, đột nhiên một cột khói bốc lên từ phía xa. Senku tin rằng vẫn còn những người khác trên thế giới này nên đã chấp nhận mạo hiểm và đốt lửa hiệu. Mặt khác, họ phải đối mặt với tình thế ngàn cân treo sợi tóc khi bị Tsukasa truy đuổi nhằm ngăn chặn Senku điều chế thuốc súng…!?

RIICHIRO INAGAKI “Khác với họa sĩ truyện tranh, tác giả nguyên tác không có trợ lí. Lúc nào cũng chỉ một mình lặng lẽ ngồi viết lách. Cô đơn lắm! Nói chung, làm việc mà xung quanh chẳng có ai buồn tẻ vô cùng! Giống Senku, lầm lũi làm việc giữa thế gian… Tôi mà bị đẩy vào tình cảnh như vậy thì chắc chẳng chịu nổi mất. Làm tốt lắm, Senku!”
BOICHI “Đối với tôi, các bản phác thảo hàng tuần nhận được từ tác giả Inagaki thật sự là niềm hạnh phúc lớn lao. Tôi rất thích vẽ về thiên nhiên. Tuần nào tôi cũng phải tưởng tượng ra các loài đại thụ, tầm gửi và rêu. Và còn phải tưởng tượng ra Senku đang sống giữa thiên nhiên ấy nữa. Cậu ấy là một chàng trai đơn độc giữa thế giới bao la. Là một người đang sống trong thế giới truyện tranh Nhật Bản rộng lớn, tôi rất đồng cảm với cậu ấy. Này Senku!!! Đời người chính là một cuộc trao đổi công bằng giữa nỗi cô đơn và sự vĩ đại.”.’',
'SACH-dr-stone-tap-2.jpg',2021/2/8,20,4,1)

-- Nguyễn Nhật Ánh
INSERT INTO SACH VALUES
(N'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', 78000,
N'Những câu chuyện nhỏ xảy ra ở một ngôi làng nhỏ: chuyện người, chuyện cóc, chuyện ma, chuyện công chúa và hoàng tử , rồi chuyện đói ăn, cháy nhà, lụt lội,... Bối cảnh là trường học, nhà trong xóm, bãi tha ma. Dẫn chuyện là cậu bé 15 tuổi tên Thiều. Thiều có chú ruột là chú Đàn, có bạn thân là cô bé Mận. Nhưng nhân vật đáng yêu nhất lại là Tường, em trai Thiều, một cậu bé học không giỏi. 
Thiều, Tường và những đứa trẻ sống trong cùng một làng, học cùng một trường, có biết bao chuyện chung. Chúng nô đùa, cãi cọ rồi yêu thương nhau, cùng lớn lên theo năm tháng, trải qua bao sự kiện biến cố của cuộc đời.',
'TTHVTCX.jpg', '2015-09-01', 50, 3, 2);

INSERT INTO SACH VALUES
(N'Mắt Biếc', 82000,
N'“Tôi gửi tình yêu cho mùa hè, nhưng mùa hè không giữ nổi. Mùa hè chỉ biết ra hoa, phượng đỏ sân trường và tiếng ve nỉ non trong lá. Mùa hè ngây ngô, giống như tôi vậy. Nó chẳng làm được những điều tôi ký thác. Nó để Hà Lan đốt tôi, đốt rụi. 
Trái tim tôi cháy thành tro, rơi vãi trên đường về.”… Bởi sự trong sáng của một tình cảm, bởi cái kết thúc buồn, rất buồn khi xuyên suốt câu chuyện vẫn là những điều vui, buồn lẫn lộn… ',
'MatBiec.jpg', '2018-02-14', 35, 3, 2);

-- Thích Nhất Hạnh
INSERT INTO SACH VALUES
(N'Phép Lạ Của Sự Tỉnh Thức', 99000,
N'Phép Lạ Của Sự Tỉnh Thức

Là những phương pháp nhiệm màu thực tập thiền quán trong đời sống hàng ngày. Qua tập sách này, thầy Thích Nhất Hạnh mong muốn chúng ta cảm nhận được hạnh phúc trong từng giây phút hiện tại, trong từng công việc hiện tại, toàn tâm toán ý mà sống. Từ một bác sĩ, một người công nhân, một thợ may, một người thợ tiện, một bà nội trợ đến một kỹ sư…. Tất cả những công việc thường nhật đó bỗng trở nên phép lạ khi thắp nên ánh sáng chánh niệm..',
'PhepLaTinhThuc.jpg', '2021-01-01', 20, 2, 10);

INSERT INTO SACH VALUES
(N'How To Walk - Đi Sao Cho Vững Vàng', 72000,
N'How to walk - Đi sao cho vững vàng là cuốn sách nằm trong bộ Mindfulness Essentials của Thiền sư Thích Nhất Hạnh. Bộ sách là những hướng dẫn đơn giản, rõ ràng của Thiền sư Thích Nhất Hạnh về cách thực tập chánh niệm thông qua các hoạt động thường ngày. Tuy đơn giản, nhưng chúng cũng hàm chứa những nguyên lý uyên thâm về chánh niệm của đạo Bụt.',
'HowtoWalk.jpg', '2020-05-10', 18, 2, 4);

--Jim Collins
INSERT INTO SACH VALUES
(N'Vĩ Đại Do Lựa Chọn', 140000,
N'Kết quả nghiên cứu sẽ gây bất ngờ cho nhiều nhà lãnh đạo các tổ chức đọc quyển sách này: Những nhà lãnh đạo của các công ty vĩ đại không sáng tạo hơn, không có tầm nhìn xa hơn, không có cá tính hơn, không có vận may hơn, không thích tìm kiếm rủi ro hơn, không anh hùng hơn, và không có khuynh hướng thực hiện những nước cờ lớn, táo bạo hơn. Nhưng họ đã lèo lái được công ty họ qua những lúc khó khăn để luôn trường tồn, bởi vì họ sống và làm việc theo ba yếu tố cân bằng nhau: kiên định với nguyên tắc, sáng tạo theo kinh nghiệm và biết sợ hãi một cách hữu ích.

Quyển sách phù hợp với tầng lớp doanh nhân và lãnh đạo các công ty Việt Nam, những người nghiên cứu về kinh doanh, đang trong quá trình lèo lái con thuyền công ty vươn lên sau khủng hoảng và hướng tới vĩ đại vĩnh cửu.',
'ViDaiDoLuaChon.jpg', '2023-03-06', 30, 1, 2);

INSERT INTO SACH VALUES
(N'Xây Dựng Để Trường Tồn', 185000,
N'“Đây không phải là cuốn sách viết về các nhà lãnh đạo có tầm nhìn xa trông rộng, có sức thu hút lớn. Cũng không phải là cuốn sách viết về các sản phẩm, các khái niệm sản phẩm hay những thấu hiểu về thị trường mang tính chất có tầm nhìn xa. Cuốn sách này cũng không trình bày về các hoài bão của một doanh nghiệp. Mà đây chính là cuốn sách viết về cái gì đó quan trọng, trường tồn hơn nhiều - những công ty hàng đầu có tầm nhìn xa, hoài bão lớn”… (Trích giới thiệu của tác giả).',
'XayDungDeTruongTon.jpg', '2022-05-26', 25, 1, 2);

--Bộ GD&ĐT
INSERT INTO SACH VALUES(N'BỘ SÁCH GIÁO KHOA LỚP 7- SÁCH BÀI HỌC (BỘ 12 CUỐN)', 134000,N'Sách giáo khoa là vật dụng quan trọng, không thể thiếu đối với quá trình học tập của học sinh. Sách giáo khoa là loại sách cung cấp kiến thức, được biên soạn với mục đích dạy và học tại trường học. 
 
Bộ Sách Giáo Khoa Lớp 7 (Bộ 12 Cuốn) tập hợp đầy đủ các môn học cần thiết phục vụ cho học sinh lớp 7 được biên soạn theo chương trình chuẩn của Bộ Giáo dục và Đào tạo. Bộ sách cung cấp kiến thức từ cơ bản đến nâng cao với các môn học :
Toán 7 Tập 1
Toán 7 Tập 2
Vật Lí 7
Công Nghệ 7
Ngữ Văn 7 Tập 1
Ngữ Văn 7 Tập 2
Lịch Sử 7
Địa Lí 7
Giáo Dục Công Dân 7
Âm Nhạc Và Mĩ Thuật 7
Tiếng Anh 7
Sinh Học 7','bo-SACH-giao-khoa-lop-7.jpg' ,2020/12/12 , 12, 6,4)

INSERT INTO SACH VALUES(N'BỘ SÁCH GIÁO KHOA LỚP 12 - SÁCH BÀI HỌC (BỘ 14 CUỐN)', 180000,N'Bộ Sách Giáo Khoa Lớp 12 (Bộ 14 Cuốn):
Cung cấp các kiến thức từ cơ bản đến nâng cao cho các em học sinh
Được biên soạn theo quy chuẩn của Bộ Giáo dục và Đào tạo
Hệ thống kiến thức khoa học, chính xác, được trình bày theo một trình tự logic chặt chẽ
Bộ sách giáo khoa chuẩn lớp 12 do Bộ Giáo dục quy định đang được nhiều học sinh cũng như các bậc phụ huynh có con em mới bước vào lớp 12 quan tâm.

Bộ Sách Giáo Khoa Lớp 12 (Chuẩn) gồm 14 cuốn:
Giải Tích 12
Hình Học 12
Vật Lí 12
Hóa Học 12
Sinh Học 12
Công Nghệ 12
Ngữ Văn 12 Tập 1
Ngữ Văn 12 Tập 2
Giáo Dục Công Dân
Tin Học 12
Tiếng Anh 12
Lịch Sử 12
Địa Lí 12
Giáo Dục Quốc Phòng - An Ninh 12','bo-SACH-giao-khoa-12.jpg' ,2020/12/12 , 12,6,4)

INSERT INTO SACH VALUES (N'BỘ SÁCH GIÁO KHOA LỚP 3 (BỘ 13 CUỐN BÀI HỌC + BÀI TẬP)',115100,N'Bộ sách giáo khoa chuẩn lớp 3 do Bộ Giáo dục quy định đang được nhiều học sinh cũng như các bậc phụ huynh có con em chuẩn bị bước vào lớp 3 quan tâm.

Bộ sách bao gồm những đầu sách tối thiểu và sách bài tập được sử dụng trong giảng dạy và học tập trong toàn quốc.
Tiếng Việt 3 Tập 1
Tiếng Việt 3 Tập 2
Toán 3
Tự Nhiên Và Xã Hội 3
Tập Viết 3 Tập 1
Tập Viết 3 Tập 2
Vở Bài Tập Tiếng Việt 3 Tập 1
Vở Bài Tập Tiếng Việt 3 Tập 2
Vở Bài Tập Toán 3 Tập 1
Vở Bài Tập Toán 3 Tập 2
Vở Bài Tập Tự Nhiên Và Xã Hội 3
Vở Bài Tập Đạo Đức 3
Tập Bài Hát 3','bo-SACH-giao-khoa-lop-3.jpg' ,2020/12/12 , 12, 6,4)
--Paul Kalanithi
INSERT INTO SACH VALUES
(N'Khi Hơi Thở Hóa Thinh Không', 87000,
N'Khi hơi thở hóa thinh không là tự truyện của một bác sĩ bị mắc bệnh ung thư phổi. Trong cuốn sách này, tác giả đã chia sẻ những trải nghiệm từ khi mới bắt đầu học ngành y, tiếp xúc với bệnh nhân cho tới khi phát hiện ra mình bị ung thư và phải điều trị lâu dài.

Kalanithi rất yêu thích văn chương nên câu chuyện của anh đã được thuật lại theo một phong cách mượt mà, dung dị và đầy cảm xúc. Độc giả cũng được hiểu thêm về triết lý sống, triết lý nghề y của Kalanithi, thông qua ký ức về những ngày anh còn là sinh viên, rồi thực tập, cho đến khi chính thức hành nghề phẫu thuật thần kinh. “Đối với bệnh nhân và gia đình, phẫu thuật não là sự kiện bi thảm nhất mà họ từng phải đối mặt và nó có tác động như bất kỳ một biến cố lớn lao trong đời. Trong những thời điểm nguy cấp đó, câu hỏi không chỉ đơn thuần là sống hay chết mà còn là cuộc sống nào đáng sống.” – Kalanithi luôn biết cách đưa vào câu chuyện những suy nghĩ sâu sắc và đầy sự đồng cảm như thế.',
'Khthtk.jpg', 2020/06/24, 50, 7, 9);

--Linda Sue Park
INSERT INTO SACH VALUES
(N'Lấy Nước Đường Xa', 99000,
N'Lấy nước đường xa - Cuốn tiểu thuyết dựa trên một câu chuyện có thật tại Châu Phi. Hai câu chuyện đan xen nhau kể về hai đứa trẻ tại Sudan – sống ở hai thời kỳ khác nhau – hai bộ tộc đối lập nhau và hai cuộc “đấu tranh” không giống nhau.

Câu chuyện của Nya và Salva đã giao thoa và kết nối với nhau. Nya kết thúc hành trình 8 tiếng mỗi ngày đi lấy nước cho gia đình và được đến trường học. Còn hành trình của Salva thì vẫn tiếp tục với một diễn biến khác nhiều ý nghĩa và tươi sáng hơn!',
'Khthtk.jpg', 2022/05/05, 20, 7, 9);
--Albert Rutherford
INSERT INTO SACH VALUES(N'Nghệ Thuật Tư Duy Phản Biện',129000 ,N'Tư duy phản biện là một phần trong cuộc sống hằng ngày, bạn cần nắm lấy và phát triển từ nó. Thực hiện nghiên cứu của bạn, tìm kiếm các nguồn thông tin tốt, đưa ra lập luận của bạn và cân nhắc phản bác, cân nhắc xem bạn có đưa ra giả định hay không và đừng vội vàng đưa ra quyết định nếu bạn không hài lòng với thông tin bạn thu thập được.

Bạn có phải là một y tá phẫu thuật hay thậm chí làm việc trong lĩnh vực y tế, thì bạn cũng có thể thực hiện một số hình thức thử nghiệm. Việc đưa ra quyết định về những việc cần xử lý tại nơi làm việc và ở nhà dựa trên mức độ ưu tiên và mức độ khẩn cấp của hoàn cảnh.

Nếu bạn có một dự án đến hạn vào ngày mai, dự án đó sẽ được ưu tiên hơn dự án đến hạn vào tháng sau. Đứa con mới sinh của bạn cần được vỗ về trước khi giúp đứa con lớn hơn làm bài tập về nhà và giúp ra những quyết định dựa trên khả năng suy nghĩ chín chắn của mình và cuốn sách này đã chỉ ra cách phát triển và nâng cao những kỹ năng đó để bạn được trao quyền đạt được nhiều thành quả và thành công hơn.

Bây giờ bạn đã có các kỹ năng cần thiết để trở thành một nhà tư tưởng phản biện hiệu quả, hãy bắt đầu sử dụng các kỹ năng mới phát triển của bạn ngay hôm nay. Thách thức bản thân đánh giá một cách nghiêm túc niềm tin của bạn và tự quyết định xem bạn có thực sự hiểu được ý nghĩa và lịch sử đằng sau những suy nghĩ và quan điểm của mình hay không. Bạn có thể hoặc không thay đổi quan điểm của mình, nhưng ít nhất bạn chắc chắn sẽ biết mình đang đứng ở đâu và tại sao. Hãy bắt đầu áp dụng lập luận phản biện trong cuộc sống hằng ngày của bạn khi bạn đưa ra quyết định và đưa ra kết luận cả lớn và nhỏ.

Trong cuộc đời mỗi người, không ai có thể tránh được những tổn thương về mặt cảm xúc, nhưng nếu tâm trí và cảm xúc phân minh, bạn sẽ có thể lùi lại một bước trước những cảm xúc cá nhân để giải quyết tình huống theo cách có lợi nhất cho bạn. Đồng thời, bạn sẽ có thể sử dụng kỹ năng tư duy phản biện để thách thức các ý tưởng và lý tưởng. “Nghệ thuật tư duy phản biện” sẽ giúp bạn chuẩn bị sẵn bộ tư duy khẩn cấp của riêng mình, qua đó đưa ra những quyết định hợp lý, thấu đáo dựa trên bằng chứng thực tế.

Hãy nghĩ đến coi tư duy phản biện như một cơ hội để tương tác với những người khác và tìm hiểu quan điểm của họ. Đánh giá những gì người khác nói và xem xét các nguồn thông tin để quyết định xem chúng có xứng đáng hay không. “Nghệ thuật tư duy phản biện” là một tài liệu tuyệt vời giúp bạn học được những kỹ năng đó và bạn có thể tham khảo lại khi cần. Hãy nhớ rằng, hơn bất cứ điều gì, hãy rèn luyện kỹ năng tư duy phản biện của bạn, và bạn không bao giờ có thể sai lầm.

Luyện tập làm nên sự hoàn hảo. Đừng ngần ngại triển khai các kỹ năng bạn đã học được trong cuốn sách này ngay hôm nay.','image_220921.jpg' ,2020/12/12 , 12, 2,9)


INSERT INTO VIETSACH VALUES(1,1,N'')
INSERT INTO VIETSACH VALUES(1,2,N'')
INSERT INTO VIETSACH VALUES(1,3,N'')
INSERT INTO VIETSACH VALUES(2,4,N'')
INSERT INTO VIETSACH VALUES(2,5,N'')
INSERT INTO VIETSACH VALUES(3,6,N'')
INSERT INTO VIETSACH VALUES(3,7,N'')
INSERT INTO VIETSACH VALUES(4,8,N'')
INSERT INTO VIETSACH VALUES(4,9,N'')
INSERT INTO VIETSACH VALUES(5,10,N'')

INSERT INTO VIETSACH VALUES(6,11,N'')
INSERT INTO VIETSACH VALUES(6,12,N'')
INSERT INTO VIETSACH VALUES(7,13,N'')
INSERT INTO VIETSACH VALUES(7,14,N'')
INSERT INTO VIETSACH VALUES(8,15,N'')
INSERT INTO VIETSACH VALUES(8,16,N'')
INSERT INTO VIETSACH VALUES(9,17,N'')
INSERT INTO VIETSACH VALUES(9,18,N'')
INSERT INTO VIETSACH VALUES(10,19,N'')
INSERT INTO VIETSACH VALUES(10,20,N'')

INSERT INTO VIETSACH VALUES(11,21,N'')
INSERT INTO VIETSACH VALUES(11,22,N'')
INSERT INTO VIETSACH VALUES(12,23,N'')
INSERT INTO VIETSACH VALUES(12,24,N'')
INSERT INTO VIETSACH VALUES(13,25,N'')
INSERT INTO VIETSACH VALUES(13,26,N'')
INSERT INTO VIETSACH VALUES(13,27,N'')
INSERT INTO VIETSACH VALUES(14,28,N'')
INSERT INTO VIETSACH VALUES(15,29,N'')
INSERT INTO VIETSACH VALUES(16,30,N'')


ALTER TABLE VIETSACH
DROP CONSTRAINT FK_SACH_VIETSACH;

ALTER TABLE VIETSACH
ADD CONSTRAINT FK_SACH_VIETSACH FOREIGN KEY (Masach)
REFERENCES SACH (Masach)
ON DELETE CASCADE;

GO
CREATE OR ALTER PROCEDURE Sach_TimKiem
    @Keyword NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SET @Keyword = ISNULL(@Keyword, '');

    SELECT DISTINCT S.*
    FROM SACH S
    LEFT JOIN NHAXUATBAN NXB ON S.MaNXB = NXB.MaNXB
    LEFT JOIN VIETSACH VS ON S.Masach = VS.Masach
    LEFT JOIN TACGIA TG ON VS.MaTG = TG.MaTG
    WHERE 
        S.Tensach LIKE N'%' + @Keyword + '%'
        OR TG.TenTG LIKE N'%' + @Keyword + '%'
        OR NXB.TenNXB LIKE N'%' + @Keyword + '%'
END
