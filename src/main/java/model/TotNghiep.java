package model;

import java.util.Date;

public class TotNghiep {
    private String soCMND;
    private String maTruong;
    private String maNganh;
    private String heTN;
    private Date ngayTN;
    private String loaiTN;

    // Getters and setters
    public String getSoCMND() { return soCMND; }
    public void setSoCMND(String soCMND) { this.soCMND = soCMND; }
    public String getMaTruong() { return maTruong; }
    public void setMaTruong(String maTruong) { this.maTruong = maTruong; }
    public String getMaNganh() { return maNganh; }
    public void setMaNganh(String maNganh) { this.maNganh = maNganh; }
    public String getHeTN() { return heTN; }
    public void setHeTN(String heTN) { this.heTN = heTN; }
    public Date getNgayTN() { return ngayTN; }
    public void setNgayTN(Date ngayTN) { this.ngayTN = ngayTN; }
    public String getLoaiTN() { return loaiTN; }
    public void setLoaiTN(String loaiTN) { this.loaiTN = loaiTN; }
}