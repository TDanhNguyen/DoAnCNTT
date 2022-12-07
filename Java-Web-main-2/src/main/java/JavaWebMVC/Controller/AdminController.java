package JavaWebMVC.Controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import Model.NXB;
import Model.Tacgia;
import Model.theloai;

@Controller
public class AdminController {

	@RequestMapping(value = { "/admin/index" })
	public ModelAndView Admin(HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("Role") != null && (session.getAttribute("Role").toString() == "true")) {

			ModelAndView mv = new ModelAndView("/admin/index");
			mv.addObject("Admin", session.getAttribute("Name").toString());
			return mv;
		} else {
			ModelAndView mv = new ModelAndView("/admin/NoAdmin");
			return mv;
		}
	}

	@RequestMapping(value = { "/admin/account-manager" })
	public ModelAndView Acc_Manager(HttpSession session, HttpServletRequest request)
			throws UnsupportedEncodingException {
		if (session.getAttribute("Role") != null && (session.getAttribute("Role").toString() == "true")) {
			ModelAndView mv = new ModelAndView("/admin/account-manager");
			return mv;
		} else {
			ModelAndView mv = new ModelAndView("/admin/NoAdmin");
			return mv;
		}

	}

	@RequestMapping(value = { "/admin/bill-pay" })

	public ModelAndView Bill_Pay(HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("Role") != null && (session.getAttribute("Role").toString() == "true")) {
			ModelAndView mv = new ModelAndView("/admin/billpay");
			return mv;
		} else {
			ModelAndView mv = new ModelAndView("/admin/NoAdmin");
			return mv;
		}

	}

	@RequestMapping(value = { "/admin/bill-pay" }, method = RequestMethod.POST)

	public ModelAndView Bill_Pay1(HttpServletRequest request) {
		String link = "https://bookstoreute.onrender.com/DonHang";
		String Body = "{\"id\":\"" + request.getParameter("id") + "\",\"Tinhtranggiaohang\":true}";
		JavaWebMVC.API.CallAPI.put(link, Body);
		return null;
	}

	@RequestMapping(value = { "/admin/storage-products" })
	public ModelAndView Storage(HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("Role") != null && (session.getAttribute("Role").toString() == "true")) {
			ModelAndView mv = new ModelAndView("/admin/storage");
			return mv;
		} else {
			ModelAndView mv = new ModelAndView("/admin/NoAdmin");
			return mv;
		}

	}

	@RequestMapping(value = { "/admin/setting" })
	public ModelAndView Setting(HttpSession session) {
		try {

			if (session.getAttribute("Role") != null && (session.getAttribute("Role").toString() == "true")) {
				// Code more here:

				String linkgetallchudeTGNXB = "https://bookstoreute.onrender.com/GETALL";

				StringBuffer resAPI = JavaWebMVC.API.CallAPI.Get(linkgetallchudeTGNXB);

				ArrayList<NXB> listnxb = new ArrayList<NXB>();
				ArrayList<theloai> listcd = new ArrayList<theloai>();
				ArrayList<Tacgia> listtacgia = new ArrayList<Tacgia>();

				if (resAPI != null) {
					JSONObject jsonObject = new JSONObject(resAPI.toString());
					JSONArray jsonchude = (JSONArray) jsonObject.get("NXB");

					jsonchude.forEach(data -> {
						JSONObject dataCD = (JSONObject) data;
						NXB nxb = new NXB();
						nxb.set_id(dataCD.getString("_id"));
						nxb.setTenNXB(dataCD.getString("TenNXB"));
						listnxb.add(nxb);
					});

					JSONArray jsontacgia = (JSONArray) jsonObject.get("tacgia");
					jsontacgia.forEach(data -> {
						JSONObject dataTG = (JSONObject) data;
						Tacgia tg = new Tacgia();
						tg.set_id(dataTG.getString("_id"));
						tg.setTenTG(dataTG.getString("TenTG"));
						listtacgia.add(tg);
					});

					JSONArray jsonNXB = (JSONArray) jsonObject.get("chude");
					jsonNXB.forEach(data -> {
						JSONObject dataNXB = (JSONObject) data;
						theloai cd = new theloai();
						cd.set_id(dataNXB.getString("_id"));
						cd.setTenChuDe(dataNXB.getString("TenChuDe"));
						listcd.add(cd);
					});
				}
				
				ModelAndView mv = new ModelAndView("/admin/settingview");
				mv.addObject("listnxb", listnxb);
				mv.addObject("listcd", listcd);
				mv.addObject("listtacgia", listtacgia);
				return mv;
			} else {
				ModelAndView mv = new ModelAndView("/admin/NoAdmin");
				return mv;
			}

		} catch (Exception e) {
			System.out.println("admin Setting Error: " + e);
		}
		return null;
	}

	@RequestMapping(value = { "/admin/setting" }, method = RequestMethod.POST)
	public ModelAndView Setting(HttpServletRequest req, HttpSession session) {
		if (session.getAttribute("Role") != null && (session.getAttribute("Role").toString() == "true")) {
			// Code more here:
			try {
				req.setCharacterEncoding("UTF-8");
				if (req.getParameter("inputNXB") != null && req.getParameter("inputAddress") != null
						&& req.getParameter("inputNXB") != "" && req.getParameter("inputAddress") != "") {
					String data = "{\"TenNXB\":\"" + req.getParameter("inputNXB") + "\",\"Diachi\":\""
							+ req.getParameter("inputAddress") + "\",\"DienThoai\":\"" + req.getParameter("inputPhone")
							+ "\"}";
					String linkapi = "https://bookstoreute.onrender.com/nhaxuatban";
					JavaWebMVC.API.CallAPI.post(linkapi, data);
				}

				if (req.getParameter("inputCategory") != null && req.getParameter("inputCategory") != "") {
					String dataCategory = "{\"TenChuDe\":\"" + req.getParameter("inputCategory") + "\"}";
					String apiNewCategory = "https://bookstoreute.onrender.com/chude";
					JavaWebMVC.API.CallAPI.post(apiNewCategory, dataCategory);
				}

				if (req.getParameter("inputAuthorName") != null && req.getParameter("inputAuthorName") != ""
						&& req.getParameter("inputAuthorAddr") != null && req.getParameter("inputAuthorAddr") != ""
						&& req.getParameter("inputAuthorHist") != null && req.getParameter("inputAuthorHist") != ""
						&& req.getParameter("inputAuthorPhone") != null && req.getParameter("inputAuthorPhone") != "") {
					String dataAuthor = "{\"TenTG\":\"" + req.getParameter("inputAuthorName") + "\",\"Diachi\":\""
							+ req.getParameter("inputAuthorAddr") + "\",\"Tieusu\":\""
							+ req.getParameter("inputAuthorHist") + "\",\"Dienthoai\":\""
							+ req.getParameter("inputAuthorPhone") + "\"}";
					String apiNewAuthor = "https://bookstoreute.onrender.com/tacgia";
					JavaWebMVC.API.CallAPI.post(apiNewAuthor, dataAuthor);
				}

			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			ModelAndView mv = new ModelAndView("redirect:/admin/settingview");
			return mv;
		} else {
			ModelAndView mv = new ModelAndView("/admin/NoAdmin");
			return mv;
		}
	}

	@RequestMapping(value = { "/admin/new-book" })
	public ModelAndView NewBook(HttpServletRequest req, HttpSession session) {
		if (session.getAttribute("Role") != null && (session.getAttribute("Role").toString() == "true")) {

			String linkgetallchudeTGNXB = "https://bookstoreute.onrender.com/GETALL";

			StringBuffer resAPI = JavaWebMVC.API.CallAPI.Get(linkgetallchudeTGNXB);

			ArrayList<NXB> listnxb = new ArrayList<NXB>();
			ArrayList<theloai> listcd = new ArrayList<theloai>();
			ArrayList<Tacgia> listtacgia = new ArrayList<Tacgia>();

			if (resAPI != null) {
				JSONObject jsonObject = new JSONObject(resAPI.toString());
				JSONArray jsonchude = (JSONArray) jsonObject.get("NXB");

				jsonchude.forEach(data -> {
					JSONObject dataCD = (JSONObject) data;
					NXB nxb = new NXB();
					nxb.set_id(dataCD.getString("_id"));
					nxb.setTenNXB(dataCD.getString("TenNXB"));
					listnxb.add(nxb);
				});

				JSONArray jsontacgia = (JSONArray) jsonObject.get("tacgia");
				jsontacgia.forEach(data -> {
					JSONObject dataTG = (JSONObject) data;
					Tacgia tg = new Tacgia();
					tg.set_id(dataTG.getString("_id"));
					tg.setTenTG(dataTG.getString("TenTG"));
					listtacgia.add(tg);
				});

				JSONArray jsonNXB = (JSONArray) jsonObject.get("chude");
				jsonNXB.forEach(data -> {
					JSONObject dataNXB = (JSONObject) data;
					theloai cd = new theloai();
					cd.set_id(dataNXB.getString("_id"));
					cd.setTenChuDe(dataNXB.getString("TenChuDe"));
					listcd.add(cd);
				});
			}

			ModelAndView mv = new ModelAndView("/admin/addnewbook");
			mv.addObject("listnxb", listnxb);
			mv.addObject("listcd", listcd);
			mv.addObject("listtacgia", listtacgia);
			return mv;
		} else {
			ModelAndView mv = new ModelAndView("/admin/NoAdmin");
			return mv;
		}
	}

}
