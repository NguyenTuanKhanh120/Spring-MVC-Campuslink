package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import model.SinhVien;
import model.TotNghiep;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import config.DatabaseConfig;

public class SinhVienDao {
    public void saveSinhVien(SinhVien sv, List<TotNghiep> totNghieps) {
        String sqlSinhVien = "INSERT INTO SINHVIEN(SoCMND, HoTen, Email, SoDT, DiaChi) VALUES(?,?,?,?,?) " +
                     "ON DUPLICATE KEY UPDATE HoTen=?, Email=?, SoDT=?, DiaChi=?";
        String sqlDeleteTN = "DELETE FROM TOT_NGHIEP WHERE SoCMND=?";
        String sqlInsertTN = "INSERT INTO TOT_NGHIEP(SoCMND, MaTruong, MaNganh, HeTN, NgayTN, LoaiTN) VALUES(?,?,?,?,?,?)";
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            conn.setAutoCommit(false);
            
            try {
                // Lưu thông tin sinh viên
                try (PreparedStatement ps = conn.prepareStatement(sqlSinhVien)) {
                    ps.setString(1, sv.getSoCMND());
                    ps.setString(2, sv.getHoTen());
                    ps.setString(3, sv.getEmail());
                    ps.setString(4, sv.getSoDT());
                    ps.setString(5, sv.getDiaChi());
                    // Update values
                    ps.setString(6, sv.getHoTen());
                    ps.setString(7, sv.getEmail());
                    ps.setString(8, sv.getSoDT());
                    ps.setString(9, sv.getDiaChi());
                    ps.executeUpdate();
                }
                
                // Xóa tất cả bằng tốt nghiệp cũ
                try (PreparedStatement ps = conn.prepareStatement(sqlDeleteTN)) {
                    ps.setString(1, sv.getSoCMND());
                    ps.executeUpdate();
                }
                
                // Thêm các bằng tốt nghiệp mới
                if (totNghieps != null && !totNghieps.isEmpty()) {
                    try (PreparedStatement ps = conn.prepareStatement(sqlInsertTN)) {
                        for (TotNghiep tn : totNghieps) {
                            ps.setString(1, sv.getSoCMND());
                            ps.setString(2, tn.getMaTruong());
                            ps.setString(3, tn.getMaNganh());
                            ps.setString(4, tn.getHeTN());
                            ps.setDate(5, new java.sql.Date(tn.getNgayTN().getTime()));
                            ps.setString(6, tn.getLoaiTN());
                            ps.executeUpdate();
                        }
                    }
                }
                
                conn.commit();
            } catch (Exception e) {
                conn.rollback();
                throw e;
            }
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi lưu thông tin sinh viên", e);
        }
    }
    
    public List<SinhVien> searchSinhVien(String keyword) {
        List<SinhVien> list = new ArrayList<>();
        String sql = "SELECT * FROM SINHVIEN WHERE SoCMND LIKE ? OR HoTen LIKE ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SinhVien sv = new SinhVien();
                sv.setSoCMND(rs.getString("SoCMND"));
                sv.setHoTen(rs.getString("HoTen"));
                sv.setEmail(rs.getString("Email"));
                sv.setSoDT(rs.getString("SoDT"));
                sv.setDiaChi(rs.getString("DiaChi"));
                list.add(sv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Object[]> searchSinhVienJob(String keyword) {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT s.SoCMND, s.HoTen, " +
                    "GROUP_CONCAT(DISTINCT CONCAT(tn.MaNganh, ' - ', tn.MaTruong, ' (', DATE_FORMAT(tn.NgayTN, '%d/%m/%Y'), ')')) as TotNghiep, " +
                    "GROUP_CONCAT(DISTINCT CONCAT(cv.MaNganh, ' - ', cv.TenCongTy, ' (', cv.ThoiGianLamViec, ')')) as CongViec " +
                    "FROM SINHVIEN s " +
                    "LEFT JOIN TOT_NGHIEP tn ON s.SoCMND = tn.SoCMND " +
                    "LEFT JOIN CONG_VIEC cv ON s.SoCMND = cv.SoCMND " +
                    "WHERE s.SoCMND LIKE ? OR s.HoTen LIKE ? " +
                    "GROUP BY s.SoCMND, s.HoTen";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Object[] row = new Object[4];
                row[0] = rs.getString("SoCMND");
                row[1] = rs.getString("HoTen");
                row[2] = rs.getString("TotNghiep");
                row[3] = rs.getString("CongViec");
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<SinhVien> getAllSinhViens() {
        List<SinhVien> list = new ArrayList<>();
        String sql = "SELECT * FROM SINHVIEN";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SinhVien sv = new SinhVien();
                sv.setSoCMND(rs.getString("SoCMND"));
                sv.setHoTen(rs.getString("HoTen"));
                sv.setEmail(rs.getString("Email"));
                sv.setSoDT(rs.getString("SoDT"));
                sv.setDiaChi(rs.getString("DiaChi"));
                list.add(sv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<TotNghiep> getTotNghiepBySinhVien(String soCMND) {
        List<TotNghiep> list = new ArrayList<>();
        String sql = "SELECT * FROM TOT_NGHIEP WHERE SoCMND = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, soCMND);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                TotNghiep tn = new TotNghiep();
                tn.setSoCMND(rs.getString("SoCMND"));
                tn.setMaTruong(rs.getString("MaTruong"));
                tn.setMaNganh(rs.getString("MaNganh"));
                tn.setHeTN(rs.getString("HeTN"));
                tn.setNgayTN(rs.getDate("NgayTN"));
                tn.setLoaiTN(rs.getString("LoaiTN"));
                list.add(tn);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}