<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
@charset "UTF-8";

@import
	url("https://fonts.googleapis.com/css2?family=Akaya+Telivigala&display=swap")
	;

::-webkit-scrollbar {
	width: 8px;
}

/* Track */
::-webkit-scrollbar-track {
	box-shadow: inset 0 0 5px #111;
}

/* Handle */
::-webkit-scrollbar-thumb {
	background: #888;
}

.navbar-brand {
	font-family: 'Akaya Telivigala', cursive;
	font-size: 30px;
}

ion-icon {
	font-size: 25px;
	padding: 4px;
}

#navbarMenu ul li a {
	position: relative;
}

#navbarMenu ul li a::after {
	content: '';
	display: block;
	height: 2px;
	background-color: black;
	width: 0px;
	margin-top: 1px;
}

#navbarMenu ul li a:hover::after {
	width: 100%;
	-webkit-transition: .5s;
	transition: .5s;
}

.dropdown-item:active {
	background-color: black !important;
	color: white;
}

.nav-link:hover {
	color: black !important;
}

</style>

<nav
	class="navbar navbar-expand-md navbar-light border-bottom border-3 align-items-center">
	<div class="container-fluid justify-content-around align-items-center">
		<a class="navbar-brand d-flex align-items-center me-md-auto ms-md-5"
			href="/JavaWebMVC/"> <ion-icon name="book-outline"></ion-icon> MBook
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarMenu" aria-controls="navbarMenu"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse"
			id="navbarMenu">
			<ul class="navbar-nav text-center p-md-3 mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="account-manager">Tài Khoản</a></li>
				<li class="nav-item"><a class="nav-link" href="bill-pay">Hóa Đơn</a></li>
				<li class="nav-item"><a class="nav-link" href="storage-products">Hàng Tồn Kho</a></li>
				<li class="nav-item"><a class="nav-link" href="setting">Thiết Lập</a></li>
				<li class="nav-item"><a class="nav-link" href="new-book">Thêm Mới Sách</a></li>
			</ul>
		</div>
	</div>
</nav>

