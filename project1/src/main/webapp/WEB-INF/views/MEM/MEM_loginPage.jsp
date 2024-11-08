<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 - MyTravelList</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link type="text/css" href="resources/css/style.css" rel="stylesheet" />
<style type="text/css">
	body{
		margin: 0;
		padding: 0;
	}
	.main-container{
		margin: 0;
		padding-top: 100px;
		width: 100%;
		height: 90vh;
	}
	.logo-img{
		cursor: pointer;
	}
	.login-container{
		width: 50%;
		max-width: 400px;
		background-color: #ffffff;
		padding: 20px;
		margin: 50px auto;
	}
	.login_table{
		margin: 10px auto;
	}
	input[type="text"], input[type="password"] {
    	width: 320px;
    	padding: 15px;
    	margin: 10px auto;
    	display: inline-block;
   	 border: 1px solid #ccc;
    	border-radius: 4px;
    	box-sizing: border-box;
	}
	input[type="text"]:focus, input[type="password"]:focus {
    	border-color: #008615;
    	outline: none;
	}
	button.login_btn {
   		width: 100%;
    	background-color: #008615;
    	color: white;
    	padding: 12px;
    	border: none;
    	border-radius: 5px;
    	cursor: pointer;
    	font-size: 16px;
	}
	button.login_btn:hover {
    	background-color: #006b12;
	}
	.button-container {
    	margin-top: 20px;
    	text-align: center;
	}
	.button-container a {
    	margin: 0 5px;
    	text-decoration: none;
	}
	button.search_id_btn, button.search_pw_btn, button.join_btn{
    	background-color: #6B8E23;
    	color: white;
    	padding: 10px 20px;
    	border: none;
    	border-radius: 4px;
    	cursor: pointer;
   		font-size: 14px;
	}
	button.search_id_btn:hover, button.search_pw_btn:hover, button.join_btn:hover {
    	background-color: #006b12;
	}
	#social_login_container{
        margin-top: 20px; margin-left: 40px;
    }
</style>
<script type="text/javascript">
</script>
</head>
<body>
<c:if test="${not empty message}">
    <script type="text/javascript">
        alert("${message}");
    </script>
</c:if>
<jsp:include page="../MAIN/header.jsp" />
<div class="main-container">
	<!-- 로그인 영역 -->
	<div class="login-container">
		<form action="/mem_login_ok" method="post">
			<table class="login-table">
				<tbody>
					<tr>
						<td><label for="userId">아이디</label></td>
						<td><input type="text" id="userId" name="userId" placeholder="아이디 입력" required></td>
					</tr>
					<tr>
						<td><label for="userPw">비밀번호</label></td>
						<td><input type="password" id="userPw" name="userPw" placeholder="비밀번호 입력" required></td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="hidden" value="login">
							<button type="submit" class="btn login_btn">로그인</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		
		<!-- 버튼 영역 -->
		<div class="button-container">
			<a href="/mem_findID"><button type="submit" class="btn search_id_btn">아이디 찾기</button></a>
			<a href="/mem_findPW"><button type="submit" class="btn search_pw_btn">비밀번호 찾기</button></a>
			<a href="/mem_joinAgree"><button type="submit" class="btn join_btn">회원가입</button></a>
		</div>
		
		<div id="social_login_container">
            <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=LATuMwgCg7IIRlZG9lKz&redirect_uri=http://localhost:8080/ict5_naverlogin&state=ICT_5">
                <img alt="네이버 로그인" src="resources/images/btnG_naver.png" width="300px;" height="70px;">
            </a>
            <a href="https://kauth.kakao.com/oauth/authorize?client_id=3ddbaef55b331705b94b177e5af93179&redirect_uri=http://localhost:8080/ict5_kakaologin&response_type=code&state=ICT_5">
                <img alt="카카오 로그인" src="resources/images/kakao_login_medium_wide.png"  width="300px;" height="60px;">
            </a>
        </div>
	</div>
</div>
<jsp:include page="../MAIN/footer.jsp" />
</body>
</html>