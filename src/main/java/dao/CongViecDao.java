package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import config.DatabaseConfig;
import model.CongViec;

public class CongViecDao {
    
    public void saveCongViec(String soCMND, String ngayVaoCongTy, String maNganh, 
                           String tenCongTy, String diaChiCongTy, String thoiGianLamViec) {
        String sql = "INSERT INTO CONG_VIEC(SoCMND, NgayVaoCongTy, MaNganh, TenCongTy, DiaChiCongTy, ThoiGianLamViec) " +
                    "VALUES(?,?,?,?,?,?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, soCMND);
            ps.setString(2, ngayVaoCongTy);
            ps.setString(3, maNganh);
            ps.setString(4, tenCongTy);
            ps.setString(5, diaChiCongTy);
            ps.setString(6, thoiGianLamViec);
            
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lưu thông tin công việc", e);
        }
    }
    
    public List<CongViec> getCongViecBySoCMND(String soCMND) {
        List<CongViec> list = new ArrayList<>();
        String sql = "SELECT * FROM CONG_VIEC WHERE SoCMND = ? ORDER BY NgayVaoCongTy DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, soCMND);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                CongViec cv = new CongViec();
                cv.setSoCMND(rs.getString("SoCMND"));
                cv.setNgayVaoCongTy(rs.getDate("NgayVaoCongTy"));
                cv.setMaNganh(rs.getString("MaNganh"));
                cv.setTenCongTy(rs.getString("TenCongTy"));
                cv.setDiaChiCongTy(rs.getString("DiaChiCongTy"));
                cv.setThoiGianLamViec(rs.getString("ThoiGianLamViec"));
                list.add(cv);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy thông tin công việc", e);
        }
        return list;
    }
    
    public List<Object[]> searchCongViec(String keyword) {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT cv.SoCMND, sv.HoTen, " +
                    "GROUP_CONCAT(DISTINCT CONCAT(tn.MaNganh, ' - ', tn.MaTruong, ' (', DATE_FORMAT(tn.NgayTotNghiep, '%d/%m/%Y'), ')') SEPARATOR '; ') as ThongTinTN, " +
                    "GROUP_CONCAT(DISTINCT CONCAT(cv.TenCongTy, ' (', DATE_FORMAT(cv.NgayVaoCongTy, '%d/%m/%Y'), ') - ', cv.ThoiGianLamViec) SEPARATOR '; ') as ThongTinCV " +
                    "FROM SINHVIEN sv " +
                    "LEFT JOIN CONG_VIEC cv ON sv.SoCMND = cv.SoCMND " +
                    "LEFT JOIN TOT_NGHIEP tn ON sv.SoCMND = tn.SoCMND " +
                    "WHERE sv.SoCMND LIKE ? OR sv.HoTen LIKE ? " +
                    "GROUP BY cv.SoCMND, sv.HoTen";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Object[] row = new Object[4];
                row[0] = rs.getString("SoCMND");
                row[1] = rs.getString("HoTen");
                row[2] = rs.getString("ThongTinTN");
                row[3] = rs.getString("ThongTinCV");
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm kiếm thông tin công việc", e);
        }
        return list;
    }

	public void saveCongViec(CongViec cv) {
		// TODO Auto-generated method stub
		
	}
} 