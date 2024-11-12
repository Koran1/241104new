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
	body {
		margin: 0;
		padding: 0;
	}
	.main-container {
		margin: 0;
		padding: 20px 0;
		width: 100%;
		min-height: calc(100vh - 60px);
		display: flex;
		justify-content: center;
		align-items: center;
		box-sizing: border-box;
	}
	.login-container {
		width: 80%;
		max-width: 600px;
		padding: 5%;
		text-align: center;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	.login_table {
		width: 400px;
		margin-bottom: 20px;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	.login_table input {
		width: 400px;
		padding: 12px;
		margin: 10px 0;
		border: 1px solid #ccc;
		border-radius: 5px;
		box-sizing: border-box;
		font-size: 16px;
	}
	.login_table input:focus {
		border-color: #008615;
		outline: none;
	}
	button.login_btn {
		width: 400px;
		background-color: #008615;
		color: white;
		padding: 12px;
		border: none;
		border-radius: 5px;
		cursor: pointer;
		font-size: 16px;
		margin-top: 20px;
	}
	button.login_btn:hover {
		background-color: #006b12;
	}
	.options-container {
		display: flex;
		justify-content: center;
		align-items: center;
		margin-top: 5%;
		font-size: 14px;
		color: #666;
		gap: 10px;
	}
	.options-container span {
		margin: 0 5px;
	}
	.options-container a {
		text-decoration: none;
		color: #008615;
		font-weight: bold;
		white-space: nowrap;
	}
	.options-container a:hover {
		text-decoration: underline;
	}
	#social_login_container {
		width: 400px;
		margin-top: 5%;
		display: flex;
		justify-content: center;
		align-items: center;
		gap: 5px;
	}
	#social_login_container a img {
		width: 60px;
		height: 60px;
		border-radius: 5px
		object-fit: cover;
		margin: 0;
	}
	#social_login_container a {
		margin: 0;
	}
</style>
</head>
<body>
<c:if test="${not empty message}">
	<script type="text/javascript">
		alert("${message}");
	</script>
</c:if>
<jsp:include page="../MAIN/header.jsp" />
<div class="main-container">
	<div class="login-container">
		<!-- 로그인 입력 영역 -->
		<form action="/mem_login_ok" method="post">
			<h1 style="font-size: 36px; font-weight: bold; color: #008615; text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);">
				로그인
			</h1>

			<table class="login_table">
				<tr>
					<td>
						<input type="text" id="userId" name="userId" placeholder="아이디 입력" required>
					</td>
				</tr>
				<tr>
					<td>
						<input type="password" id="userPw" name="userPw" placeholder="비밀번호 입력" required>
					</td>
				</tr>
				<tr>
					<td>
						<button type="submit" class="btn login_btn">로그인</button>
					</td>
				</tr>
			</table>
		</form>

		<!-- 옵션 버튼 영역 -->
		<div class="options-container">
			<a href="/mem_findID">아이디 찾기</a>
			<span>|</span>
			<a href="/mem_findPW">비밀번호 찾기</a>
			<span>|</span>
			<a href="/mem_joinAgree">회원가입</a>
		</div>

		<!-- 소셜 로그인 -->
		<div id="social_login_container">
<<<<<<< HEAD
            <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=LATuMwgCg7IIRlZG9lKz&redirect_uri=http://13.124.3.43/ict5_naverlogin&state=ICT_5">
                <img alt="네이버 로그인" src="resources/images/btnG_naver.png" width="300px;" height="70px;">
            </a>
            <a href="https://kauth.kakao.com/oauth/authorize?client_id=3ddbaef55b331705b94b177e5af93179&redirect_uri=http://13.124.3.43/ict5_kakaologin&response_type=code&state=ICT_5">
                <img alt="카카오 로그인" src="resources/images/kakao_login_medium_wide.png"  width="300px;" height="60px;">
            </a>
        </div>
=======
			<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=LATuMwgCg7IIRlZG9lKz&redirect_uri=http://localhost:8080/ict5_naverlogin&state=ICT_5">
				<img alt="네이버 로그인" src="resources/images/btnG_icon_square.png">
			</a>
			<a href="https://kauth.kakao.com/oauth/authorize?client_id=3ddbaef55b331705b94b177e5af93179&redirect_uri=http://localhost:8080/ict5_kakaologin&response_type=code&state=ICT_5">
				<img alt="카카오 로그인" src="resources/images/kakaotalk_sharing_btn_small_ov.png">
			</a>
		</div>
>>>>>>> f6c6df63347e687a22d2436ab6f61cb75309fbdf
	</div>
</div>	
<jsp:include page="../MAIN/footer.jsp" />
</body>
</html>
