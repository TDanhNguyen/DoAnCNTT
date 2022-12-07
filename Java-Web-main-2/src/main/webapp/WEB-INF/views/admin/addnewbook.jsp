<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<body>
	<div class="AddNewBook__Container">

		<form id="formNewBook">
			<div class="AddNewBook__Body">
				<div class="AddNewBook__Body-BookName">
					<span>Tên Sách: </span> <input type="text" name="" id="inputName">
				</div>
				<div class="AddNewBook__Body-Description">
					<span>Mô Tả: </span> <input type="text" name="" id="inputDesc">
				</div>
				<div class="AddNewBook__Body-Description">
					<span>Số Lượng: </span> <input type="number" name=""
						id="inputSoLuong">
				</div>
				<div class="AddNewBook__Body-Description">
					<span>Giá: </span> <input type="number" name="" id="inputPrice">
				</div>
				<div class="AddNewBook__Body-BookCategory">
					<span>Nhà Xuất Bản: </span> 
					<select class="form-select"aria-label="Default select example" id="inputNXB" required>
						<option selected>--Chọn Nhà Xuất Bản--</option>
						<c:forEach items="${listnxb}" var="list">
							<option value="${list.get_id()}">${list.getTenNXB()}</option>
						</c:forEach>
					</select>

				</div>
				<div class="AddNewBook__Body-BookAuthor">
					<span>Tác Giả: </span> <select class="form-select"
						aria-label="Default select example" id="inputTG" required>
						<option selected>--Chọn Tác Giả--</option>
						<c:forEach items="${listtacgia}" var="list3">
							<option value="${list3.get_id()}">${list3.getTenTG()}</option>
						</c:forEach>

					</select>
				</div>
				<div class="AddNewBook__Body-BookCategory">
					<span>Thể Loại: </span> <select class="form-select"
						aria-label="Default select example" id="inputCD" required>
						<option selected>--Chọn Chủ Đề--</option>
						<c:forEach items="${listcd}" var="list2">

							<option value="${list2.get_id()}">
								${list2.getTenChuDe()}</option>
						</c:forEach>
					</select>
				</div>
				<div class="AddNewBook__Body-BookImage">
					<span>Ảnh: </span> <input type="file" name="" id="inputImage"
						accept="image/*" onchange="loadimg(event)">
					<div class="AddNewBook__Body-Image">
						<img
							src="https://prices.vn/photos/8/product/sach-dac-nhan-tam-cua-dale-carnegie.gif"
							alt="" id="anh1">
					</div>
				</div>
				<button class="AddNewBook__Body-BtnAdd" type="submit">Thêm
					Sách</button>
			</div>
		</form>
	</div>
	<script>
       
       
       	const FormAddBook = document.getElementById("formNewBook");
		FormAddBook.addEventListener("submit", submitFormAddBook);

		function submitFormAddBook(e) {
		    e.preventDefault();
		    let tensach = document.getElementById("inputName").value;
		    let mota = document.getElementById("inputDesc").value;
		    let nxb = document.getElementById("inputNXB").value;
		    let tacgia = document.getElementById("inputTG").value;
		    let chude = document.getElementById("inputCD").value;
		    let Soln = document.getElementById("inputSoLuong").value;
		    let Gia = document.getElementById("inputPrice").value;
		
		    let check = [];
		    check.push(tensach != null);
		    check.push(mota != null);
		    check.push(nxb != null);
		    check.push(tacgia != null);
		    check.push(chude != null);
		    check.push(Soln != null);
		    check.push(Gia != null);
		
		    if (check.every((va) => va === true)) {
		        if (!(typeof img1 == "undefined")) {
		            const chudearr = [];
		            chudearr.push(chude);
		
		            const files = document.getElementById("inputImage");
		            const formData = new FormData();
		            for (let i = 0; i < files.files.length; i++) {
		                formData.append("img", files.files[i]);
		            }
		            postimg(formData).then(async (res) => {
		                if (res.data != null) {
		                    let linkAnh = res.data;
		                    let body =
		                        '{"Tensach":"' +
		                        tensach +
		                        '","Mota":"' +
		                        mota +
		                        '","Anhbia":"' +
		                        linkAnh +
		                        '","Soluongton":' +
		                        Soln +
		                        ',"Giaban":' +
		                        Gia +
		                        ',"MaCD":["' +
		                        chudearr +
		                        '"],"MaNXB":"' +
		                        nxb +
		                        '","MaTacGia":"' +
		                        tacgia +
		                        '"}';
		                    console.log(body);
		                    await fetch("https://bookstoreute.onrender.com/sach", {
		                        method: "POST",
		                        headers: {
		                            "Content-Type": "application/json",
		                        },
		                        body: body,
		                    })
		                        .then((result) => {
		                            console.log(result);
		                            alert("them sach thanh cong");
		                        })
		                        .catch((err) => {
		                            console.log(err);
		                            alert(err);
		                        });
		                } else {
		                    alert(res.Messager);
		                }
		            });
		        } else {
		            alert("Vui Lòng Nhập Lại");
		        }
		    }
		}
       
       
        let img1;

        function loadimg(event) {
            const anh = document.getElementById("anh1");
            anh.src = URL.createObjectURL(event.target.files[0]);
            img1 = event.target.files[0];
        }
        
        
        async function postimg(formData) {
            const response = await fetch(
                "https://bookstoreute.onrender.com/upload-image",
                {
                    method: "post",
                    body: formData,
                }
            );
            return response.json();
        }
    	</script>
</body>
