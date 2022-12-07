package Model;

public class SameCategoryBook {
	
	public String get_id() {
		return _id;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
	public String getTensach() {
		return Tensach;
	}
	public void setTensach(String tensach) {
		Tensach = tensach;
	}
	public Double getGiaban() {
		return Giaban;
	}
	public void setGiaban(Double giaban) {
		Giaban = giaban;
	}
	public String getAnhbia() {
		return Anhbia;
	}
	public void setAnhbia(String anhbia) {
		Anhbia = anhbia;
	}
	private String _id;
	private String Tensach;
	private Double Giaban;
	private String Anhbia;
	
	
}
