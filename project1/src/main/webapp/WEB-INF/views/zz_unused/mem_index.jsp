<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<style type="text/css">
	table, th, td{
		border: 1px solid black;
		border-collapse: collapse;
	}
	th, td{
		text-align: center;
		padding: 5px 10px;
	}
	
</style>
<body>
	<h1>index page</h1>
	<h3><a href="/mem_login">로그인</a></h3>
	<h3><a href="/add_notice">공지사항</a></h3>
	<h3><a href="/mem_logout">로그아웃</a></h3>
	
	<c:if test="${not empty sessionScope.userId}">
    	<p>${sessionScope.userId}님, 로그인을 환영합니다!</p>
	</c:if>
	
</body>
</html>