<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Index</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="resources/css/admin.css" rel="stylesheet"/>
<style type="text/css">
	#main_container{
		flex-direction: row;
	}
	#main_container button{
		width: 100%;
		padding: 10px 20px;
		width: 150px;
	}
	
	#main_container button:hover{
		background-color: black;
		color: white;
		font-weight: bold;
	}
	#main_container .main_button{
		display: flex;
		justify-content: flex-end;
		width: 100%;
		margin: 20px 0;
	}
	#dashboard{
		display: flex;
		flex-direction: column;
		width: 300px;
	}
	#dashboard p{
		width: 80%;
		font-size: 20px;
		border: 1px solid black;
		border-top: 2px solid red;
		margin: 10px auto;
		padding: 10px 20px;
	}
	#graph {
		width: 100%;
		height: 100%;
		margin-left: 50px;
	}
	#list{
		border-collapse: collapse;
	}
	#list th, td{
		padding: 10px;
		border: 1px solid black;
	}
</style>
<script type="text/javascript">
	<c:if test="${result == '1'}">
		alert("날씨 불러오기 성공");
	</c:if>
	<c:if test="${result == '0'}">
		alert("날씨 불러오기 실패");
	</c:if>
</script>
</head>
<body>
	<div id="header">
		<a href="/admin_index">
		<img id="logo" alt="logo" src="../resources/images/logo.png" height="60px">
		</a>
		<h2>ADMIN</h2>
	</div>
	<div id="container">
		<div id="button_container">
			<button onclick='location.href ="/admin_members"'>회원정보관리</button>
			<button onclick='location.href ="/admin_notice"'>공지사항관리</button>
			<button onclick='location.href ="/admin_faq"'>FAQ관리</button>
			<button onclick='location.href ="/admin_qa"'>Q&A관리</button>
			<button onclick='location.href ="/admin_main"'>게시판관리</button>
		</div>
		
		<div id="main_container">
			<div id="dashboard">
				<p>오늘 방문자 수 : ${newUserConnReg}</p>
				<p>추가된 댓글 수 : ${newTourTalk}</p>
				<p>신규 가입 수 : ${newUserReg}</p>
				<p><a href="/load_weather">날씨 정보 최신화하기</a></p>
			</div>
			<div id="graph">
				<h2>날씨 정보 확인하기</h2><br>
				<select name="region" id="region">
					<option value="1" selected>서울</option>
					<option value="2">부산</option>
					<option value="3">대구</option>
					<option value="4">인천</option>
					<option value="5">광주</option>
					<option value="6">대전</option>
					<option value="7">울산</option>
					<option value="8">경기</option>
					<option value="9">강원</option>
					<option value="10">충북</option>
					<option value="11">충남</option>
					<option value="12">전북</option>
					<option value="13">전남</option>
					<option value="14">경북</option>
					<option value="15">경남</option>
					<option value="16">제주</option>
				</select>
				<button onclick="load()">지역 선택</button>
				
				<div>
					<table id="list">
						<thead>
							<tr><th>날짜</th><th>최저기온 ℃</th><th>최고기온 ℃</th><th>SKY+PTY(날씨)</th><th>POP(강수확률)</th></tr>
						</thead>
						<tbody id="tbody">
						</tbody>
					</table>
				</div>
				
				<script type="text/javascript">
				function load(){
					$("#tbody").empty();
					$.ajax({
						url : "/getwthrinfo",
						method : "post",
						data : "region="+$("#region").val(),
						dataType : "json",
						success : function(data){
							let tbody = "";
							$.each(data, function(index, obj){
								tbody += "<tr>";
								tbody += "<td>" + obj.wthrDate +"</td>"
								tbody += "<td>" + obj.wthrTMin +"</td>"
								tbody += "<td>" + obj.wthrTMax +"</td>"
								tbody += "<td>" + obj.wthrSKY_PTY +"</td>"
								tbody += "<td>" + obj.wthrPOP +"</td>"
								tbody += "</tr>"
							});
							$("#tbody").append(tbody);
						},
						error : function(){
							alert("날씨 정보 최신화 필요!")
						}
					})
				}
				</script>
			</div>
		</div>
	</div>

</body>
</html>