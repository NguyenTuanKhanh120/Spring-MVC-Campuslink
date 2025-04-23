
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import config.DatabaseConfig;
import model.Nganh;

public class NganhDao {
    
    public List<Nganh> getAllNganhs() {
        List<Nganh> list = new ArrayList<>();
        String sql = "SELECT * FROM NGANH";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Nganh n = new Nganh();
                n.setMaNganh(rs.getString("MaNganh"));
                n.setTenNganh(rs.getString("TenNganh"));
                n.setLoaiNganh(rs.getString("LoaiNganh"));
                list.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
