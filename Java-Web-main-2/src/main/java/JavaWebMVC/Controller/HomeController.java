package JavaWebMVC.Controller;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import Model.Book;
import Model.Cart;
import Model.UserBill;
import Model.SameCategoryBook;

@Controller
public class HomeController {
	@RequestMapping(value = { "/", "/home" })
	public ModelAndView Index(HttpSession session) {
		if (session.getAttribute("CountCart") == null) {
			session.setAttribute("CountCart", 0);
		}
		ModelAndView mv = new ModelAndView("/user/index");
		return mv;
	}

	@RequestMapping(value = { "/signin" }, method = RequestMethod.GET)
	public ModelAndView Login(HttpSession session) {
		if (session.getAttribute("id") == null) {
			ModelAndView mv = new ModelAndView("/user/signin");
			return mv;
		}
		ModelAndView mv = new ModelAndView("redirect:/home");
		return mv;
	}

	@RequestMapping(value = { "/signin" }, method = RequestMethod.POST)
	public ModelAndView Login(HttpServletRequest req, HttpSession session) {
		String data = "{\n \"Taikhoan\": \"" + req.getParameter("username") + "\",\n \"Matkhau\": \""
				+ req.getParameter("pass") + "\"\n}";

		String link = "https://bookstoreute.onrender.com/login";

		JSONObject json = new JSONObject(JavaWebMVC.API.CallAPI.post(link, data).toString());

		if (json.getString("Messenger").equalsIgnoreCase("Đăng Nhập Thành Công")) {
			session.setAttribute("id", json.getString("id"));
			session.setAttribute("User", json.getString("HoTen"));
			session.setAttribute("Role", json.getBoolean("Role"));
			session.setAttribute("Name", json.getString("HoTen"));
			if (json.has("Email") && json.has("DienthoaiKH")) {
				session.setAttribute("Email", json.getString("Email"));
				session.setAttribute("SDT", json.getString("DienthoaiKH"));
				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
				Calendar cal = Calendar.getInstance();
				String date = dateFormat.format(cal.getTime());
				session.setAttribute("Date", date);
			}

			ModelAndView mv = new ModelAndView("redirect:/home");
			return mv;
		} else {
			ModelAndView mv = new ModelAndView("/user/signin");
			mv.addObject("Messenger", json.getString("Messenger"));
			return mv;
		}

	}

	@RequestMapping(value = { "/signup" }, method = RequestMethod.GET)
	public ModelAndView Signup(HttpSession session) {
		if (session.getAttribute("id") == null) {
			ModelAndView mv = new ModelAndView("/user/signup");
			return mv;
		}
		ModelAndView mv = new ModelAndView("redirect:/home");
		return mv;
	}

	@RequestMapping(value = { "/signup" }, method = RequestMethod.POST)
	public ModelAndView Signup(HttpServletRequest req, HttpSession session) throws UnsupportedEncodingException {
		req.setCharacterEncoding("UTF-8");
		String data = "{\n \"HoTen\": \"" + req.getParameter("fullname") + "\", \n \"Taikhoan\": \""
				+ req.getParameter("username") + "\",\n \"Matkhau\": \"" + req.getParameter("pass")
				+ "\",\n \"ConfirmMatKhau\" : \"" + req.getParameter("compass") + "\"\n}";

		String link = "https://bookstoreute.onrender.com/khachhang";

		JSONObject json = new JSONObject(JavaWebMVC.API.CallAPI.post(link, data).toString());
		if (json.getString("Messenger").equalsIgnoreCase("Đăng Ký Thành Công")) {
			session.setAttribute("id", json.getString("id"));
			session.setAttribute("Role", json.getBoolean("Role"));
			session.setAttribute("User", json.getString("HoTen"));
			ModelAndView mv = new ModelAndView("redirect:/home");
			return mv;
		} else {
			ModelAndView mv = new ModelAndView("/user/signup");
			mv.addObject("Messenger", json.getString("Messenger"));
			return mv;
		}
	}

