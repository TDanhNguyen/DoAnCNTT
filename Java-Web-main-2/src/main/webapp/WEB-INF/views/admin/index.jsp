<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<body>
	<style>
	.Center{
		display: flex;
		justify-content: space-around;
		align-items: center;
		min-height: 50vh;
		width: 35vw;
		margin: 0 auto;
		animation: toVisible 1s 1 ease-in-out forwards;
		user-select: none;
	}
		.Center h1{
			font-size: 26px;
			color: rgb(104, 103, 102);
			-webkit-text-stroke: 1px;
			-webkit-text-stroke-color: black;
		}
			.Center h1 span{
				font-size: 30px;
			}
		.Center img{
			width: 200px;
			height: 200px;
		}
	@media screen and (max-width: 415px) {	
		.Center {
			flex-flow: column nowrap;
			width: 60vw;
			justify-content: center;
		}
		
		.Center h1 {
			font-size: 18px;
		}
		
		.Center h1 span {
			font-size: 20px;
		}
	}
	</style>
	<div class="Center">
		<h1>
			Chào, <br> <span>${Admin}</span>
		</h1>
		<img
			src="https://scr.vn/wp-content/uploads/2020/07/%E1%BA%A2nh-%C4%91%E1%BB%99ng-powerpoint-h%E1%BB%8Dc-t%E1%BA%ADp.gif"
			alt="">
	</div>
</body>
