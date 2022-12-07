package Model;

public class Cart {
	private String BookId;
	private int Quatity;
	private double TotalPrice;
	private String PicBook;
	private String Description;
	private String BookName;
	
	public String getBookName() {
		return BookName;
	}
	public void setBookName(String bookName) {
		BookName = bookName;
	}
	public String getBookId() {
		return BookId;
	}
	public void setBookId(String bookId) {
		BookId = bookId;
	}
	public int getQuatity() {
		return Quatity;
	}
	public void setQuatity(int quatity) {
		Quatity = quatity;
	}
	public double getTotalPrice() {
		return TotalPrice;
	}
	public void setTotalPrice(double totalPrice) {
		TotalPrice = totalPrice;
	}
	
	
	public String getPicBook() {
		return PicBook;
	}
	public void setPicBook(String picBook) {
		PicBook = picBook;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	
	public Cart(String bookId, int quatity, double totalPrice, String picBook, String description) {
		super();
		BookId = bookId;
		Quatity = quatity;
		TotalPrice = totalPrice;
		PicBook = picBook;
		Description = description;
	}
	public Cart() {
		
	}
}
