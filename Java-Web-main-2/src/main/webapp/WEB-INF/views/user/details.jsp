<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<body>
	<div class="Details__container">
		<div class="Book__details">
			<c:forEach var="data" items="${Book}">
				<div class="Book__image">
					<img src="${data.getAnh() }" alt="">
				</div>

				<div class="Book__info">
					<div class="Book__info-Name">${data.getTensach()}</div>
					<div class="Book__info-Author">
						<span>Tác giả: <b>${data.getTenTG()}</b>
						</span>
					</div>
					<div class="Book__info-Publishing-company">
						<span>Nhà xuất bản: <b>${data.gettenNXB()}</b>
						</span>
					</div>
					<div class="Book__info-Price">
						<b class="price"> <fmt:formatNumber type="number"
								pattern="#,###0.000" value="${data.getGiaban()}" />đ
						</b>
					</div>
					<div class="Book__info-Pay">
						<c:choose>
							<c:when test="${data.getSoluongton() > 0 }">
								<div>
									<a class="Book__info-btnCart"
										href="<c:url value="/addCart/${data.getID()}"/>"> <span>Chọn
											Mua</span>
									</a>
								</div>
							</c:when>
							<c:otherwise>
								<b style="color: red;">Đã Hết Hàng</b>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div class="Book__info-About">
					<h3>Thông Tin Sản Phẩm:</h3>
					<span>${data.getMota()}</span>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="SameCategoryBooksTitle">Sách liên quan</div>
	<div class="samecategorySlide">
		<c:forEach var="data" items="${listSameCategory}">
			<a style="width: fit-content; text-decoration: none; color: black;"
				href="details?id=${data.get_id()}">
				<div class="SameCategoryBook">
					<div class="SameCategoryBook__Img">
						<img src="${data.getAnhbia() }" alt="">
					</div>
					<div class="SameCategoryBook__Content">
						<div class="SameCategoryBook__TitleBook">${data.getTensach()}</div>
						<div class="SameCategoryBook__Price">
							<fmt:formatNumber type="number" pattern="#,###0.000"
								value="${data.getGiaban()}" />
							đ
						</div>
					</div>
				</div>
			</a>
		</c:forEach>
	</div>
	<script>
		$(document)
				.ready(
						function() {
							$('.samecategorySlide')
									.slick(
											{
												slidesToShow : 5,
												slidesToScroll : 1,
												autoplay : true,
												infinite : true,
												arrows : true,
												autoplaySpeed : 2000,
												prevArrow : '<button type="button" class="slick-prev slick-arrow"><ion-icon name="arrow-back-outline"></ion-icon></button>',
												nextArrow : '<button type="button" class="slick-next slick-arrow"><ion-icon name="arrow-forward-outline"></ion-icon></button>',
												responsive : [ {
													breakpoint : 1024,
													settings : {
														slidesToShow : 3,
														slidesToScroll : 3,
													}
												}, {
													breakpoint : 600,
													settings : {
														slidesToShow : 2,
														slidesToScroll : 2,
													}
												}, {
													breakpoint : 480,
													settings : {
														slidesToShow : 2,
														slidesToScroll : 1,
													}
												}
												// You can unslick at a given breakpoint now by adding:
												// settings: "unslick"
												// instead of a settings object
												]
											});
						});
	</script>
	<script type="module"
		src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
	<script type="module"
		src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

</body>