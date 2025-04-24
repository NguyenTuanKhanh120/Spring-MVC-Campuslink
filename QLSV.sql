CREATE DATABASE QLSV;
USE QLSV;

CREATE TABLE sinhvien (
    SoCMND VARCHAR(20) PRIMARY KEY,
    HoTen NVARCHAR(100),
    Email VARCHAR(100),
    SoDT VARCHAR(15),
    DiaChi NVARCHAR(200)
);

CREATE TABLE truong (
    MaTruong VARCHAR(10) PRIMARY KEY,
    TenTruong NVARCHAR(100)
);

INSERT INTO truong (MaTruong, TenTruong) VALUES
('T01', N'Đại học Bách Khoa Hà Nội'),
('T02', N'Đại học Quốc gia TP.HCM'),
('T03', N'Đại học Kinh tế Quốc dân'),
('T04', N'Đại học FPT'),
('T05', N'Đại học Sư phạm Hà Nội');


CREATE TABLE nganh (
    MaNganh VARCHAR(10) PRIMARY KEY,
    TenNganh NVARCHAR(100)
);

INSERT INTO nganh (MaNganh, TenNganh) VALUES
('N01', N'Công nghệ thông tin'),
('N02', N'Kỹ thuật điện'),
('N03', N'Quản trị kinh doanh'),
('N04', N'Sư phạm Toán'),
('N05', N'Khoa học dữ liệu');


CREATE TABLE tot_nghiep (
    SoCMND VARCHAR(20),
    MaTruong VARCHAR(10),
    MaNganh VARCHAR(10),
    NgayTN DATE,
    PRIMARY KEY (SoCMND, MaTruong, MaNganh),
    FOREIGN KEY (SoCMND) REFERENCES SINHVIEN(SoCMND),
    FOREIGN KEY (MaTruong) REFERENCES TRUONG(MaTruong),
    FOREIGN KEY (MaNganh) REFERENCES NGANH(MaNganh)
);

CREATE TABLE congty (
    MaCongTy VARCHAR(10) PRIMARY KEY,
    TenCongTy NVARCHAR(100)
);

CREATE TABLE congviec (
    SoCMND VARCHAR(20),
    MaCongTy VARCHAR(10),
    MaNganh VARCHAR(10),
    ThoiGianLamViec DATE,
    PRIMARY KEY (SoCMND, MaCongTy, MaNganh),
    FOREIGN KEY (SoCMND) REFERENCES SINHVIEN(SoCMND),
    FOREIGN KEY (MaCongTy) REFERENCES CONGTY(MaCongTy),
    FOREIGN KEY (MaNganh) REFERENCES NGANH(MaNganh)
);

-- Thêm 5 bản ghi vào bảng sinhvien
INSERT INTO sinhvien (SoCMND, HoTen, Email, SoDT, DiaChi) VALUES
('123456789', N'Nguyễn Văn An', 'an.nguyen@gmail.com', '0912345678', N'123 Đường Láng, Hà Nội'),
('987654321', N'Trần Thị Bình', 'binh.tran@gmail.com', '0987654321', N'456 Nguyễn Trãi, TP.HCM'),
('456789123', N'Lê Minh Châu', 'chau.le@gmail.com', '0901234567', N'789 Lê Lợi, Đà Nẵng'),
('789123456', N'Phạm Quốc Đạt', 'dat.pham@gmail.com', '0932145678', N'101 Hai Bà Trưng, Huế'),
('321654987', N'Hoàng Thị Mai', 'mai.hoang@gmail.com', '0945678901', N'202 Trần Phú, Nha Trang');

-- Thêm 5 bản ghi vào bảng truong (bổ sung thêm 5 trường mới)
INSERT INTO truong (MaTruong, TenTruong) VALUES
('T06', N'Đại học Công nghệ Thông tin TP.HCM'),
('T07', N'Đại học Y Hà Nội'),
('T08', N'Đại học Ngoại thương'),
('T09', N'Đại học Giao thông Vận tải'),
('T10', N'Đại học Khoa học Tự nhiên');

-- Thêm 5 bản ghi vào bảng nganh (bổ sung thêm 5 ngành mới)
INSERT INTO nganh (MaNganh, TenNganh) VALUES
('N06', N'Kỹ thuật cơ khí'),
('N07', N'Y học cổ truyền'),
('N08', N'Kinh tế quốc tế'),
('N09', N'Logistics và Quản lý chuỗi cung ứng'),
('N10', N'Vật lý học');

-- Thêm 5 bản ghi vào bảng tot_nghiep (tham chiếu đến sinhvien, truong, nganh)
INSERT INTO tot_nghiep (SoCMND, MaTruong, MaNganh, NgayTN) VALUES
('123456789', 'T01', 'N01', '2023-06-15'),
('987654321', 'T02', 'N03', '2022-07-20'),
('456789123', 'T03', 'N05', '2023-05-10'),
('789123456', 'T04', 'N01', '2024-01-25'),
('321654987', 'T05', 'N04', '2023-12-30');

-- Thêm 5 bản ghi vào bảng congty
INSERT INTO congty (MaCongTy, TenCongTy) VALUES
('C01', N'Công ty TNHH FPT Software'),
('C02', N'Công ty Cổ phần VNG'),
('C03', N'Công ty TNHH Viettel Solutions'),
('C04', N'Công ty Cổ phần Tiki'),
('C05', N'Công ty TNHH Shopee Việt Nam');

-- Thêm 5 bản ghi vào bảng congviec (tham chiếu đến sinhvien, congty, nganh)
INSERT INTO congviec (SoCMND, MaCongTy, MaNganh, ThoiGianLamViec) VALUES
('123456789', 'C01', 'N01', '2023-07-01'),
('987654321', 'C04', 'N03', '2022-08-15'),
('456789123', 'C02', 'N05', '2023-06-01'),
('789123456', 'C03', 'N01', '2024-02-10'),
('321654987', 'C05', 'N09', '2024-01-05');
