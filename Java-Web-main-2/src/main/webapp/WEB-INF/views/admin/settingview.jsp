<%@page import="org.json.JSONObject"%>
<%@ page
	import="java.io.*,java.lang.*,java.util.*,java.net.*,java.util.*,java.text.*"%>
	
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="Admin__Setting-Container">
	<div class="Admin__Setting-Banner">
		<h1>Banner</h1>
		<form id='form' method="post" enctype='multipart/form-data'>
			<div class="Setting__Banner">
				<div class="Setting__Banner-Feature">
					<div>Banner 1</div>
					<input onchange="loadimg(event)" type="file" name="Banner1"
						id="Banner1" multiple>
				</div>
				<img id="anh1"
					src=""
					alt="">
			</div>
			<button type="submit" class="Setting__Banner-Feature-Btn">Cập
				Nhật</button>
		</form>
		<form id='form2' method="post" enctype='multipart/form-data'>
			<div class="Setting__Banner">
				<div class="Setting__Banner-Feature">
					<div>Banner 2</div>
					<input onchange="loadimg2(event)" type="file" name="Banner2"
						id="Banner2">
				</div>
				<img id="anh2"
					src=""
					alt="">

			</div>
			<button type="submit" class="Setting__Banner-Feature-Btn">Cập
				Nhật</button>
		</form>
		<form id='form3' method="post" enctype='multipart/form-data'>
			<div class="Setting__Banner">
				<div class="Setting__Banner-Feature">
					<div>Banner 3</div>
					<input onchange="loadimg3(event)" type="file" name="Banner3"
						id="Banner3">
				</div>
				<img id="anh3"
					src=""
					alt="">
			</div>
			<button type="submit" class="Setting__Banner-Feature-Btn">Cập
				Nhật</button>
		</form>
	</div>
	<div class="Admin__Setting-AddNew">
		<div class="Admin__Setting-Author">
			<h1>Tác Giả</h1>
			<form class="Add__Container" method="POST">
				<div class="AddAuthor">
					<div>Tên Tác Giả</div>
					<input type="text" name="inputAuthorName" id="">
				</div>
				<div class="AddAuthor">
					<div>Địa Chỉ</div>
					<input type="text" name="inputAuthorAddr" id="">
				</div>
				<div class="AddAuthor">
					<div>Tiểu Sử</div>
					<input type="text" name="inputAuthorHist" id="">
				</div>
				<div class="AddAuthor">
					<div>Điện Thoại</div>
					<input type="tel" name="inputAuthorPhone" id="">
				</div>
				<input type="submit" class="Add__Btn" value="Thêm" />
			</form>
			<div class="Delete__Container">
				<label for="author">Chọn Tác Giả: </label>
				<select name="author" id="category">
				<option selected>--Chọn Tác Giả--</option>
						<c:forEach items="${listtacgia}" var="list3">
							<option value="${list3.get_id()}">${list3.getTenTG()}</option>
						</c:forEach>
				</select>

				<button class="Delete__Btn" type="submit" onclick="Deletetacgia()"> xóa tác giả </button>
			</div>
		</div>

		<div class="Admin__Setting-Author">
			<h1>Chủ Đề</h1>
			<form method="POST">
				<div class="Add__Container">
					<div class="AddCategory">
						<div>Chủ Đề</div>
						<input type="text" name="inputCategory" id="">
					</div>
					<input type="submit" class="Add__Btn" value="Thêm" />
				</div>
			</form>
			<div class="Delete__Container">
				<label for="category">Chọn Chủ Đề: </label> 
				<select name="category"
					id="category">
					<option selected>--Chọn chủ đề --</option>
						<c:forEach items="${listcd}" var="list2">

							<option value="${list2.get_id()}">
								${list2.getTenChuDe()}</option>
						</c:forEach>
				</select>

				<button type="submit" class="Delete__Btn" value="xóa chủ đề " onclick="Deletechude()">xóa chủ đề</button>
			</div>
		</div>

		<div class="Admin__Setting-Author">
			<h1>Nhà Xuất Bản</h1>
			<form class="Add__Container" method="POST">
				<div class="AddAuthor">
					<div>Tên Nhà Xuất Bản</div>
					<input type="text" name="inputNXB" id="inputNXB">
				</div>
				<div class="AddAuthor">
					<div>Địa Chỉ</div>
					<input type="text" name="inputAddress" id="inputAddress">
				</div>
				<div class="AddAuthor">
					<div>Số Điện Thoại</div>
					<input type="text" name="inputPhone" id="inputPhone">
				</div>
				<input type="submit" class="Add__Btn" value="Thêm" />
			</form>
			<div class="Delete__Container">
				<label for="nxb">Chọn NXB: </label> 
				<select name="nxb" id="category">
				<option selected>--Chọn nhà xuất bản--</option>
				<c:forEach items="${listnxb}" var="list">
						<option value="${list.get_id()}">${list.getTenNXB()}</option>
						</c:forEach>
				</select>

				 <button type="submit" class="Delete__Btn" value="xóa NXB"onclick="DeleteNXB()">Xóa NXB</button>
			</div>
		</div>
	</div>
</div>

