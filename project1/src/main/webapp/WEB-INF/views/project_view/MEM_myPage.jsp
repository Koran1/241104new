<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
<title>MyTravelList - MyPage</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<style type="text/css">
 	#container{margin: 0px auto; padding-top: 100px;}
	#container #logo{width: 200px; height: 70px; margin-bottom: 0px; display: block}
	#container #title{text-align: center; font-size: 60px; margin: 0px auto; margin-bottom: 0px;}
	#container #profile_container{text-align: center; position: relative; margin-top: 20px;}
	#container span{display: inline-block; font-size: 60px; position: relative; top: -30px;}
	#container #flex_container{display: flex;  text-align: center; justify-content: ; margin-top: 100px; height: 200px;  }
	#container #flex1,  #flex2, #flex3{width: 25%; border-right: 1px solid lightgray; }
	#container #flex4{width: 25%;}
	#container a {text-decoration: none; color: black}
	i{font-size: 60px; display: inline-block; margin-left: 50px;}
	p {font-size: 20px;}
	#profile_container{margin-bottom: 180px;}	

</style>
</head>
<body>
<script type="text/javascript">
<c:if test="${isOk == 'yes'}">
	alert("정상적으로 완료되었습니다.");
</c:if>
</script>
<jsp:include page="MEM_header.jsp" />
<div id="container">
	<div id="profile_container">
	<p id="title" style="font-size: 40px; font-weight: bold;">
		어서오세요, 
		<c:choose>
			<c:when test="${userName.length >= 10 }">
				<span>${userId.substring(0,10)}...님</span>
			</c:when>
			<c:otherwise>
				${userId }님
			</c:otherwise>
		</c:choose>
	</p>
	<br>
	<br>
	<br>
	<i style="font-size: 25px;">
		"이곳에서 내 정보를 안전하게 관리하고 개인 정보와 설정을 최신 상태로 유지할 수 있습니다."
	</i>
	</div>
	<hr>
	<div id="flex_container">
		<section class="flexbox" id="flex1"><a href="/go_identify?cmd=go_my_comment">
			<i class="fa-regular fa-message" style="float: left"></i>
			<p> 내 댓글 관리</p>
			<p>내 댓글을 확인하고, 삭제할 수 있습니다.</p>
		</a></section> 
		<section class="flexbox" id="flex2"><a href="/go_identify?cmd=go_update">
				<i class="fa-solid fa-user-gear" style="float: left"></i>
			<p>	회원정보 수정</p>
			<p>아이디, 관심지역 등 내 정보를 수정하세요.</p>
		</a></section>
		<section class="flexbox" id="flex3"><a href="/go_identify?cmd=go_pw_change">
			<i class="fa-solid fa-unlock" style="float: left"></i>	
			<p>비밀번호 변경</p> 
			<p>주기적인 변경으로 내 정보를 보호하세요.</p>
		</a></section>
		<section class="flexbox" id="flex4"><a href="/go_identify?cmd=go_user_out">
			<i class="fa-solid fa-arrow-right-from-bracket" style="float: left"></i>
			<p>회원탈퇴</p>
			<p>회원탈퇴를 진행하려면 이곳을 클릭하세요.</p>
		</a></section>
	</div>
	</div>

	

</body>
</html>
