	package controller;
	
	import java.text.SimpleDateFormat;
	import java.util.Date;
	import java.util.List;
	import java.util.ArrayList;
	import org.springframework.stereotype.Controller;
	import org.springframework.ui.Model;
	import org.springframework.web.bind.annotation.GetMapping;
	import org.springframework.web.bind.annotation.PostMapping;
	import org.springframework.web.bind.annotation.RequestParam;
	import org.springframework.web.bind.annotation.ModelAttribute;
	import org.springframework.web.bind.annotation.RequestMapping;
	import org.springframework.web.bind.annotation.RequestMethod;
	import dao.NganhDao;
	import dao.SinhVienDao;
	import dao.TruongDao;
	import dao.CongViecDao;
	import model.Nganh;
	import model.SinhVien;
	import model.TotNghiep;
	import model.Truong;
	import model.CongViec;
	
	@Controller
	public class SinhVienController {
	    private final SinhVienDao sinhVienDAO = new SinhVienDao();
	    private final TruongDao truongDAO = new TruongDao();
	    private final NganhDao nganhDAO = new NganhDao();
	    private final CongViecDao congViecDAO = new CongViecDao();
	
	    @GetMapping("/sinhvien/form")
	    public String showForm(Model model) {
	        List<Truong> truongs = truongDAO.getAllTruongs();
	        List<Nganh> nganhs = nganhDAO.getAllNganhs();
	        model.addAttribute("truongs", truongs);
	        model.addAttribute("nganhs", nganhs);
	        model.addAttribute("sinhVien", new SinhVien());
	        return "sinhvien/form";
	    }
	
	    @PostMapping("/sinhvien/save")
	    public String saveSinhVien(
	            @RequestParam("soCMND") String soCMND,
	            @RequestParam("hoTen") String hoTen,
	            @RequestParam("email") String email,
	            @RequestParam("soDT") String soDT,
	            @RequestParam("diaChi") String diaChi,
	            @RequestParam("maTruong[]") List<String> maTruongs,
	            @RequestParam("maNganh[]") List<String> maNganhs,
	            @RequestParam("heTN[]") List<String> heTNs,
	            @RequestParam("ngayTN[]") List<String> ngayTNs,
	            @RequestParam("loaiTN[]") List<String> loaiTNs,
	            @RequestParam(value = "maNganhCV[]", required = false) List<String> maNganhCVs,
	            @RequestParam(value = "ngayVaoCongTy[]", required = false) List<String> ngayVaoCongTys,
	            @RequestParam(value = "tenCongTy[]", required = false) List<String> tenCongTys,
	            @RequestParam(value = "diaChiCongTy[]", required = false) List<String> diaChiCongTys,
	            @RequestParam(value = "thoiGianLamViec[]", required = false) List<String> thoiGianLamViecs,
	            Model model) {
	        try {
	            // Kiểm tra bắt buộc nhập
	            if (soCMND.isEmpty()) {
	                model.addAttribute("error", "Số CMND là bắt buộc!");
	                return showForm(model);
	            }
	
	            // Tạo đối tượng SinhVien
	            SinhVien sv = new SinhVien();
	            sv.setSoCMND(soCMND);
	            sv.setHoTen(hoTen);
	            sv.setEmail(email);
	            sv.setSoDT(soDT);
	            sv.setDiaChi(diaChi);
	
	            // Lưu thông tin sinh viên trước
	            List<TotNghiep> totNghieps = new ArrayList<>();
	            sinhVienDAO.saveSinhVien(sv, totNghieps);
	
	            // Kiểm tra và lưu thông tin tốt nghiệp
	            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	            dateFormat.setLenient(false);
	
	            for (int i = 0; i < maTruongs.size(); i++) {
	                if (maTruongs.get(i).isEmpty() || maNganhs.get(i).isEmpty()) {
	                    model.addAttribute("error", "Mã trường và mã ngành là bắt buộc cho mỗi bằng tốt nghiệp!");
	                    return showForm(model);
	                }
	
	                try {
	                    Date parsedNgayTN = dateFormat.parse(ngayTNs.get(i));
	                    
	                    TotNghiep tn = new TotNghiep();
	                    tn.setSoCMND(soCMND);
	                    tn.setMaTruong(maTruongs.get(i));
	                    tn.setMaNganh(maNganhs.get(i));
	                    tn.setHeTN(heTNs.get(i));
	                    tn.setNgayTN(parsedNgayTN);
	                    tn.setLoaiTN(loaiTNs.get(i));
	
	                    totNghieps.add(tn);
	                } catch (Exception e) {
	                    model.addAttribute("error", "Ngày tốt nghiệp không hợp lệ!");
	                    return showForm(model);
	                }
	            }
	
	            // Lưu lại thông tin sinh viên với danh sách bằng tốt nghiệp
	            sinhVienDAO.saveSinhVien(sv, totNghieps);
	
	            // Lưu thông tin công việc nếu có
	            if (maNganhCVs != null && !maNganhCVs.isEmpty()) {
	                for (int i = 0; i < maNganhCVs.size(); i++) {
	                    if (!maNganhCVs.get(i).isEmpty() && !ngayVaoCongTys.get(i).isEmpty()) {
	                        try {
	                            congViecDAO.saveCongViec(
	                                soCMND,
	                                ngayVaoCongTys.get(i),
	                                maNganhCVs.get(i),
	                                tenCongTys.get(i),
	                                diaChiCongTys.get(i),
	                                thoiGianLamViecs.get(i)
	                            );
	                        } catch (Exception e) {
	                            model.addAttribute("error", "Ngày vào công ty không hợp lệ!");
	                            return showForm(model);
	                        }
	                    }
	                }
	            }
	
	            model.addAttribute("message", "Lưu thông tin thành công!");
	            return "redirect:/sinhvien/searchJob?keyword=" + soCMND;
	        } catch (Exception e) {
	            model.addAttribute("error", "Lỗi khi lưu thông tin: " + e.getMessage());
	            return showForm(model);
	        }
	    }
	    
	    @GetMapping("/sinhvien/search")
	    public String searchSinhVien(@RequestParam(required = false) String keyword, Model model) {
	        List<SinhVien> sinhViens;
	        if (keyword != null && !keyword.trim().isEmpty()) {
	            sinhViens = sinhVienDAO.searchSinhVien(keyword);
	        } else {
	            sinhViens = sinhVienDAO.getAllSinhViens();
	        }
	        model.addAttribute("sinhViens", sinhViens);
	        return "sinhvien/list";
	    }
	
	    @GetMapping("/sinhvien/searchBasic")
	    public String showSearchBasicForm() {
	        return "sinhvien/searchBasic";
	    }
	
	    @PostMapping("/sinhvien/searchBasic")
	    public String searchBasic(
	            @RequestParam("keyword") String keyword,
	            Model model) throws Exception {
	        List<SinhVien> sinhViens = sinhVienDAO.searchSinhVien(keyword);
	        model.addAttribute("sinhViens", sinhViens);
	        return "sinhvien/searchBasic";
	    }
	
	    @GetMapping("/sinhvien/searchJob")
	    public String searchSinhVienJob(
	            @RequestParam(value = "keyword", required = false) String keyword, 
	            Model model) {
	        List<Object[]> list;
	        if (keyword != null && !keyword.trim().isEmpty()) {
	            list = sinhVienDAO.searchSinhVienJob(keyword);
	        } else {
	            list = sinhVienDAO.searchSinhVienJob("");
	        }
	        model.addAttribute("results", list);
	        return "sinhvien/jobList";
	    }
	
	    @RequestMapping(value = "/save", method = RequestMethod.POST)
	    public String saveSinhVien(@ModelAttribute("sinhVien") SinhVien sinhVien,
	                              @ModelAttribute("totNghiep") TotNghiep totNghiep,
	                              Model model) {
	        try {
	            List<TotNghiep> totNghieps = new ArrayList<>();
	            totNghiep.setSoCMND(sinhVien.getSoCMND());
	            totNghieps.add(totNghiep);
	            
	            // Lưu thông tin sinh viên và bằng tốt nghiệp
	            sinhVienDAO.saveSinhVien(sinhVien, totNghieps);
	            
	            // Chuyển đến trang tìm kiếm với ID của sinh viên
	            return "redirect:/sinhvien/search?soCMND=" + sinhVien.getSoCMND();
	        } catch (Exception e) {
	            model.addAttribute("error", "Lỗi khi lưu thông tin: " + e.getMessage());
	            return "sinhvien/form";
	        }
	    }
}