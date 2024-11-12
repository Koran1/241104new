<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList - 아이디 안내</title>
<style type="text/css">
	body {
		margin: 0;
		padding: 0;
		height: 100vh;
		display: flex;
		flex-direction: column;
	}
	.main-container {
		flex: 1;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		padding: 20px;
	}
	.findidok-container {
		width: 100%;
		max-width: 400px;
		background-color: #ffffff;
		padding: 20px 30px;
		border: 1px solid #eee;
		border-radius: 8px;
		box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
		font-size: 16px;
		text-align: center;
		line-height: 1.6;
	}
	.findidok-container h2 {
		margin: 0;
		font-size: 20px;
	}
	.findidok-container p {
		margin: 10px 0 0;
		font-size: 16px;
	}
	.findidok-container b {
		font-weight: bold;
		color: #000;
	}
	.button-container {
		display: flex;
		justify-content: center;
		gap: 20px;
		margin-top: 20px;
	}
	.login_btn, .pwd_btn {
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
		margin: 0;
	}
	.login_btn {
		background-color: #008165;
	}
	.login_btn:hover {
		background-color: #006b12;
	}
	.pwd_btn {
		background-color: #6B8E23;
	}
	.pwd_btn:hover {
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
		<a href="/mem_findPW"><button type="submit" class="pwd_btn">비밀번호 찾기</button></a>
	</div>
</div>
<jsp:include page="../MAIN/footer.jsp" />
</body>
</html>