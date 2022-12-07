package Model;

import java.util.ArrayList;
import org.json.JSONObject;

public class Pagination {
	public ArrayList<config> config = new ArrayList<config>();

	private String listString;

	public void init(ArrayList<config> config) {

		String linkbook = "https://bookstoreute.onrender.com/";

		this.config = config;
		this.config.forEach(data -> {

			if (data.getLimit() < 0) {
				data.setLimit(0);
			}
			// - Náº¿u ngÆ°á»�i dÃ¹ng truyá»�n vÃ o sá»‘ trang nhá»� hÆ¡n 1 thÃ¬ ta sáº½ gÃ¡n nÃ³ = 1
			if (data.getCurrent_page() < 1) {
				data.setCurrent_page(1);
			}

			int pages = data.getCurrent_page();
			int last = data.getLimit();

			String api = data.getApi();
			String dataapi = linkbook + api + "/" + pages + "/" + last;
			JSONObject list;
			StringBuffer check;

			if (data.getBody() != null && data.getBody() != "") {
				dataapi = linkbook + api;
				String datapost = "{\"keyword\":\"" + data.getBody() + "\",\"page\":" + pages + ",\"limit\":" + last
						+ "}";
				check = JavaWebMVC.API.CallAPI.post(dataapi, datapost);
			} else {
				check = JavaWebMVC.API.CallAPI.Get(dataapi);
			}
			if (check != null) {
				list = new JSONObject(check.toString());
				if (!(list.has("data"))) {
					listString = null;
				} else {
					listString = list.get("data").toString();

					data.setCount(list.getInt("count"));

					int TotalPage = (int) Math.ceil((double) data.getCount() / last);
					data.setTotal_page(TotalPage);

					/*
					 * Sau khi cÃ³ tá»•ng sá»‘ trang ta kiá»ƒm tra xem nÃ³ cÃ³ nhá»� hÆ¡n 0 hay khÃ´ng náº¿u nhá»�
					 * hÆ¡n 0 thÃ¬ gÃ¡n nÃ³ bÄƒng 1 ngay. VÃ¬ máº·c Ä‘á»‹nh tá»•ng sá»‘ trang luÃ´n báº±ng 1
					 */
					if (data.getTotal_page() < 0) {
						data.setTotal_page(1);
					}
					/*
					 * Trang hiá»‡n táº¡i sáº½ rÆ¡i vÃ o má»™t trong cÃ¡c trÆ°á»�ng há»£p sau: - Náº¿u trang hiá»‡n táº¡i
					 * ngÆ°á»�i dÃ¹ng truyá»�n vÃ o lá»›n hÆ¡n tá»•ng sá»‘ trang thÃ¬ ta gÃ¡n nÃ³ báº±ng tá»•ng sá»‘ trang
					 * Ä�Ã¢y lÃ  váº¥n Ä‘á»� giÃºp web cháº¡y trÆ¡n tru hÆ¡n, vÃ¬ Ä‘Ã´i khi ngÆ°á»�i dÃ¹ng cá»‘ Ã½ thay Ä‘á»•i
					 * tham sá»‘ trÃªn url nháº±m kiá»ƒm tra lá»—i web cá»§a chÃºng ta
					 */

					if (data.getCurrent_page() > data.getTotal_page()) {
						data.setCurrent_page(data.getTotal_page());
						pages = data.getCurrent_page();
						dataapi = linkbook + api + "/" + pages + "/" + last;
						list = new JSONObject(JavaWebMVC.API.CallAPI.Get(dataapi).toString());
						listString = list.get("data").toString();

					}
					/*
					 * BÃ¢y giá»� ta tÃ­nh sá»‘ trang ta show ra trang web TrÆ°á»›c tiÃªn tÃ­nh middle, Ä‘Ã¢y
					 * chÃ­nh lÃ  sá»‘ náº±m giá»¯a trong khoáº£ng tá»•ng sá»‘ trang mÃ  báº¡n muá»‘n hiá»ƒn thá»‹ ra mÃ n
					 * hÃ¬nh
					 */
					int middle = (int) Math.ceil((double) data.getRange() / 2);

					/*
					 * Ta sáº½ lÃ¢m vÃ o cÃ¡c trÆ°á»�ng há»£p nhÆ° bÃªn dÆ°á»›i Trong trÆ°á»�ng há»£p tá»•ng sá»‘ trang mÃ 
					 * bÃ© hÆ¡n range thÃ¬ ta show háº¿t luÃ´n, khÃ´ng cáº§n tÃ­nh toÃ¡n lÃ m gÃ¬ tá»©c lÃ  gÃ¡n min
					 * = 1 vÃ  max = tá»•ng sá»‘ trang luÃ´n
					 */
					if (data.getTotal_page() < data.getRange()) {
						data.setMin(1);
						data.setMax(data.getTotal_page());
					}
					/* TrÆ°á»�ng há»£p tá»•ng sá»‘ trang mÃ  lá»›n hÆ¡n range */
					else {

						// Ta sáº½ gÃ¡n min = current_page - middle + 1
						data.setMin(data.getCurrent_page() - middle + 1);

						// Ta sáº½ gÃ¡n max = current_page + middle - 1
						data.setMax(data.getCurrent_page() + middle - 1);

						// Sau khi tÃ­nh min vÃ  max ta sáº½ kiá»ƒm tra
						// náº¿u min < 1 thÃ¬ ta sáº½ gÃ¡n min = 1 vÃ  max báº±ng luÃ´n range
						if (data.getMin() < 1) {
							data.setMin(1);
							data.setMax(data.getRange());
						}

						// Náº¿u max > tá»•ng sá»‘ trang
						// ta gÃ¡n max = tá»•ng sá»‘ trang vÃ  min = (tá»•ng sá»‘ trang - range) + 1
						else if (data.getMax() > data.getTotal_page()) {
							data.setMax(data.getTotal_page());
							data.setMin(data.getTotal_page() - data.getRange() + 1);
						}
					}
				}
			}
		});
	}