<script>
let img1
function loadimg(event) {
	const anh = document.getElementById('anh1');
	anh.src = URL.createObjectURL(event.target.files[0]);
	img1 = event.target.files[0];
}
let img2
function loadimg2(event) {
	const anh = document.getElementById('anh2');
	anh.src = URL.createObjectURL(event.target.files[0]);
	img2 = event.target.files[0];
}
let img3
function loadimg3(event) {
	const anh = document.getElementById('anh3');
	anh.src = URL.createObjectURL(event.target.files[0]);
	img3 = event.target.files[0];
}

const form = document.getElementById("form");
form.addEventListener("submit", submitForm);
function submitForm(e) {
	e.preventDefault();

	if (!(typeof img1 == "undefined")) {
		const files = document.getElementById("Banner1");
		const formData = new FormData();
		for (let i = 0; i < files.files.length; i++) {
			formData.append("img", files.files[i]);
		}

		postimg(formData).then(async res => {
			if (res.data != null) {
				let linkAnh = "{\"Image\":\"" + res.data + "\"}"
				await fetch("https://bookstoreute.onrender.com/Banner1/Anh1", {
					method: "put",
					headers: {
						'Content-Type': 'application/json'
					},
					body: linkAnh
				})
				alert("Cập Nhật Thành Công")
			} else {
				alert(res.Messager);
			}
		})
	} else {
		alert("Vui Lòng Chọn Ảnh Cho Banner 1")
	}
}

const form2 = document.getElementById("form2");
form2.addEventListener("submit", submitForm2);
async function submitForm2(e) {
	e.preventDefault();
	if (!(typeof img2 == "undefined")) {
		const files2 = document.getElementById("Banner2");
		const formData2 = new FormData();
		for (let i = 0; i < files2.files.length; i++) {
			formData2.append("img", files2.files[i]);
		}

		postimg(formData2).then(async res => {
			if (res.data != null) {
				let linkAnh = "{\"Image\":\"" + res.data + "\"}"
				await fetch("https://bookstoreute.onrender.com/Banner1/Anh2", {
					method: "put",
					headers: {
						'Content-Type': 'application/json'
					},
					body: linkAnh
				})
				alert("Cập Nhật Thành Công")
			} else {
				alert(res.Messager);
			}
		})
	} else { alert("Vui Lòng Chọn Ảnh Cho Banner 2") }
}

const form3 = document.getElementById("form3");
form3.addEventListener("submit", submitForm3);
async function submitForm3(e) {
	e.preventDefault();
	if (!(typeof img3 == "undefined")) {
		const files3 = document.getElementById("Banner3");
		const formData3 = new FormData();
		for (let i = 0; i < files3.files.length; i++) {
			formData3.append("img", files3.files[i]);
		}
		postimg(formData3).then(async res => {
			if (res.data != null) {
				let linkAnh = "{\"Image\":\"" + res.data + "\"}"
				await fetch("https://bookstoreute.onrender.com/Banner1/Anh3", {
					method: "put",
					headers: {
						'Content-Type': 'application/json'
					},
					body: linkAnh
				})
				alert("Cập Nhật Thành Công")
			} else {
				alert(res.Messager);
			}
		})
	} else { alert("Vui Lòng Chọn Ảnh Cho Banner 3") }

}

async function postimg(formData) {
	const response = await fetch("https://bookstoreute.onrender.com/upload-image", {
		method: "post",
		body: formData,
	})
	return response.json();
}
// xóa 
async function Delete(url = "") {
    let BookingApi = "https://bookstoreute.onrender.com/";
    console.log(BookingApi + url);
    const response = await fetch(BookingApi + url, {
        method: "DELETE"
    });

    return response.json();
}

function Deletetacgia() {
    let id = document.getElementsByTagName('select')[0].value
    if (id == "--Chọn Tác Giả--") {
        alert("Vui lòng chọn tác giả");
    } else {
        if (confirm("Xóa Tác Giả Này Sẽ Xóa Những Sách Có Liên Quan\n Bạn Chắc Không")) {
            Delete("tacgiabyid/" + id)
                .then((result) => {
                    console.log(result)
                    alert("Xóa thành công");
                    window.location.href = "/JavaWebMVC/admin/setting";
                })
        }

    }
}
function Deletechude() {
    let id = document.getElementsByTagName('select')[1].value
    if (id == "--Chọn chủ đề --") {
        alert("Vui lòng chọn tác giả");
    } else {
        if (confirm("Xóa Tác Giả Này Sẽ Xóa Những Sách Có Liên Quan\n Bạn Chắc Không")) {
            Delete("chudebyid/" + id)
                .then((result) => {
                    console.log(result)
                    alert("Xóa thành công");
                    window.location.href = "/JavaWebMVC/admin/setting";
                })
        }

    }

  
}
function DeleteNXB() {
    let id = document.getElementsByTagName('select')[2].value
    if (id == "--Chọn nhà xuất bản--") {
        alert("Vui lòng chọn tác giả");
    } else {
        if (confirm("Xóa Tác Giả Này Sẽ Xóa Những Sách Có Liên Quan\n Bạn Chắc Không")) {
            Delete("nhaxuatbanbyid/" + id)
                .then((result) => {
                    console.log(result)
                    alert("Xóa thành công");
                    window.location.href = "/JavaWebMVC/admin/setting";
                })
        }

    }
}


</script>