	@RequestMapping(value = { "/signout" })
	public ModelAndView Signout(HttpSession session) {
		session.removeAttribute("id");
		session.removeAttribute("User");
		session.removeAttribute("Role");
		session.removeAttribute("Name");
		session.removeAttribute("Email");
		session.removeAttribute("SDT");
		ModelAndView mv = new ModelAndView("redirect:/home");
		return mv;
	}

	@RequestMapping(value = { "/myprofile" }, method = RequestMethod.GET)
	public ModelAndView Profile(HttpSession session, String mess) {

		if (session.getAttribute("id") != null) {
			String link = "https://bookstoreute.onrender.com/khachhangbyid/" + session.getAttribute("id");
			String res = JavaWebMVC.API.CallAPI.Get(link).toString();
			if (res != null) {
				JSONObject json = new JSONObject(res);
				ModelAndView mv = new ModelAndView("/user/profile");

				mv.addObject("HoTen", json.getString("HoTen"));
				mv.addObject("Anh", json.getString("Anh"));
				if (json.has("Email") && json.has("Anh") && json.has("DiachiKH") && json.has("DienthoaiKH")
						&& json.has("Ngaysinh")) {
					mv.addObject("Email", json.getString("Email"));
					mv.addObject("DiachiKH", json.getString("DiachiKH"));
					mv.addObject("DienthoaiKH", json.getString("DienthoaiKH"));
					mv.addObject("Ngaysinh", json.getString("Ngaysinh"));
					session.setAttribute("Email", json.getString("Email"));
					session.setAttribute("SDT", json.getString("DienthoaiKH"));
				} else {
					mv.addObject("Email", "");
					mv.addObject("DiachiKH", "");
					mv.addObject("DienthoaiKH", "");
					mv.addObject("Ngaysinh", "");
				}

				mv.addObject("Messenger", mess);

				session.setAttribute("User", json.getString("HoTen"));
				session.setAttribute("Role", json.getBoolean("Role"));
				session.setAttribute("Name", json.getString("HoTen"));

				return mv;
			}
		} else {
			ModelAndView mv = new ModelAndView("/user/profile");
			mv.addObject("Messenger", "Không Thể Call API");
			return mv;
		}
		ModelAndView mv = new ModelAndView("/user/signin");
		return mv;
	}

	@RequestMapping(value = { "/details" }, method = RequestMethod.GET)
	public ModelAndView getvalue(HttpServletRequest req) {

		String link = "https://bookstoreute.onrender.com/sachbyid/" + req.getParameter("id");
		StringBuffer check = JavaWebMVC.API.CallAPI.Get(link);

		// Create Object detail book
		ArrayList<Book> detail = new ArrayList<Book>();

		// Create list same category books
		ArrayList<SameCategoryBook> listSameCategory = new ArrayList<SameCategoryBook>();
		if (check != null) {
			JSONObject json = new JSONObject(check.toString());

			// Get detail for book from API.
			JSONArray jsonarr = (JSONArray) json.get("data");
			// Get list same category books data from API.
			JSONArray jsonList = (JSONArray) json.get("BookLienQuan");

			// Add data details book to Object detail book
			jsonarr.forEach(data -> {
				JSONObject jsonobject = (JSONObject) data;
				Book book = new Book();
				book.setID(jsonobject.getString("id"));
				book.setTensach(jsonobject.getString("Tensach"));
				book.setAnh(jsonobject.getString("Anh"));
				book.setMota(jsonobject.getString("Mota"));
				book.setGiaban(jsonobject.getDouble("Giaban"));
				book.setTenTG(jsonobject.getString("TenTG"));
				book.settenNXB(jsonobject.getString("TenNXB"));
				book.setSoluongton(jsonobject.getInt("Soluongton"));
				detail.add(book);
			});

			// Add list data to jsonList
			jsonList.forEach(data -> {
				JSONObject jsonobject = (JSONObject) data;
				SameCategoryBook book = new SameCategoryBook();
				book.set_id(jsonobject.getString("_id"));
				book.setTensach(jsonobject.getString("Tensach"));
				book.setAnhbia(jsonobject.getString("Anhbia"));
				book.setGiaban(jsonobject.getDouble("Giaban"));
				listSameCategory.add(book);
			});

		}

		ModelAndView model = new ModelAndView("/user/details");
		model.addObject("Book", detail);
		model.addObject("listSameCategory", listSameCategory);
		return model;
	}

