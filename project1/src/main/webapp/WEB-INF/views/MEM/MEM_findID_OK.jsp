<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList - 아이디 안내</title>
<link type="text/css" href="/resources/css/style.css" rel="stylesheet" />
<style type="text/css">
	body {
		margin: 0;
		padding: 0;
	}
	.main-container{
		margin: 0;
		padding-top: 100px;
		width: 100%;
		height: 90vh;
	}
	.logo-img {
		cursor: pointer;
	}
	.findidok-container {
		width: 50%;
		max-width: 400px;
		background-color: #ffffff;
		padding: 20px;
		margin: 20px auto;
		border: 1px solid #ccc;
		border-radius: 4px;
		box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
		color: #333;
		font-size: 18px;
	}
	.button-container {
		display: flex;
		justify-content: center;
		gap: 10px;
		margin-top: 20px;
	}
	.login_btn, .btn {
		width: 150px;
		padding: 12px 0;
		border: none;
		border-radius: 4px;
		font-size: 16px;
		font-weight: bold;
		color: white;
		cursor: pointer;
		text-align: center;
		display: inline-block;
	}
	.login_btn {
		background-color: #008165;
	}
	.login_btn:hover {
		background-color: #006b12;
	}
	.btn {
		background-color: #6B8E23;
	}
	.btn:hover {
		background-color: #556B2F;
	}
</style>
</head>
<body>
<jsp:include page="../MAIN/header.jsp" />
<div class="main-container">
	<div class="findidok-container">
		<h2>아이디 안내</h2>
		<p>찾으시는 아이디는 <b>${userId}</b> 입니다.</p>
	</div>
	
	<div class="button-container">
		<a href="/mem_login"><button type="submit" class="login_btn">로그인</button></a>
		<a href="/mem_findPW"><button type="submit" class="btn">비밀번호 찾기</button></a>
	</div>
</div>
<jsp:include page="../MAIN/footer.jsp" />
</body>
</html>
	