	/*
	 * HÃ m Láº¥y Danh SÃ¡ch Tá»« API
	 */
	public String Getlist() {
		return listString;
	}

	private String link(int page) {
		String link_first;
		String link_full;

		link_first = this.config.get(0).link_first;
		link_full = this.config.get(0).link_full;

		// Náº¿u trang < 1 thÃ¬ ta sáº½ láº¥y link first
		if (page <= 1) {
			return link_first;
		}
		// NgÆ°á»£c láº¡i ta láº¥y link_full

		return link_full.replace("{page}", String.valueOf(page));
	}

	/*
	 * HÃ m láº¥y mÃ£ html
	 */
	public String html() {
		String p = "";
		if (String.valueOf(this.config.get(0).count) != null && this.config.get(0).count != 0) {

			if (this.config.get(0).count > this.config.get(0).limit) {
				p = "<ul  class=\"pagination\" id=\"pagination\">";

				// NÃºt prev vÃ  first
				if (this.config.get(0).current_page > 1) {
					p += "<li  class=\"page-item\"><a class=\"page-link\"  href=\"" + link(1) + "\">First</a></li>";
					p += "<li  class=\"page-item\"><a class=\"page-link\"  href=\""
							+ link(this.config.get(0).current_page - 1) + "\">Prev</a></li>";
				}

				// láº·p trong khoáº£ng cÃ¡ch giá»¯a min vÃ  max Ä‘á»ƒ hiá»ƒn thá»‹ cÃ¡c nÃºt
				for (int i = this.config.get(0).min; i <= this.config.get(0).max; i++) {
					// Trang hiá»‡n táº¡i
					if (this.config.get(0).current_page == i) {
						p += "<li  class=\"page-item active\"><a class=\"page-link\" >" + i + "</a></li>";
					} else {
						p += "<li  class=\"page-item\"><a class=\"page-link\"  href=\"" + link(i) + "\">" + i
								+ "</a></li>";
					}

				}
//
				// NÃºt last vÃ  next
				if (this.config.get(0).current_page < this.config.get(0).total_page) {
					p += "<li class=\"page-item\"><a class=\"page-link\"  href=\""
							+ link(this.config.get(0).current_page + 1) + "\">Next</a></li>";
					p += "<li class=\"page-item\"><a class=\"page-link\"  href=\"" + link(this.config.get(0).total_page)
							+ "\">Last</a></li>";
				}

				p += "</ul>";
			}
			return p;
		}
		return p;
	}
}
