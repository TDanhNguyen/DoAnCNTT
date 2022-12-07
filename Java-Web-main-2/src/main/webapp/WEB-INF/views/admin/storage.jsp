<%@page import="org.json.JSONObject"%>
<%@page import="Model.Book"%>
<%@page import="org.json.JSONArray"%>
<%@page import="Model.Pagination"%>
<%@page import="Model.config"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="Admin__Storage-Header">

	<div class="Title__Product-Image">Ảnh</div>
	<div class="Title__Product-Name">Tên Sách</div>
	<div class="Title__Product-Count">Số Lượng Tồn</div>
	<div class="Title__Product-Price">Giá</div>

	<div class="Title__Setting">Thiết Lập</div>
</div>
<div class="Admin__Storage-Body">
	<%
	ArrayList<config> cg = new ArrayList<config>();
	config con = new config();
	con.setApi("PhanTrang");
	con.setCurrent_page(request.getParameter("pages") != null ? Integer.parseInt(request.getParameter("pages")) : 1);
	con.setLimit(2);
	con.setLink_full("?pages={page}");
	con.setLink_first("/JavaWebMVC/admin/storage-products");
	con.setRange(3);
	cg.add(con);

	Pagination pg = new Pagination();
	pg.init(cg);

	ArrayList<Book> book = new ArrayList<Book>();

	JSONArray data = new JSONArray(pg.Getlist());
	
	data.forEach(d -> {
		JSONObject json = (JSONObject) d;
		Book b = new Book();	
		b.setID(json.getString("id"));
		b.setTensach(json.getString("Tensach"));
		b.setAnh(json.getString("Anh"));
		b.setMota(json.getString("Mota"));
		b.setSoluongton(json.getInt("Soluongton"));
		b.setGiaban(json.getDouble("Giaban"));
		book.add(b);		
	});
	%>
	<c:forEach var="data" items="<%=book %>">
		<div class="Admin__Storage-Details">
			<div class="Product__Image">
				<img src="${data.getAnh()}" alt="">
			</div>
			<div class="Product__Name">${data.getTensach()}</div>
			<div class="Product__Count">${data.getSoluongton()}</div>
			<div class="Product__Price">
				<fmt:formatNumber type="number" pattern="#,###0.000"
					value="${data.getGiaban()}" />
				đ
			</div>
			<div class="Bill__Setting">
				<div class="Bill__Setting-details"
					onclick="showDialogChangeDetailsProduct('${data.getID()}','${data.getGiaban()}')">Thay
					Đổi</div>
			</div>
		</div>
	</c:forEach>
	<%=pg.html() %>
</div>
<script>

const FormUpdate = document.getElementById("UpdateBook");
FormUpdate.addEventListener("submit", submitFormprofile);

function submitFormprofile(e) {
    e.preventDefault();  
    let dongia = document.getElementById("storagePrice").value;
    let ton = document.getElementById("storageNum").value;
    let check = [];
    check.push(dongia > 0);
    check.push(ton > 0);
    if (check.every((va) => va === true)) {           
     let body =
         '{"id":"' +
         IDBOOK +
         '","Giaban":' +
         dongia +
         ',"Soluongton":' +
         ton +
         "}";           
        put("sach", body)
            .then((res) => {
                if (res._id != null) {
                    alert("Cập Nhật Thành Công");
                    window.location.href = "/JavaWebMVC/admin/storage-products";
                } else {
                    alert(res);
                }
            })
            .catch((err) => {
                alert(err);
            });
    } else {
        alert("Vui Lòng Nhập Lại");
    }
}
async function put(url = "", bodyy) {
    let BookingApi = "https://bookstoreute.onrender.com/";
    const response = await fetch(BookingApi + url, {
        method: "PUT",
        headers: {
            "Content-Type": "application/json",
        },
        body: bodyy,
    });
    return response.json();
}

</script>