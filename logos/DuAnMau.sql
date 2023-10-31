CREATE DATABASE Edusys
GO
USE Edusys
GO
CREATE TABLE NhanVien(
	MaNV nvarchar(50) NOT NULL,
	MatKhau nvarchar(50) NOT NULL,
	HoTen nvarchar(50) NOT NULL,
	VaiTro bit NOT NULL DEFAULT 0,
	PRIMARY KEY(MaNV)
)
GOCREATE TABLE ChuyenDe(
	MaCD nchar(5) NOT NULL,
	TenCD nvarchar(50) NOT NULL,
	HocPhi float NOT NULL DEFAULT 0,
	ThoiLuong int NOT NULL DEFAULT 30,
	Hinh nvarchar(50) NOT NULL DEFAULT 'chuyen-de.png',
	MoTa nvarchar(255) NOT NULL,
	PRIMARY KEY(MaCD),
	UNIQUE(TenCD),
	CHECK(HocPhi >= 0 AND ThoiLuong > 0)
)
GO
CREATE TABLE NguoiHoc(
	MaNH nchar(7) NOT NULL,
	HoTen nvarchar(50) NOT NULL,
	NgaySinh date NOT NULL,
	GioiTinh bit NOT NULL DEFAULT 0,
	DienThoai nvarchar(50) NOT NULL,
	Email nvarchar(50) NOT NULL,
	GhiChu nvarchar(max) NULL,
	MaNV nvarchar(50) NOT NULL,
	NgayDK date NOT NULL DEFAULT getdate(),
	PRIMARY KEY(MaNH)
)
GO
CREATE TABLE KhoaHoc(
	MaKH int IDENTITY(1,1) NOT NULL,
	MaCD nchar(5) NOT NULL,
	HocPhi float NOT NULL DEFAULT 0,
	ThoiLuong int NOT NULL DEFAULT 0,
	NgayKG date NOT NULL,
	GhiChu nvarchar(50) NULL,
	MaNV nvarchar(50) NOT NULL,
	NgayTao date NOT NULL DEFAULT getdate(),
	PRIMARY KEY(MaKH),
	CHECK(HocPhi >= 0 AND ThoiLuong > 0),
	FOREIGN KEY (MaCD) REFERENCES ChuyenDe(MaCD) ON UPDATE CASCADE,
	FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV) ON UPDATE CASCADE
)
GOCREATE TABLE HocVien(
	MaHV int IDENTITY(1,1) NOT NULL,	MaKH int NOT NULL,
	MaNH nchar(7) NOT NULL,
	Diem float NOT NULL,
	PRIMARY KEY(MaHV),
	UNIQUE(MaKH, MaNH),
	FOREIGN KEY (MaKH) REFERENCES KhoaHoc(MaKH) ON DELETE CASCADE,
	FOREIGN KEY (MaNH) REFERENCES NguoiHoc(MaNH) ON UPDATE CASCADE
)GO--Thêm mới: INSERT INTO NhanVien (MaNV, MatKhau, HoTen, VaiTro) VALUES (?, ?, ?, ?)
--Cập nhật theo mã: UPDATE NhanVien SET MatKhau=?, HoTen=?, VaiTro=? WHERE MaNV=?
--Xóa theo mã: DELETE FROM NhanVien WHERE MaNV=?
--Truy vấn tất cả: SELECT * FROM NhanVien
--Truy vấn theo mã: SELECT * FROM NhanVien WHERE MaNV=?INSERT INTO NhanVien(MaNV, MatKhau, HoTen, VaiTro) VALUES(N'TLHa', N'12345', N'Tô Lục Hạ', 0),(N'MQDi', N'manhquydi', N'Mạnh Quy Di', 1),(N'CQTrieu', N'45678', N'Cố Quân Triêu', 0),(N'DMoc', N'damoc', N'Dạ Mộc', 1),(N'MLUyen', N'maclamuyen', N'Mặc Lâm Uyên', 0)GO--Thêm mới: INSERT INTO ChuyenDe (MaCD, TenCD, HocPhi, ThoiLuong, Hinh, MoTa) VALUES (?, ?,?, ?, ?, ?)
--Cập nhật theo mã: UPDATE ChuyenDe SET TenCD=?, HocPhi=?, ThoiLuong=?, Hinh=?, MoTa=? WHERE MaCD=?
--Xóa theo mã: DELETE FROM ChuyenDe WHERE MaCD=?
--Truy vấn tất cả: SELECT * FROM ChuyenDe
--Truy vấn theo mã: SELECT * FROM ChuyenDe WHERE MaCD=?INSERT INTO ChuyenDe (MaCD, TenCD, HocPhi, ThoiLuong, Hinh, MoTa) VALUES (N'JAV01', N'Lập trình Java cơ bản', 250, 90, N'GAME.png', N'JAV01 - Lập trình Java cơ bản'),(N'JAV02', N'Lập trình Java nâng cao', 300, 90, N'HTCS.jpg', N'JAV02 - Lập trình Java nâng cao'),(N'JAV03', N'Lập trình mạng với Java', 200, 70, N'INMA.jpg', N'JAV03 - Lập trình mạng với Java'),(N'JAV04', N'Lập trình desktop với Swing', 200, 70, N'ADAV.jpg', N'JAV04 - Lập trình desktop với Swing'),(N'PRO01', N'Dự án với công nghệ MS.NET MVC', 300, 90, N'MOWE.png', N'PRO01 - Dự án với công nghệ MS.NET MVC')GO--Thêm mới: INSERT INTO NguoiHoc (MaNH, HoTen, NgaySinh, GioiTinh, DienThoai, Email,GhiChu, MaNV, NgayDK) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
--Cập nhật theo mã: UPDATE NguoiHoc SET HoTen=?, NgaySinh=?, GioiTinh=?, DienThoai=?, Email=?,GhiChu=?, MaNV=?, NgayDK=? WHERE MaNH=?--Xóa theo mã: DELETE FROM NguoiHoc WHERE MaNH=?
--Truy vấn tất cả: SELECT * FROM NguoiHoc
--Truy vấn theo mã: SELECT * FROM NguoiHoc WHERE MaNH=?INSERT INTO NguoiHoc (MaNH, HoTen, NgaySinh, GioiTinh, DienThoai, Email,GhiChu, MaNV, NgayDK) VALUES(N'PS10001', N'Dạ Thất Thất', CAST(0xAF170B00 AS Date), 0, N'0928768265', N'PS10001@fpt.edu.vn', N'0928768265 - Dạ Thất Thất', N'TLHạ', CAST(0xAF170B00 AS Date)),(N'PS10002', N'Lâm Phi Lộc', CAST(0xC6190B00 AS Date), 0, N'0968095685', N'PS10002@fpt.edu.vn', N'0968095685 - Lâm Phi Lộc', N'MQDi', CAST(0xC6190B00 AS Date)),(N'PS10003', N'Nguyên Sơ', CAST(0x2E220B00 AS Date), 0, N'0927594734', N'PS10003@fpt.edu.vn', N'0927594734 - Nguyên Sơ', N'CQTrieu', CAST(0x2E220B00 AS Date)),(N'PS10004', N'Dạ Trầm Uyên', CAST(0xEB200B00 AS Date), 1, N'0946984711', N'PS10004@fpt.edu.vn', N'0946984711 - NGUYỄN HỮU TRÍ', N'DMoc', CAST(0xEB200B00 AS Date)),(N'PS10005', N'Tư Dạ Hàn', CAST(0xA1240B00 AS Date), 1, N'0924774498', N'PS10005@fpt.edu.vn', N'0924774498 - Tư Dạ Hàn', N'MLUyen', CAST(0xA1240B00 AS Date))GO--Thêm mới: INSERT INTO KhoaHoc (MaCD, HocPhi, ThoiLuong, NgayKG, GhiChu, MaNV, NgayTao)VALUES (?, ?, ?, ?, ?, ?, ?)
--Cập nhật theo mã: UPDATE KhoaHoc SET MaCD=?, HocPhi=?, ThoiLuong=?, NgayKG=?, GhiChu=?, MaNV=?,NgayTao=? WHERE MaKH=?
--Xóa theo mã: DELETE FROM KhoaHoc WHERE MaKH=?
--Truy vấn tất cả: SELECT * FROM KhoaHoc
--Truy vấn theo mã: SELECT * FROM KhoaHoc WHERE MaKH=?INSERT INTO KhoaHoc (MaCD, HocPhi, ThoiLuong, NgayKG, GhiChu, MaNV, NgayTao)VALUES(N'JAV01', 300, 90, CAST(0xBF3D0B00 AS Date), N'Lập trình Java cơ bản', N'TLHa', CAST(0xB53D0B00 AS Date)),(N'JAV02', 300, 90, CAST(0xDF3D0B00 AS Date), N'Lập trình Java nâng cao', N'MQDi', CAST(0xB53D0B00 AS Date)),(N'JAV01', 100, 50, CAST(0xFC3D0B00 AS Date), N'Lập trình Java cơ bản', N'CQTrieu', CAST(0xB53D0B00 AS Date)),(N'JAV01', 250, 80, CAST(0x103E0B00 AS Date), N'Lập trình Java cơ bản', N'DMoc', CAST(0xB53D0B00 AS Date)),(N'JAV03', 300, 90, CAST(0xD3400B00 AS Date), N'Lập trình mạng với Java', N'MLUyen', CAST(0xE6400B00 AS Date)),(N'JAV01', 300, 90, CAST(0xF6400B00 AS Date), N'Lập trình Java cơ bản', N'TLHa', CAST(0x0A410B00 AS Date)),(N'JAV02', 300, 90, CAST(0xF6400B00 AS Date), N'Lập trình Java nâng cao', N'MQDi', CAST(0x0A410B00 AS Date)),(N'JAV03', 200, 70, CAST(0xF6400B00 AS Date), N'Lập trình mạng với Java', N'CQTrieu', CAST(0x0A410B00 AS Date)),(N'JAV04', 200, 70, CAST(0xF6400B00 AS Date), N'Lập trình ứng dụng Desktop với Java', N'DMoc', CAST(0x0A410B00 AS Date)),(N'PRO01', 300, 90, CAST(0xF6400B00 AS Date), N'Lập trình .NET MVC',  N'MLUyen', CAST(0x0A410B00 AS Date))GO--Thêm mới: INSERT INTO HocVien (MaKH, MaNH, Diem) VALUES (?, ?, ?)
--Cập nhật theo mã: UPDATE HocVien SET MaKH=?, MaNH=?, Diem=? WHERE MaHV=?
--Xóa theo mã: DELETE FROM HocVien WHERE MaHV=?
--Truy vấn tất cả: SELECT * FROM HocVien
--Truy vấn theo mã: SELECT * FROM HocVien WHERE MaHV=?INSERT INTO HocVien (MaKH, MaNH, Diem) VALUES (9, 'PS10001', 7),(2, 'PS10002', 8),(3, 'PS10003', 9),(4, 'PS10004', 10),(5, 'PS10005', 10),(6, 'PS10001', 8),(7, 'PS10002', 9),(8, 'PS10003', 7)GOCREATE PROC sp_ThongKeNguoiHoc
AS BEGIN
	SELECT
		YEAR(NgayDK) Nam,
		COUNT(*) SoLuong,
		MIN(NgayDK) DauTien,
		MAX(NgayDK) CuoiCung
	FROM NguoiHoc
	GROUP BY YEAR(NgayDK)
