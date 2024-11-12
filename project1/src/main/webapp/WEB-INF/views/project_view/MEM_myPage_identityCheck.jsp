<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MyPage - 본인인증</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<style type="text/css">
	#container{display: flex; padding-top: 75px;}
	#container #flex_left{width: 15%;  background-color: Whitesmoke;}
	#container #flex_write{width: 85%;}
	#container #logo{width: 200px; height: 70px;} 
	#container #name{font-size: 50px; font-weight: bold;}
	#container #article_container{display: flex; flex-direction: column;}
	#container article{padding: 20px; margin: 10px; text-align: center;}
	#container article i {font-size: 60px; padding: 20px; margin-right: 10px;}
	#container article span{font-size: 30px; display: inline-block; margin-top: 20px;}
	#container #title{font-size: 50px; margin-left: 20px;}
	#container #msg{text-align: center; font-size: 30px;}
	#container #check_pw_form{width: 1000px; min-height: 1000px; margin: 0 auto;}
	#container input {width: 50%;  padding: 30px; margin-left: 20px; height: 70px;}
	input[type="password"]{font-size: 45px;}
	#container #buttons{display: flex;  margin-top: 40px;  flex-direction: row; padding-left: 120px;}
	#container button {width: 130px; height: 60px; margin-right: 100px; }
	#prId{text-decoration: none; color: black; display: inline-block; margin-left: 50px;}
</style>
</head>
<body>
<jsp:include page="MEM_header.jsp" />
	<div id="container">
		<section id="flex_left">
			<p id="name"><a href="/go_my_page" id="prId">
				<c:choose>
					<c:when test="${userName.length >= 8 }">
						<span>${userId.substring(0,8)}... 님</span>
					</c:when>
					<c:otherwise>
						<span>${userId } 님</span>
					</c:otherwise>
				</c:choose>
			</a></p>
			<div id="article_container">
			<article>
			<i class="fa-regular fa-message" style="float: left"></i>
				<span>내 댓글 관리</span>
			</article>
			<article>
			<i class="fa-solid fa-user-gear" style="float: left"></i>
				<span>회원정보 수정</span>
			</article>
			<article>
			<i class="fa-solid fa-unlock" style="float: left"></i>	
				<span>비밀번호 변경</span>
			</article>
			<article>
			<i class="fa-solid fa-arrow-right-from-bracket" style="float: left"></i>
				<span>회원 탈퇴</span>
			</article>
			</div>

		</section>				
		
		<section id="flex_write">
			 <p id="title">비밀번호 인증</p>
			 <hr>
			 <p id="msg"> 보안을 위해 비밀번호를 <b>한번 더</b> 입력해야 합니다. 인증을 <b>완료해야 다음 단계로 진행</b>할 수 있습니다.</p>
			 <form id="check_pw_form" method="post">
			 	<fieldset>
			 		<p>아이디<input type="text"  name="userId" value="${userId}" style="border: none; font-size: 45px;" readonly> </p>
			 		<p>비밀번호<input type="password" id="userPw"  name="userPw" style="margin-top: 10px;" required> </p>
			 	</fieldset>
				 <div id="buttons">
				 	 <button  onclick="confirm(this.form)">확인</button>
					 <button  onclick="cancle(this.form)" >취소</button>
				 </div>
			 </form>
		</section>				
	</div>
	
	<script type="text/javascript">
		function cancle(f) {
			f.action = "/go_my_page" ;
			f.submit();
		}
		
		function confirm(f) {
			f.action = "/go_pw_chk?cmd=${cmd}";
			f.submit();
		}
			
	</script>
<script type="text/javascript">
	<c:if test="${pwChk == false}">
		alert("비밀번호가 일치하지 않습니다.");
		let pw = document.querySelector("#userPw");
		pw.value = "";
		pw.focus();
	</c:if>
</script>
</body>
</html>