	@RequestMapping(value = { "/my-cart" })
	public String MyCart(HttpSession sesstion) {
		return "/user/cart";
	}

	// thêm hàng hóa vào giỏ hàng
	ArrayList<Cart> Cart = new ArrayList<Cart>();

	@RequestMapping(value = { "/addCart/{id}" })
	public String addCart(HttpServletRequest req, HttpSession sesstion, @PathVariable String id) {
		Cart cart = new Cart();
		String link = "https://bookstoreute.onrender.com/sachbyid/" + id;
		StringBuffer check = JavaWebMVC.API.CallAPI.Get(link);
		Boolean flag = true;
		Double TotalPriceInCart = 0.0;
		for (Cart item : Cart) {
			if (item.getBookId().equalsIgnoreCase(id)) {
				flag = false;
				item.setQuatity(item.getQuatity() + 1);
				JSONObject json = new JSONObject(check.toString());
				JSONArray jsonarr = (JSONArray) json.get("data");
				jsonarr.forEach(data -> {
					JSONObject jsonobject = (JSONObject) data;
					item.setTotalPrice(item.getQuatity() * jsonobject.getDouble("Giaban"));
				});
			}
		}
		if (check != null && flag == true) {
			JSONObject json = new JSONObject(check.toString());
			JSONArray jsonarr = (JSONArray) json.get("data");
			jsonarr.forEach(data -> {
				JSONObject jsonobject = (JSONObject) data;
				cart.setTotalPrice(jsonobject.getDouble("Giaban"));
				cart.setPicBook(jsonobject.getString("Anh"));
				cart.setBookName(jsonobject.getString("Tensach"));
				cart.setBookId(id);
				cart.setQuatity(1);
				Cart.add(cart);
			});
		}
		for (Cart item : Cart) {
			TotalPriceInCart = TotalPriceInCart + item.getTotalPrice();
		}

		sesstion.setAttribute("ItemCart", Cart);
		sesstion.setAttribute("TotalPriceInCart", TotalPriceInCart);
		sesstion.setAttribute("CountCart", Cart.size());
		return "redirect:/my-cart";
	}

	// phần tăng 1 quatity vào giỏ hàng
	@RequestMapping(value = { "/addmore/{id}" })
	public String AddMore(HttpServletRequest req, HttpSession sesstion, @PathVariable String id) {
		String link = "https://bookstoreute.onrender.com/sachbyid/" + id;
		StringBuffer check = JavaWebMVC.API.CallAPI.Get(link);
		Double TotalPriceInCart = 0.0;
		if (id != null && id != "" && !Cart.isEmpty()) {
			for (Cart item : Cart) {
				if (item.getBookId().equalsIgnoreCase(id)) {
					item.setQuatity(item.getQuatity() + 1);
					JSONObject json = new JSONObject(check.toString());
					JSONArray jsonarr = (JSONArray) json.get("data");
					jsonarr.forEach(data -> {
						JSONObject jsonobject = (JSONObject) data;
						item.setTotalPrice(item.getQuatity() * jsonobject.getDouble("Giaban"));
					});
				}
			}
		}
		for (Cart item : Cart) {
			TotalPriceInCart = TotalPriceInCart + item.getTotalPrice();
		}

		sesstion.setAttribute("ItemCart", Cart);
		sesstion.setAttribute("TotalPriceInCart", TotalPriceInCart);
		sesstion.setAttribute("CountCart", Cart.size());
		return "redirect:" + req.getHeader("Referer");
	}

