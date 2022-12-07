<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<body>
<div class="Cart__Container">
    <h3>GIỎ HÀNG</h3>
    <div class="Cart__Body">
        <div class="Cart__Products">
            <div class="Cart__Products-Header">
                <div class="Checkbox__All-Product">
                    <input type="checkbox" name="" class="checkbox" id="checkbox__all-product" onclick="onCheckAll()">
                </div>
                <span>Chọn tất cả (1 sản phẩm)</span>
                <div class="Title__Count">Số lượng</div>
                <div class="Title__Price">Giá</div>
                <div style="flex-basis: 5%;"></div>
            </div>
            <div class="Cart__Products-Body">
            	<c:forEach var="data" items="${ItemCart}">
                <div class="Cart__Products-item">
                    <div class="checkbox__product">
                        <input type="checkbox" name="" class="checkbox" id="checkbox__product">
                    </div>
                    <div class="imgbook">
                        <img src=${data.getPicBook() } class="Img__Book" alt="">
                    </div>
                    <a class="Cart__Products-BookName">
                        ${data.getBookName() }
                    </a>
                    <div class="Cart__Products-group-product-info">

                        <div class="Cart__Products-Count">
                            <div class="Cart__Products-Button">
                           		<a href="<c:url value="/addless/${data.getBookId()}"/>" class="Cart__Products-Button">
                           			<button onclick="">
                                    	<img src="https://frontend.tikicdn.com/_desktop-next/static/img/pdp_revamp_v2/icons-remove.svg"
                                        	alt="remove-icon" width="20" height="20">
                                	</button>
                           		</a>
                                <input id="inputNum" type="text" value=" ${data.getQuatity() }"class="input">
                                <a href="<c:url value="/addmore/${data.getBookId()}"/>" class="Cart__Products-Button">
                                	<button onclick="">
                                		<img src="https://frontend.tikicdn.com/_desktop-next/static/img/pdp_revamp_v2/icons-add.svg"
                                        alt="add-icon" width="20" height="20">
                                	</button>
                                </a>
                            </div>
                        </div>
                        <span><fmt:formatNumber type="number"
								pattern="#,###0.000" value="${data.getTotalPrice()}"/>đ</span>
						<a class="BtnDelete" href="<c:url value="/remove/${data.getBookId()}"/>" type="button">
							<ion-icon name="trash-outline"></ion-icon>
						</a>
                    </div>
					
                </div>
                </c:forEach>
            </div>
            <a href="<c:url value="/removeAll"/>">
            	<div class="Cart__Products-Footer" id="Cart__Products-Footer">
                	Xóa Toàn Bộ
            	</div>
            </a>
        </div>
        <div class="Cart__Bill">
            <h2>HÓA ĐƠN</h2>
            <div class="Cart__Bill-Info">
                <span class="Cart__Bill-Info-Name">
                    Tên: ${Name}
                </span>
               <span class="Cart__Bill-Info-Email">
                    Email:  ${Email }
                </span>
                <span class="Cart__Bill-Info-Phone">
                    SDT: ${SDT }
                </span>
                <span class="Cart__Bill-Info-Date">
                    Ngày Giao Dịch: ${Date }
                </span>
            </div>
            <div class="Cart__Bill-Pay">
            	<div class="Cart__Bill-Pay-Price">
                    	Tổng <span><fmt:formatNumber type="number"
								pattern="#,###0.000" value="${TotalPriceInCart}"/>đ</span>
                	</div>
                <a href="<c:url value="/order"/>">
                	 <div class="Cart__Bill-Pay-BtnPay">
                    	Thanh Toán
                	</div>
                </a>
            </div>
        </div>
    </div>
</div>
</body>