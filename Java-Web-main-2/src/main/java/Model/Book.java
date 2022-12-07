package Model;

public class Book {
	public String id;
	private String tensach;
	private String anh;
	private String tenTG;
	private String tenNXB;
	private String moTa;
	private String Messager;
	private long daBan;
	private Double Giaban;
	private int Soluongton;
	

	public int getSoluongton() {
		return Soluongton;
	}

	public void setSoluongton(int soluongton) {
		Soluongton = soluongton;
	}

	public String gettenNXB() {
		return tenNXB;
	}

	public void settenNXB(String value) {
		this.tenNXB = value;
	}

	
	public String getMessager() {
		return Messager;
	}

	public void setMessager(String value) {
		this.Messager = value;
	}

	public Double getGiaban() {
		return Giaban;
	}

	public void setGiaban(Double value) {
		this.Giaban = value;
	}

	public String getMota() {
		return moTa;
	}

	public void setMota(String value) {
		this.moTa = value;
	}

	public String getID() {
		return id;
	}

	public void setID(String value) {
		this.id = value;
	}

	public String getTensach() {
		return tensach;
	}

	public void setTensach(String value) {
		this.tensach = value;
	}

	public String getAnh() {
		return anh;
	}

	public void setAnh(String value) {
		this.anh = value;
	}

	public String getTenTG() {
		return tenTG;
	}

	public void setTenTG(String value) {
		this.tenTG = value;
	}

	public long getDaBan() {
		return daBan;
	}

	public void setDaBan(long value) {
		this.daBan = value;
	}
}