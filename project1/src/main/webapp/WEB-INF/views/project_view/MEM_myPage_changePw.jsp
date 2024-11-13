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
	#container #article_container{display: flex; flex-direction: column;}
	#container article{padding: 20px; margin: 10px; text-align: center;}
	#container article i {font-size: 60px; padding: 20px; margin-right: 10px;}
	#container article span{font-size: 30px; display: inline-block; margin-top: 20px;}
	#container #title{font-size: 50px; margin-left: 20px;}
	#container #msg{text-align: center;}
	#container #change_pw_form{width: 1300px; min-height: 1000px; margin: 0 auto;}
	#container input {width: 40%;  padding: 20px; margin-left: 30px;}
	#container button {width: 130px; height: 60px; margin-right: 100px; }
	#container #buttons{display: flex; justify-content: center; margin-top: 20px; }
	#container a {text-decoration: none; color: black}
	#container input[type="password"]{font-size: 45px;}
	#container .scLv{display: inline-block; width: 20px; border: 1px solid black; height: 13px; }
	.prId{text-decoration: none; color: black; display: inline-block; margin-left: 50px; font-size: 50px; font-weight: bold;}
</style>
</head>
<body>
<jsp:include page="MEM_header.jsp" />
	<div id="container">
		<section id="flex_left">
			<p><a href="/go_my_page">
				<c:choose>
					<c:when test="${userName.length >= 10 }">
						<span  class="prId">${userId.substring(0,10)}...님</span>
					</c:when>
					<c:otherwise>
						<span class="prId">${userId }님</span>
					</c:otherwise>
				</c:choose>
			</a></p>
			<div id="article_container">
			<article><a href="/go_my_comment"><i class="fa-regular fa-message"></i>
				<span>내 댓글 관리</span>
			</a></article>
			<article><a href="/go_update">
				<i class="fa-solid fa-user-gear" style="float: left"></i>
				<span>회원정보 수정</span>
			</a></article>
			<article style="background-color: lightgray">
				<i class="fa-solid fa-unlock" style="float: left"></i>	
				<span>비밀번호 변경</span>
			</article>
			<article><a href="/go_user_out">
				<i class="fa-solid fa-arrow-right-from-bracket" style="float: left"></i>
				<span>회원 탈퇴</span>
			</a></article>
			</div>

		</section>
		
		<section id="flex_write">
			 <p id="title">비밀번호 변경</p>
			 <hr>
			 <p id="msg"> 변경할 비밀번호를 입력해 주세요.</p>
			 <form id="change_pw_form" method="post">
			 	<fieldset>
			 		<legend>비밀번호 변경</legend>
			 		<p id="changePw">새 비밀번호:  <input type="password" id="userPw"  name="userPw" required > <i id="pw_msg"></i></p>
			 		<p>비밀번호 확인:  <input type="password" id="confirmPw"  name="confirmPw" required > </p>
			 	</fieldset>
				 <div id="buttons">
				 	 <button type="button" style="background-color: gray; color: white; border: none;" onclick="confirm(this.form)">변경</button>
					 <button type="button" style="background: white;"   onclick="cancle(this.form)" >취소</button>
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
			let userPw = document.querySelector("#userPw");
			let confirmPw = document.querySelector("#confirmPw");
			if ((userPw.value).length < 6 || (userPw.value).length > 16) {
				alert("입력조건을 만족하지 않습니다.");
			}else {
				if (userPw.value === confirmPw.value) {
					f.action = "/go_pw_change_ok";
					f.submit();
				}else {
					alert("입력정보가 일치하지 않습니다.");
				}
			}
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
<script type="text/javascript">
	function HaveKorean(value) {
		const korean = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		return korean.test(value);
	}

	function HaveLowEnglish(value) {
		const LowEnglish = /[a-z]/;
		return LowEnglish.test(value);
	}
	function HaveUpEnglish(value) {
		const UpEnglish = /[A-Z]/;
		return UpEnglish.test(value);
	}
	function HaveNumber(value) {
		const Number = /[0-9]/;
		return Number.test(value);
	}
	function HaveSpecial(value) {
		const Number = /[{}[\]\/?.,;:|)*~`!^\-_+<>@#$%&\\=\(\'\"]/;
		return Number.test(value);
	}
	
	let pw = document.querySelector("#userPw");
	pw.addEventListener("keyup", function() {
	let value = pw.value;
	let securityLv = 0;
	let msg = "";
	let pw_msg = document.querySelector("#pw_msg");
		if (HaveKorean(value) || value.length < 8 || value.length > 15 || value.includes(" ")) {
			 msg = "비밀번호는 공백을 제외한 알파벳 대/소문자를 포함한 8~15자여야 합니다.";
			pw_msg.innerText = msg;
			
		}else{
			securityLv++;
			if (HaveLowEnglish(value)) securityLv++;
			if (HaveUpEnglish(value)) securityLv++;
			if (HaveSpecial(value)) securityLv++;
			if (value.length > 11)  securityLv++;
			
			msg = "<i>보안수준: &nbsp;&nbsp;<i><span><span class='scLv'></span><span class='scLv'></span><span class='scLv'></span><span class='scLv'></span><span class='scLv'></span>";
			pw_msg.innerHTML = msg;
			
			let levels = document.querySelectorAll(".scLv");
			for (let i = 0; i < levels.length; i++) {
				if (i >= securityLv) {
					break;
				}else{
					if (securityLv == 1) levels[i].style.backgroundColor = "#FF0000";
					if (securityLv == 2) levels[i].style.backgroundColor = "#FFA500";
					if (securityLv == 3) levels[i].style.backgroundColor = "#FFFF00";
					if (securityLv == 4) levels[i].style.backgroundColor = "#008000";
					if (securityLv == 5) levels[i].style.backgroundColor = "#0000FF";
				}// 두번째 else
			}// for문
		}// 처음 else꺼
		
	
	});
</script>
</body>
</html>