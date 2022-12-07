package Model;

public class Chude {
	private String _id;
	private String TenChuDe;

	public String get_id() {
		return _id;
	}

	public void set_id(String _id) {
		this._id = _id;
	}

	public String getTenChuDe() {
		return TenChuDe;
	}

	public void setTenChuDe(String tenChuDe) {
		TenChuDe = tenChuDe;
	}

	public Chude(String _id, String tenChuDe) {
		super();
		this._id = _id;
		TenChuDe = tenChuDe;
	}

	public Chude() {
		super();

	}

}