ENDGOCREATE PROC sp_ThongKeDoanhThu(@Year INT)
AS BEGIN
	SELECT
		TenCD ChuyenDe,
		COUNT(DISTINCT kh.MaKH) SoKH,
		COUNT(hv.MaHV) SoHV,
		SUM(kh.HocPhi) DoanhThu,
		MIN(kh.HocPhi) ThapNhat,
		MAX(kh.HocPhi) CaoNhat,
		AVG(kh.HocPhi) TrungBinh
	FROM KhoaHoc kh
		JOIN HocVien hv ON kh.MaKH=hv.MaKH
		JOIN ChuyenDe cd ON cd.MaCD=kh.MaCD
	WHERE YEAR(NgayKG) = @Year
	GROUP BY TenCD
ENDGOCREATE PROC sp_ThongKeDiem
AS BEGIN
	SELECT
		TenCD ChuyenDe,
		COUNT(MaHV) SoHV,
		MIN(Diem) ThapNhat,
		MAX(Diem) CaoNhat,
		AVG(Diem) TrungBinh
	FROM KhoaHoc kh
		JOIN HocVien hv ON kh.MaKH=hv.MaKH
		JOIN ChuyenDe cd ON cd.MaCD=kh.MaCD
	GROUP BY TenCD
ENDGOCREATE PROC sp_BangDiem(@MaKH INT)
AS BEGIN
	SELECT
		nh.MaNH,
		nh.HoTen,
		hv.Diem
	FROM HocVien hv
	   JOIN NguoiHoc nh ON nh.MaNH=hv.MaNH
	WHERE hv.MaKH = @MaKH
	ORDER BY hv.Diem DESC
ENDSELECT * FROM NhanVien WHERE MaNV='TLHa'