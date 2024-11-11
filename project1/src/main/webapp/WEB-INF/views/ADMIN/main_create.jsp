<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Main Create</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="resources/css/admin.css" rel="stylesheet"/>
<style type="text/css">
	tr{
		
	}
</style>
</head>
<body>
	<div id="header">
		<img id="logo" alt="logo" src="../resources/images/logo.png" onclick='location.href ="/admin_index"'>
		<h2>ADMIN</h2>
	 </div>
	 
	 <div id="container">
		<div id="button_container">
			<button onclick='location.href ="/admin_members"'>회원정보관리</button>
			<button onclick='location.href ="/admin_notice"'>공지사항관리</button>
			<button onclick='location.href ="/admin_faq"'>FAQ관리</button>
			<button onclick='location.href ="/admin_qa"'>Q&A관리</button>
			<button style="color: red" onclick='location.href ="/admin_main"'>게시판관리</button>
		</div>
	
		<div id="main_container">
			<form action="/admin_main_create_OK" method="post">
				<table>
					<tr align="center">
						<td>관광지명</td>
						<td><input type="text" name="trrsrtNm"></td>
					</tr>
					<tr align="center">
						<td>관광지명</td>
						<td><input type="text" name="trrsrtSe" value="관광지"></td>
					</tr>
					<tr align="center">
						<td>지역 번호</td>
						<td><input type="number" name="region"></td>
					</tr>
					<tr align="center">
						<td>주소</td>
						<td><input type="text" name="rdnmadr"></td>
					</tr>
					<tr align="center">
						<td>도로명 주소</td>
						<td><input type="text" name="lnmadr"></td>
					</tr>
					<tr align="center">
						<td>위도 (latitude)</td>
						<td><input type="number" name="latitude"></td>
					</tr>
					<tr align="center">
						<td>경도 (longitude)</td>
						<td><input type="number" name="longitude"></td>
					</tr>
					<tr align="center">
						<td>면적</td>
						<td><input type="number" name="ar"></td>
					</tr>
					<tr align="center">
						<td>공공편익시설 정보</td>
						<td><input type="text" name="cnvnncFclty"></td>
					</tr>
					<tr align="center">
						<td>휴양및문화시설 정보</td>
						<td><input type="text" name="recrtClturFclty"></td>
					</tr>
					<tr align="center">
						<td>운동및오락시설 정보</td>
						<td><input type="text" name="mvmAmsmtFclty"></td>
					</tr>
					<tr align="center">
						<td>접객시설 정보</td>
						<td><input type="text" name="hospitalityFclty"></td>
					</tr>
					<tr align="center">
						<td>숙박시설 정보</td>
						<td><input type="text" name="stayngInfo"></td>
					</tr>
					<tr align="center">
						<td>접객시설 정보</td>
						<td><input type="text" name="hospitalityFclty"></td>
					</tr>
					<tr align="center">
						<td>지정일자</td>
						<td><input type="text" name="appnDate"></td>
					</tr>
					<tr align="center">
						<td>지원시설 정보</td>
						<td><input type="text" name="sportFclty"></td>
					</tr>
					<tr align="center">
						<td>수용인원수</td>
						<td><input type="text" name="aceptncCo"></td>
					</tr>
					<tr align="center">
						<td>주차가능수</td>
						<td><input type="text" name="prkplceCo"></td>
					</tr>
					<tr align="center">
						<td>관광지 소개</td>
						<td><textarea rows="15" cols="60" name="trrsrtIntrcn"></textarea> </td>
					</tr>
					<tr align="center">
						<td>관리기관전화번호</td>
						<td><input type="text" name="phoneNumber"></td>
					</tr>
					<tr align="center">
						<td>관리기관명</td>
						<td><input type="text" name="institutionNm"></td>
					</tr>
					<tr align="center">
						<td>제공기관명</td>
						<td><input type="text" name="institutionAdr"></td>
					</tr>
					<tr align="center">
						<td>데이터기준일자</td>
						<td><input type="text" name="referenceDate"></td>
					</tr>
					<tr align="center">
						<td>제공기관코드</td>
						<td><input type="text" name="instt_code"></td>
					</tr>
					<tr align="center">
						<td>이미지1</td>
						<td><input type="text" name="placeImg01"></td>
					</tr>
					<tr align="center">
						<td>이미지1</td>
						<td><input type="text" name="placeImg02"></td>
					</tr>
					<tr align="center">
						<td>이미지1</td>
						<td><input type="text" name="placeImg03"></td>
					</tr>
					<tr align="center">
						<td>이미지1</td>
						<td><input type="text" name="placeImg04"></td>
					</tr>
					<tr align="center">
						<td colspan="2">
							<input type="submit" value="수정">
							<input type="reset" value="취소">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	
</body>
</html>