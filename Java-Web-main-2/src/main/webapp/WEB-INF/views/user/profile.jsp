<link rel="stylesheet" type="text/css"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="py-5 my-5">
	<div class="container">
		<div class="bg-white shadow rounded-lg d-block d-sm-flex">
			<div class="profile-tab-nav border-right">
				<form id="profile" method="post" enctype="multipart/form-data">
					<div class="p-4">
						<div class="img-circle text-center mb-3">
							<img id="anh" src="${Anh }" />
						</div>
						<h4 class="text-center">${HoTen }</h4>
						<input onchange="loadimg(event)" type="file" id="imgchoose"
							name="imgchoose" accept="image/*">
					</div>
					<div class="nav flex-column nav-pills" id="v-pills-tab"
						role="tablist" aria-orientation="vertical">
						<a class="nav-link active" id="account-tab" data-toggle="pill"
							href="#account" role="tab" aria-controls="account"
							aria-selected="true"> <i class="fa fa-home text-center mr-1"></i>
							Cập Nhật Tài Khoản
						</a> <a class="nav-link" id="password-tab" data-toggle="pill"
							href="#password" role="tab" aria-controls="password"
							aria-selected="false"> <i class="fa fa-key text-center mr-1"></i>
							Đổi Mật Khẩu
						</a>
					</div>
				</form>
			</div>
			<div class="tab-content p-4 p-md-5" id="v-pills-tabContent">
				<div class="tab-pane fade show active" id="account" role="tabpanel"
					aria-labelledby="account-tab">
					<form id='formprofile' method="post" enctype='multipart/form-data'>
						<h3 class="mb-4">Account Settingssss</h3>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>Họ Và Tên</label> <input type="text" value="${HoTen }"
										class="form-control" id="HoTen" name="HoTen" required>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Email</label> <input type="text" value="${Email }"
										class="form-control" id="Email" name="Email" required>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Địa Chỉ</label> <input type="text" value="${DiachiKH }"
										class="form-control" id="DiaChi" name="DiaChi" required>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Số Điện Thoại (nhập đủ 10 số)</label> <input type="tel"
										class="form-control" value="${DienthoaiKH }" name="SDT"
										id="SDT" pattern="[0-9]{10}" placeholder="Nhập đủ 10 số"
										required>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Ngày Sinh</label> <input type="date"
										value="${Ngaysinh }" id="Date" class="form-control"
										name="Date" min="1950-01-01" required>
								</div>
							</div>
						</div>
						<div>
							<button type="submit" class="btn btn-primary">Cập Nhật</button>
						</div>
					</form>
				</div>

				<div class="tab-pane fade" id="password" role="tabpanel"
					aria-labelledby="password-tab">
					<h3 class="mb-4">Password Settings</h3>
					<form id="changepass" method="post">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>Mật Khẩu Hiện Tại</label> <input type="password"
										class="form-control" id="oldpass" name="oldpass" required>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>Mật Khẩu Mới</label> <input type="password"
										class="form-control" id="newpass" name="newpass" minlength="6"
										required>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Xác Nhận Mật Khẩu</label> <input type="password"
										class="form-control" id="compass" name="compass" minlength="6"
										required>
								</div>
							</div>
						</div>
						<div>
							<button type="submit" class="btn btn-primary">Đổi Mật
								Khẩu</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>