	// phần giảm 1 quatity vào giỏ hàng
	@RequestMapping(value = { "/addless/{id}" })
	public String AddLess(HttpServletRequest req, HttpSession sesstion, @PathVariable String id) {
		String link = "https://bookstoreute.onrender.com/sachbyid/" + id;
		String check = JavaWebMVC.API.CallAPI.Get(link).toString();
		Double TotalPriceInCart = 0.0;
		if (id != null && id != "") {
			for (Cart item : Cart) {
				if (item.getBookId().equalsIgnoreCase(id) && item.getQuatity() > 1) {
					item.setQuatity(item.getQuatity() - 1);
					JSONObject json = new JSONObject(check.toString());
					JSONArray jsonarr = (JSONArray) json.get("data");
					jsonarr.forEach(data -> {
						JSONObject jsonobject = (JSONObject) data;
						item.setTotalPrice(item.getQuatity() * jsonobject.getDouble("Giaban"));
					});
				}
			}
		}
		for (Cart item : Cart) {
			TotalPriceInCart = TotalPriceInCart + item.getTotalPrice();
		}

		sesstion.setAttribute("ItemCart", Cart);
		sesstion.setAttribute("TotalPriceInCart", TotalPriceInCart);
		sesstion.setAttribute("CountCart", Cart.size());
		return "redirect:" + req.getHeader("Referer");
	}

