package Model;
public class User{
	private String id;
	private String HoTen;
	private String Taikhoan;
	private Boolean Role;
	private String Email;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getHoTen() {
		return HoTen;
	}
	public void setHoTen(String hoTen) {
		HoTen = hoTen;
	}
	public String getTaikhoan() {
		return Taikhoan;
	}
	public void setTaikhoan(String taikhoan) {
		Taikhoan = taikhoan;
	}
	public Boolean getRole() {
		return Role;
	}
	public void setRole(Boolean role) {
		Role = role;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
}