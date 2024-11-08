<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
<title>MyTravelList - MyPage</title>
<style type="text/css">
	#container{margin: 0px auto; padding-top: 100px;}
	#container #logo{width: 200px; height: 70px; margin-bottom: 0px; display: block}
	#container #title{text-align: center; font-size: 60px; margin: 0px auto; margin-bottom: 0px;}
	#container #profile_container{text-align: center; position: relative; margin-top: 20px;}
	#container span{display: inline-block; font-size: 60px; position: relative; top: -30px;}
	#container #flex_container{display: flex;  text-align: center; justify-content: center; margin-top: 100px; height: 200px; }
	#container #flex1{width: 25%; border-right: 1px solid lightgray; }
	#container #flex2{width: 25%; border-right: 1px solid lightgray;}
	#container #flex3{width: 25%; border-right: 1px solid lightgray;}
	#container #flex4{width: 25%;}
	#container a {text-decoration: none; color: black}
	
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
	<p id="title">마이페이지</p>
	<div id="profile_container">
		<img id="profile" alt="" src="resources/images/profile.png">
		<span>${userId }님</span>
	</div>
	<hr>
	<div id="flex_container">
		
	
		<section class="flexbox" id="flex1"><a href="/go_identify?cmd=go_my_comment">
		<img alt="" src="resources/images/my_comment.png" style="float: left;">
			<p> 내 댓글 관리</p>
			<p>내 댓글을 확인하고, 삭제할 수 있습니다.</p>
		</a></section> 
		<section class="flexbox" id="flex2"><a href="/go_identify?cmd=go_update">
		<img alt="" src="resources/images/update.png" style="float: left;">
			<p>	회원정보 수정</p>
			<p>아이디, 관심지역 등 내 정보를 수정하세요.</p>
		</a></section>
		<section class="flexbox" id="flex3"><a href="/go_identify?cmd=go_pw_change">
		<img alt="" src="resources/images/change_pw.png" style="float: left;">
			<p>비밀번호 변경</p> 
			<p>주기적인 변경으로 내 정보를 보호하세요.</p>
		</a></section>
		<section class="flexbox" id="flex4"><a href="/go_identify?cmd=go_user_out">
		<img alt="" src="resources/images/member_out.png" style="float: left;">
			<p>회원탈퇴</p>
			<p>회원탈퇴를 진행하려면 이곳을 클릭하세요.</p>
		</a></section>
	</div>
	</div>

	

</body>
</html>
