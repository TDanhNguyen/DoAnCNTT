package JavaWebMVC.Controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import Model.Book;
import Model.Chude;

@Controller
public class BookController {

	public JSONObject GetforHome() {
		String linkapi = "https://bookstoreute.onrender.com/home";
		StringBuffer res = JavaWebMVC.API.CallAPI.Get(linkapi);
		JSONObject json = null;
		if (res != null) {
			json = new JSONObject(res.toString());
		}
		return json;
	}

	public ArrayList<Book> GetlistBook(JSONArray arr) {
		ArrayList<Book> book1 = new ArrayList<Book>();
		if (arr != null) {
			arr.forEach(data -> {
				JSONObject jsonobject = (JSONObject) data;
				Book book = new Book();
				if (jsonobject.has("Messager")) {
					book.setMessager(jsonobject.getString("Messager"));
				} else {
					book.setID(jsonobject.getString("id"));
					book.setTensach(jsonobject.getString("Tensach"));
					book.setAnh(jsonobject.getString("Anh"));
					book.setMessager(null);
					book.setTenTG(jsonobject.getString("TenTG"));
					if (jsonobject.has("Mota")) {
						book.setMota(jsonobject.getString("Mota"));
					} else {
						book.setMota("");
					}
					if (jsonobject.has("Giaban")) {
						book.setGiaban(jsonobject.getDouble("Giaban"));
						;
					} else {
						book.setGiaban((double) 0);
					}
				}
				book1.add(book);
			});
		}
		return book1;
	}

	@RequestMapping(value = { "/products" })
	public ModelAndView Products(HttpServletRequest req) throws UnsupportedEncodingException {
		String link = "https://bookstoreute.onrender.com/chude";
		String check = JavaWebMVC.API.CallAPI.Get(link).toString();
		req.setCharacterEncoding("UTF-8");
		ArrayList<Chude> CD = new ArrayList<Chude>();
		if (check != null) {
			JSONArray json = new JSONArray(JavaWebMVC.API.CallAPI.Get(link).toString());
			json.forEach(data -> {
				JSONObject jsonobject = (JSONObject) data;
				Chude chude = new Chude();
				chude.set_id(jsonobject.getString("_id"));
				chude.setTenChuDe(jsonobject.getString("TenChuDe"));
				CD.add(chude);
			});
		}
		ModelAndView mv = new ModelAndView("/user/products");
		mv.addObject("Chude", CD);
		mv.addObject("keyword", req.getParameter("keyword"));
		return mv;
	}
}
