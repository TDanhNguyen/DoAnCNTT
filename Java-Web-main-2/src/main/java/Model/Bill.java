package Model;


public class Bill {
	private String id;
	private String date;
	private String username;
	private Double TongTien;
	private Boolean Tinhtranggiaohang;
	public Boolean getTinhtranggiaohang() {
		return Tinhtranggiaohang;
	}
	public void setTinhtranggiaohang(Boolean tinhtranggiaohang) {
		Tinhtranggiaohang = tinhtranggiaohang;
	}
	public Double getTongTien() {
		return TongTien;
	}
	public void setTongTien(Double tongTien) {
		TongTien = tongTien;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	
}
