<%@page import="service.isNumber"%>
<%@page import="org.springframework.util.NumberUtils"%>
<%@page import="Model.Book"%>
<%@page import="Model.config"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Pagination"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="JavaWebMVC.Controller.BookController"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<body>
	<div class="Product__Container">
		<div class="Product__ListCategory">
			<h6>THỂ LOẠI SẢN PHẨM</h6>
			<ul>
				<c:forEach var="data" items="${Chude }">
					<li><a href="?chude=${data.get_id()}">${data.getTenChuDe()}</a></li>
				</c:forEach>
			</ul>
		</div>
		<div class="Product__ListProduct">
			<form action="products" method="post">
				<div class="Product__ListProduct-Sort">
					<input type="text" name="keyword" class="form-control"
						placeholder="Search..." />
					<div class="Product__ListProduct-SortArea">
						<h5>Sắp xếp theo:</h5>
						<select class="form-select" name="Sort"
							aria-label="-- Loại Sắp Xếp --">
							<option selected>Giá Tăng Dần</option>
							<option value="1">Giá Giảm Dần</option>
						</select>
					</div>
				</div>
			</form>
			<div class="Product__List">
				<%
				ArrayList<config> cg = new ArrayList<config>();
				config con = new config();
				con.setBody(null);
				con.setApi("PhanTrang");
				con.setCurrent_page(request.getParameter("pages") != null && isNumber.isNumeric(request.getParameter("pages"))
						? Integer.parseInt(request.getParameter("pages"))
						: 1);
				con.setLimit(8);
				con.setLink_full("?pages={page}");
				con.setLink_first("/JavaWebMVC/products");
				if (request.getParameter("chude") != null) {
					con.setBody(null);
					con.setApi("PhanTrangChuDe/" + request.getParameter("chude"));
					con.setLink_full("?pages={page}&chude=" + request.getParameter("chude"));
					con.setLink_first("/JavaWebMVC/products?chude=" + request.getParameter("chude"));
				}
				if (request.getParameter("keyword") != null) {
					con.setBody(request.getParameter("keyword"));
					con.setApi("PhanTrangSearch");
					con.setLink_full("?pages={page}&keyword=" + request.getParameter("keyword"));
					con.setLink_first("/JavaWebMVC/products?keyword=" + request.getParameter("keyword"));
				}
				con.setRange(3);
				cg.add(con);

				Pagination pg = new Pagination();
				pg.init(cg);

				ArrayList<Book> list = new ArrayList<Book>();

				if (pg.Getlist() == null) {
					out.print(
					"<div class='Cart__Products-Empty'> <div class='Cart__Products-Empty-image'> <img src='https://i.pinimg.com/originals/ec/0c/0c/ec0c0c652f7a9fb965bf08f45c4403fe.gif' alt=''> </div> <span>Not Found</span> </div>");
				} else {
					JSONArray data = new JSONArray(pg.Getlist());

					data.forEach(d -> {
						JSONObject json = (JSONObject) d;
						Book book = new Book();
						if (json.has("Messager")) {
					book.setMessager(json.getString("Messager"));
						} else {
					book.setID(json.getString("id"));
					book.setTensach(json.getString("Tensach"));
					book.setAnh(json.getString("Anh"));
					book.setMessager(null);
					book.setTenTG(json.getString("TenTG"));
					if (json.has("Mota")) {
						book.setMota(json.getString("Mota"));
					} else {
						book.setMota("");
					}
					if (json.has("Giaban")) {
						book.setGiaban(json.getDouble("Giaban"));
						;
					} else {
						book.setGiaban((double) 0);
					}
						}
						list.add(book);
					});

					for (Model.Book item : list) {
				%>

				<a class="Book" href="details?id=<%=item.getID()%>">
					<div class="Book__Img">
						<img src="<%=item.getAnh()%>" alt="">
					</div>
					<div class="Book__Content">
						<div class="Book__Content-BookName">
							<h3><%=item.getTensach()%></h3>
							<p class="Book__Content-Author"><%=item.getTenTG()%></p>
							<p class="Book__Content-Price">
								<fmt:formatNumber type="number" pattern="#,###0.000"
									value="<%=item.getGiaban()%>" />
								đ
							</p>
						</div>
					</div>
				</a>
				<%
				}
				}
				%>

			</div>
			<%=pg.html()%>
		</div>
	</div>
</body>