<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
		let imgchoose;
		let idUser = '<%=session.getAttribute("id")%>';
		const formProfile = document.getElementById("formprofile");
		formProfile.addEventListener("submit", submitFormprofile);

		function submitFormprofile(e) {
			e.preventDefault();
			const HoTen = document.getElementById("HoTen").value;
			const Email = document.getElementById("Email").value;
			const DiachiKH = document.getElementById("DiaChi").value;
			const DienthoaiKH = document.getElementById("SDT").value;
			const Ngaysinh = document.getElementById("Date").value;

			let check = [];
			check.push(!(typeof HoTen == "undefined")); check.push(!(typeof DienthoaiKH == "undefined"));
			check.push(!(typeof Email == "undefined")); check.push(!(typeof Ngaysinh == "undefined"));
			check.push(!(typeof DiachiKH == "undefined"));
			check.push(!(typeof HoTen == "")); check.push(!(typeof DienthoaiKH == ""));
			check.push(!(typeof Email == "")); check.push(!(typeof Ngaysinh == ""));
			check.push(!(typeof DiachiKH == ""));
			check.push((typeof HoTen == "string")); check.push((typeof DienthoaiKH == "string"));
			check.push((typeof Email == "string")); check.push((typeof Ngaysinh == "string"));
			check.push((typeof DiachiKH == "string"));
			let isTrue = va => va === true

			if (check.every(isTrue)) {
				if (typeof idUser == "string" && !(idUser == "")) {
					if (!(typeof imgchoose == "undefined")) {
						const formData = new FormData();
						for (let i = 0; i < imgchoose.files.length; i++) {
							formData.append("img", imgchoose.files[i]);
						}
						postimg(formData).then(async res => {
							if (res.data != null) {
								let linkAnh = res.data;
								await UpdateProfileHaveImg(HoTen, Email, DiachiKH, DienthoaiKH, linkAnh, Ngaysinh).then(res => {
									alert(res.Messenger)
									window.location.href = "/JavaWebMVC/myprofile"

								}).catch(err => {
									alert(err);
								})
							} else {
								alert("Upload Ảnh Thất bại")
							}
						}).catch((err) => {
							alert(err)
						});
					} else {
						UpdateProfile(HoTen, Email, DiachiKH, DienthoaiKH, Ngaysinh).then(res => {
							alert(res.Messenger);
							window.location.href = "/JavaWebMVC/myprofile"
						}).catch(err => {
							alert(err);
						})
					}
				} else { alert("Bạn Chưa Đăng Nhập") }
			} else {
				alert("Lỗi");
			}
		}

		const changepass = document.getElementById("changepass");
		changepass.addEventListener("submit", Submitchangepass);
		async function Submitchangepass(e) {
			e.preventDefault();

			const oldpass = document.getElementById("oldpass").value;
			const newpass = document.getElementById("newpass").value;
			const compass = document.getElementById("compass").value;

			let check = [];
			check.push(!(typeof oldpass == "undefined")); check.push(!(typeof compass == "undefined"));
			check.push(!(typeof newpass == "undefined"));
			check.push((typeof oldpass == "string")); check.push((typeof compass == "string"));
			check.push((typeof newpass == "string"));
			check.push(!(typeof oldpass == "")); check.push(!(typeof compass == ""));
			check.push(!(typeof newpass == ""));

			let isTrue = va => va === true

			if (check.every(isTrue)) {
				if (typeof idUser == "string" && !(idUser == "")) {
					ChangePass(oldpass, newpass, compass).then(res => {
						if(res.Messenger =="Cập Nhật Thành Công"){
							alert(res.Messenger)
							window.location.href = "/JavaWebMVC/myprofile";
						}else{
							alert(res.Messenger)
						}
						
					}).catch(err => {
						alert(err)
					})
				} else {
					alert("Bạn Chưa Đăng Nhập")
				}
			} else {
				alert("Lỗi")
			}
		}

		function loadimg(event) {
			const anh = document.getElementById("anh");
			anh.src = URL.createObjectURL(event.target.files[0]);
			imgchoose = event.target
		}

		async function postimg(formData) {
			const response = await
				fetch("https://bookstoreute.onrender.com/upload-image", {
					method: "post",
					body: formData,
				})
			return response.json();
		}

		async function UpdateProfileHaveImg(HoTen, Email, DiaChi, DienThoai, Anh, Ngaysinh) {
			let data = "{\n\"id\" : \"" + idUser + "\",\n \"HoTen\": \"" + HoTen + "\", \n \"Email\": \"" + Email + "\",\n \"DiachiKH\": \""
				+ DiaChi + "\",\n \"DienthoaiKH\" : \"" + DienThoai
				+ "\",\n \"Ngaysinh\": \"" + Ngaysinh + "\",\n \"Anh\":\"" + Anh + "\"\n}";
			console.log(data)
			const response = await fetch("https://bookstoreute.onrender.com/khachhang", {
				method: "put",
				headers: {
					'Content-Type': 'application/json'
				},
				body: data,
			})
			return response.json();
		}
		async function UpdateProfile(HoTen, Email, DiaChi, DienThoai, Ngaysinh) {
			let data = "{\n\"id\" : \"" + idUser + "\",\n \"HoTen\": \"" + HoTen + "\", \n \"Email\": \"" + Email + "\",\n \"DiachiKH\": \""
				+ DiaChi + "\",\n \"DienthoaiKH\" : \"" + DienThoai
				+ "\",\n \"Ngaysinh\": \"" + Ngaysinh + "\"\n}";

			const response = await fetch("https://bookstoreute.onrender.com/khachhang", {
				method: "put",
				headers: {
					'Content-Type': 'application/json'
				},
				body: data,
			})
			return response.json();
		}
		async function ChangePass(Matkhaued, newMatkhau, ConfirmMatKhau) {
			let data = "{\"id\":\"" + idUser + "\",\"Matkhaued\":\""
				+ Matkhaued + "\",\"newMatkhau\":\"" + newMatkhau
				+ "\",\"ConfirmMatKhau\":\"" + ConfirmMatKhau + "\"}";

			console.log(data)
			const response = await fetch("https://bookstoreute.onrender.com/khachhangmk", {
				method: "put",
				headers: {
					'Content-Type': 'application/json'
				},
				body: data,
			})
			return response.json();
		}
	</script>