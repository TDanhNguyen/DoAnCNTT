<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="JavaWebMVC.Controller.BookController"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<body>
	<div id="carouselBanner" class="carousel slide" data-bs-ride="carousel">
		<!-- Start Banner -->
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselBanner"
				data-bs-slide-to="0" class="active" aria-current="true"
				aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselBanner"
				data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselBanner"
				data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner Banner__Container">
			<%
			BookController bookctl = new BookController();
		   	JSONObject list = bookctl.GetforHome();
			JSONObject banner = (JSONObject) list.get("Banner");
			String banner1 = banner.getString("Anh1");
			String banner2 = banner.getString("Anh2");
			String banner3 = banner.getString("Anh3");
			%>
			<div class="carousel-item Banner active">
				<img src="<%=banner1%>" class="" alt="...">
			</div>
			<div class="carousel-item Banner">
				<img src="<%=banner2%>" class="" alt="...">
			</div>
			<div class="carousel-item Banner">
				<img src="<%=banner3%>" class="" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselBanner" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselBanner" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
	<!-- End Banner-->

	<p class="Title">SÁCH BÁN CHẠY</p>
	<!-- Start Selling Books -->
	<div class="carousel slide" id="carouselListSelling"
		data-bs-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<div class="Slide__Book">
					<%
					JSONArray book1 = (JSONArray) list.get("Book1");
					List<Model.Book> list1 = new BookController().GetlistBook(book1);
					for (Model.Book item : list1) {
					%>
					<a class="SellingBook" href="details?id=<%=item.getID()%>">
						<div class="ImgBook">
							<img src="<%=item.getAnh()%>" alt="">
						</div>
						<div class="BookContent">
							<p class="BookTitle">
								<%=item.getTensach()%>
							</p>
							<p class="Author">
								<%=item.getTenTG()%>
							</p>
						</div>
					</a>
					<%
					}
					%>
				</div>
			</div>
			<div class="carousel-item">
				<div class="Slide__Book">
					<%
					JSONArray book2 = (JSONArray) list.get("Book2");
					List<Model.Book> list2 = new BookController().GetlistBook(book2);
					for (Model.Book item : list2) {
					%>
					<a class="SellingBook" href="details?id=<%=item.getID()%>">
						<div class="ImgBook">
							<img src="<%=item.getAnh()%>" alt="">
						</div>
						<div class="BookContent">
							<p class="BookTitle">
								<%=item.getTensach()%>
							</p>
							<p class="Author">
								<%=item.getTenTG()%>
							</p>
						</div>
					</a>
					<%
					}
					%>
				</div>
			</div>
		</div>
		<button class="carousel-control-prev btnCarousel" type="button"
			data-bs-target="#carouselListSelling" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next btnCarousel" type="button"
			data-bs-target="#carouselListSelling" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
	<!-- End Selling Book -->
	<%
	int var = 1;
	%>
	<p class="Title">SÁCH HAY</p>
	<div id="carouselGoodBook" class="carousel slide"
		data-bs-ride="carousel">
		<div class="carousel-inner">

			<%
			JSONArray book3 = (JSONArray) list.get("Book3");
			List<Model.Book> list3 = new BookController().GetlistBook(book3);
			for (Model.Book item : list3) {
				if (var == 1) {
			%>
			<div class="carousel-item active">
				<div class="Good__Book">
					<div class="Good__Book-image">
						<img src="<%=item.getAnh()%>" alt="">
					</div>
					<div class="Good__Book-about">
						<div class="Good__Book-header">
							<h3>
								<%=item.getTensach()%>
							</h3>
							<p>
								Tác Giả:
								<%=item.getTenTG()%>
							</p>
						</div>
						<div class="Good__Book-body">
							<%=item.getMota()%>
						</div>
						<a class="Good__Book-readnow" href="details?id=<%=item.getID()%>">
							Đọc Ngay </a>
					</div>
				</div>
			</div>
			<%
			} else {
			%>
			<div class="carousel-item">
				<div class="Good__Book">
					<div class="Good__Book-image">
						<img src="<%=item.getAnh()%>" alt="">
					</div>
					<div class="Good__Book-about">
						<div class="Good__Book-header">
							<h3>
								<%=item.getTensach()%>
							</h3>
							<p>
								Tác Giả:
								<%=item.getTenTG()%>
							</p>
						</div>
						<div class="Good__Book-body">
							<%=item.getMota()%>
						</div>
						<a class="Good__Book-readnow" href="details?id=<%=item.getID()%>">
							Đọc Ngay </a>
					</div>
				</div>

			</div>
			<%
			}
			%>

			<%
			var++;
			}
			%>

		</div>
		<button class="carousel-control-prev btnCarousel" type="button"
			data-bs-target="#carouselGoodBook" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next btnCarousel" type="button"
			data-bs-target="#carouselGoodBook" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
</body>