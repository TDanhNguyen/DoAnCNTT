<%@page import="org.json.JSONObject"%>
<%@page import="Model.User"%>
<%@page import="org.json.JSONArray"%>
<%@page import="Model.config"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Pagination"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<body>
	<div class="Admin__Account-Header">
		<div class="Checkbox__All-Account"></div>
		<div class="Title__username">Tài Khoản</div>
		<div class="Title__email">Email</div>
		<div class="Title__role">Loại Tài Khoản</div>

		<div class="Title__setting">Thiết Lập</div>
	</div>
	<div class="Admin__Account-Body">
		<%
		ArrayList<config> cg = new ArrayList<config>();
		config con = new config();
		con.setApi("khachhangforadmin/false");
		con.setCurrent_page(request.getParameter("pages") != null ? Integer.parseInt(request.getParameter("pages")) : 1);
		con.setLimit(4);
		con.setLink_full("?pages={page}");
		con.setLink_first("/JavaWebMVC/admin/account-manager");
		con.setRange(3);
		cg.add(con);

		Pagination pg = new Pagination();
		pg.init(cg);

		ArrayList<User> user = new ArrayList<User>();

		JSONArray data = new JSONArray(pg.Getlist());

		data.forEach(d -> {
			JSONObject json = (JSONObject) d;
			User u = new User();
			u.setHoTen(json.getString("HoTen"));
			if (json.has("Email")) {
				u.setEmail(json.getString("Email"));
			} else {
				u.setEmail("Chưa Cập Nhật Email");
			}

			u.setRole(json.getBoolean("Role"));
			u.setId(json.getString("_id"));
			user.add(u);
		});
		%>
		<c:forEach var="data" items="<%=user%>">
			<div class="Admin__Account-Account-Details">
				<div class="Checkbox__Account">
					<input type="checkbox" name="" class="checkbox"
						id="checkbox__account" onclick="ifChecked()" )>
				</div>

				<div class="User__username">${data.getHoTen() }</div>
				<div class="User__email">${data.getEmail() }</div>

				<c:if test="${data.getRole() == false}">
					<div class="User__role">Khách</div>
				</c:if>
				<c:if test="${data.getRole() == true}">
					<div class="User__role">Admin</div>
				</c:if>
				<div class="User__setting">
					<div class="User__setting-deleteAccount"
						onclick="showDialogDeleteAccount('${data.id}','${data.role}}')">Xóa Tài Khoản</div>
				</div>
			</div>
		</c:forEach>

		<%=pg.html()%>
		<div class="UpdateAll__Setting" id="UpdateAll">Cấp Quyền Admin</div>
	</div>
	<script >
	

	
	
	</script>
</body>