	// Phần xóa một sp trong giỏ hàng
	@RequestMapping(value = { "/remove/{id}" })
	public String Remove(HttpServletRequest req, HttpSession sesstion, @PathVariable String id) {
		Double TotalPriceInCart = 0.0;
		try {
			if (id != null && id != "") {
				for (Cart item : Cart) {
					if (item.getBookId().equalsIgnoreCase(id)) {
						Cart.remove(Cart.indexOf(item));
					}
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		for (Cart item : Cart) {
			TotalPriceInCart = TotalPriceInCart + item.getTotalPrice();
		}
		sesstion.setAttribute("ItemCart", Cart);
		sesstion.setAttribute("TotalPriceInCart", TotalPriceInCart);
		sesstion.setAttribute("CountCart", Cart.size());
		return "redirect:" + req.getHeader("Referer");
	}

	// Phần xóa toàn bộ trong giỏ hàng
	@RequestMapping(value = { "/removeAll" })
	public String RemoveAll(HttpSession sesstion, HttpServletRequest req) {
		Double TotalPriceInCart = 0.0;
		try {
			Cart.removeAll(Cart);

		} catch (Exception e) {
			System.out.println(e);
		}
		for (Cart item : Cart) {
			TotalPriceInCart = TotalPriceInCart + item.getTotalPrice();
		}
		sesstion.setAttribute("ItemCart", Cart);
		sesstion.setAttribute("TotalPriceInCart", TotalPriceInCart);
		sesstion.setAttribute("CountCart", Cart.size());
		return "redirect:" + req.getHeader("Referer");
	}

	// Phần đặt hàng
	@RequestMapping(value = { "/order" })
	public String Oder(HttpSession sesstion, HttpServletRequest req) {
		if (sesstion.getAttribute("id") == null) {
			return "redirect:/signin";
		}
		if (sesstion.getAttribute("Email") == null) {
			return "redirect:/myprofile";
		}
		ArrayList<Object> IdInCart = new ArrayList<Object>();
		ArrayList<Integer> QuatityInCart = new ArrayList<>();
		Double TotalPriceInCart = 0.0;
		if (!Cart.isEmpty() && Double.parseDouble(sesstion.getAttribute("TotalPriceInCart").toString()) > 0
				&& sesstion.getAttribute("id") != null) {
			for (Cart item : Cart) {
				IdInCart.add(item.getBookId());
				QuatityInCart.add(item.getQuatity());
			}

			DateFormat dateFormat2 = new SimpleDateFormat("yyyy/MM/dd");
			Calendar cal2 = Calendar.getInstance();
			String date2 = dateFormat2.format(cal2.getTime());

			String dataDH = "{\n \"Dathanhtoan\":" + false + ",\n \"Tinhtranggiaohang\":" + false + ",\n \"Ngaydat\":\""
					+ date2 + "\",\n \"TongTien\":" + sesstion.getAttribute("TotalPriceInCart") + ",\n \"MaKH\":\""
					+ sesstion.getAttribute("id") + "\",\n \"MasachCheck\":" + IdInCart + ",\n \"SoluongCheck\":"
					+ QuatityInCart + "\n}";

			String linkDH = "https://bookstoreute.onrender.com/DonHang";
			JSONObject body = new JSONObject(dataDH);
			String BodyString = body.toString();

			JSONObject jsonDH = new JSONObject(JavaWebMVC.API.CallAPI.post(linkDH, BodyString).toString());

			if (jsonDH.getString("_id") != null) {
				Boolean flag = true;
				for (Cart item2 : Cart) {
					String dataCTDH = "{\n\"MaDonHang\":\"" + jsonDH.getString("_id") + "\",\n\"Masach\":\""
							+ item2.getBookId() + "\",\n\"Soluong\":" + item2.getQuatity() + ",\n\"Dongia\":"
							+ item2.getTotalPrice() + "\n}";

					String linkCTDH = "https://bookstoreute.onrender.com/CTDonHang";

					JSONObject jsonCTDH = new JSONObject(JavaWebMVC.API.CallAPI.post(linkCTDH, dataCTDH).toString());
					if (jsonCTDH.getString("_id") == null) {
						flag = false;
					}
				}
				if (flag) {
					Cart.removeAll(Cart);
					for (Cart item : Cart) {
						TotalPriceInCart = TotalPriceInCart + item.getTotalPrice();
					}
					sesstion.setAttribute("ItemCart", Cart);
					sesstion.setAttribute("TotalPriceInCart", TotalPriceInCart);
					sesstion.setAttribute("CountCart", Cart.size());
					sesstion.setAttribute("Status", "Cảm ơn bạn đã chọn mua sản phẩm của nhà sách chúng tôi");
					return "/user/dialogOrder";
				} else {
					sesstion.setAttribute("Status", "Đã xảy ra lỗi trong quá trình thêm Chi tiết đơn đặt hàng");
					return "/user/dialogOrder";
				}
			} else {
				sesstion.setAttribute("Status", "Đã xảy ra lỗi trong quá trình đặt hàng");
				return "/user/dialogOrder";
			}
		}
		sesstion.setAttribute("Status", "Đã xảy ra lỗi trong quá trình đặt hàng");
		return "/user/dialogOrder";
	}

	@RequestMapping(value = { "/history-pay" })
	public ModelAndView HistoryPay(HttpSession session) {
		ArrayList<UserBill> listUserBill = new ArrayList<UserBill>();
		if (session.getAttribute("id") != null) {
			String link = "https://bookstoreute.onrender.com/DonHangbyidKH/" + session.getAttribute("id");
			StringBuffer res = JavaWebMVC.API.CallAPI.Get(link);

			if (res != null) {
				JSONArray json = new JSONArray(res.toString());
				json.forEach(data -> {
					JSONObject jsonobject = (JSONObject) data;
					UserBill userBill = new UserBill();
					userBill.setId(jsonobject.getString("_id"));
					userBill.setDatthanhtoan(jsonobject.getBoolean("Dathanhtoan"));
					userBill.setTinhtranggiaohang(jsonobject.getBoolean("Tinhtranggiaohang"));
					userBill.setNgaydat(jsonobject.getString("Ngaydat"));
					userBill.setTongTien(jsonobject.getDouble("TongTien"));
					listUserBill.add(userBill);
				});
			} else {
				ModelAndView mv = new ModelAndView("/user/historypay");
				mv.addObject("Mess", "Chưa Có Lịch Sử Mua Hàng");
				return mv;
			}
		}
		ModelAndView mv = new ModelAndView("/user/historypay");
		mv.addObject("listUserBill", listUserBill);
		return mv;
	}
}
