package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import config.DatabaseConfig;
import model.Truong;

public class TruongDao {
    
    public List<Truong> getAllTruongs() {
        List<Truong> list = new ArrayList<>();
        String sql = "SELECT * FROM TRUONG";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Truong t = new Truong();
                t.setMaTruong(rs.getString("MaTruong"));
                t.setTenTruong(rs.getString("TenTruong"));
                t.setDiaChi(rs.getString("DiaChi"));
                t.setSoDT(rs.getString("SoDT"));
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}