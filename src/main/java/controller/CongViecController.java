package controller;

import java.util.Date;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import dao.CongViecDao;
import dao.NganhDao;
import model.CongViec;
import model.Nganh;

@Controller
public class CongViecController {
    private final CongViecDao congViecDAO = new CongViecDao();
    private final NganhDao nganhDAO = new NganhDao();
    
    @GetMapping("/congviec/form")
    public String showForm(Model model) {
        List<Nganh> nganhs = nganhDAO.getAllNganhs();
        model.addAttribute("nganhs", nganhs);
        model.addAttribute("congViec", new CongViec());
        return "congviec/form";
    }
    
    @PostMapping("/congviec/save")
    public String saveCongViec(
            @RequestParam("soCMND") String soCMND,
            @RequestParam("ngayVaoCongTy") String ngayVaoCongTy,
            @RequestParam("maNganh") String maNganh,
            @RequestParam("tenCongTy") String tenCongTy,
            @RequestParam("diaChiCongTy") String diaChiCongTy,
            @RequestParam("thoiGianLamViec") String thoiGianLamViec,
            Model model) {
        try {
            CongViec cv = new CongViec();
            cv.setSoCMND(soCMND);
            cv.setNgayVaoCongTy(java.sql.Date.valueOf(ngayVaoCongTy));
            cv.setMaNganh(maNganh);
            cv.setTenCongTy(tenCongTy);
            cv.setDiaChiCongTy(diaChiCongTy);
            cv.setThoiGianLamViec(thoiGianLamViec);
            
            congViecDAO.saveCongViec(cv);
            model.addAttribute("message", "Lưu thông tin công việc thành công!");
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi lưu thông tin: " + e.getMessage());
        }
        return "redirect:/sinhvien/form";
    }
} 