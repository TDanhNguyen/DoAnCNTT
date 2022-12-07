package Model;

public class UserBill {

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Boolean getDatthanhtoan() {
		return Datthanhtoan;
	}
	public void setDatthanhtoan(Boolean datthanhtoan) {
		Datthanhtoan = datthanhtoan;
	}
	public Boolean getTinhtranggiaohang() {
		return Tinhtranggiaohang;
	}
	public void setTinhtranggiaohang(Boolean tinhtranggiaohang) {
		Tinhtranggiaohang = tinhtranggiaohang;
	}
	public String getNgaydat() {
		return Ngaydat;
	}
	public void setNgaydat(String ngaydat) {
		Ngaydat = ngaydat;
	}
	public Double getTongTien() {
		return TongTien;
	}
	public void setTongTien(Double tongTien) {
		TongTien = tongTien;
	}
	private String id;
	private Boolean Datthanhtoan;
	private Boolean Tinhtranggiaohang;
	private String Ngaydat;
	private Double TongTien;
	
}
