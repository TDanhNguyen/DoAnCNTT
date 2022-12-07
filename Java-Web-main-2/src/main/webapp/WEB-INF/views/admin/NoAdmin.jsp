<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<body>
	<style>
		/* NotAdmin's Page*/
		.NotAdminPage__Container{
			min-height: 70vh;
			display: flex;
			flex-flow: column nowrap;
			margin: 0 auto;
			justify-content: center;
			align-items: center;
		}
		.NotAdminPage__Container-Image{
			width: 300px;
			height: 300px;
		}
		.NotAdminPage__Container-Image img{
			width: 100%;
			height: 100%;
		}
		.NotAdminPage__Container-Announce{
			text-align: center;
			height: fit-content;
		}
		.NotAdminPage__Container-Announce-Content{
			margin-bottom: 20px;
			font-weight: 600;
			font-size: 23px;
			color: red;
		}
		.NotAdminPage__Container-Announce-BtnBack{
			background-color: rgba(255, 0, 0, 0.651);
			margin-top: 20px;
			padding: 10px;
			border-radius: .5rem;
			cursor: pointer;
			text-decoration: none;
			transition: 1s;
			color: white;
		}
		
		.NotAdminPage__Container-Announce-BtnBack:hover{
			box-shadow: 0 0 10px 0 red;
			color: white;
			background-color: red;
			text-decoration: none;
		}
	</style>
    <div class="NotAdminPage__Container">
        <div class="NotAdminPage__Container-Image">
            <img src="https://c.tenor.com/aiyNkzmKPwEAAAAC/meong_cat.gif" alt="">
        </div>
        <div class="NotAdminPage__Container-Announce">
            <div class="NotAdminPage__Container-Announce-Content">
                Bạn Không Thể Truy Cập! <br>
                Vui Lòng Quay Về Trang Chủ
            </div>
            <a class="NotAdminPage__Container-Announce-BtnBack" href="/Java-Web/">
                Trang Chủ
            </a>
        </div>
    </div>
</body>