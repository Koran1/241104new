<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쿠키를 이용한 팝업</title>
<style type="text/css">
/* 메인 페이지 스타일 */
.main-container {
	text-align: center;
	margin-top: 50px;
}

img {
	max-width: 100%;
	height: auto;
}
/* 왼쪽에 상대적으로 배치된 팝업 스타일 */
.popup {
	position: fixed;
	top: 100px; /* 상단에서 100px 떨어진 위치 */
	left: 30px; /* 왼쪽에서 10px 떨어진 위치 */
	width: 250px;
	background-color: #fff;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	display: none;
	z-index: 1000;
}

.popup-content {
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 10px;
}

.popup-content img {
	width: 100%;
	height: auto;
	margin-bottom: 10px;
}

.popup-content p {
	margin: 0;
	font-size: 12px;
	color: #666;
	text-align: center;
}

#close-btn {
	margin-top: 10px;
	padding: 5px 10px;
	background-color: gray;
	color: white;
	border: none;
	cursor: pointer;
	width: 100%;
}

/* 하루 동안 보지 않기 체크박스 */
.no-show {
	text-align: center;
	font-size: 12px;
	color: #FF5722;
	cursor: pointer;
	margin-top: 10px;
}

.no-show label {
	cursor: pointer;
	color: #666;
	font-size: 12px;
}
</style>
</head>
<body>
	<!-- 팝업  -->
	<div id="cookie-popup" class="popup">
		<div class="popup-content"></div>
		<img alt="Sample Image" src="resources/images/popup_img.jpg">
		<div class="no-show">
			<label><input type="checkbox" id="no-show-checkbox">오늘 하루 보지않기</label>
			<button id="close-btn">닫기</button>
		</div>
	</div>

	<script type="text/javascript">
		// 쿠키 설정 (set)
		function setCookie(name, value, days) {
			const date = new Date();
			date.setTime(date.getTime() + (days * 24*60*60 * 1000));
			const expires = "expires=" + date.toUTCString();
			document.cookie = name + "=" + value + ";" + expires + ";path=/"
		}
		
		// 쿠키 내용 가져오기 함수 (get)
		function getCookie(name) {
			const nameEQ = name + "=";
			const ca = document.cookie.split(";");
			for (let i = 0; i < ca.length; i++) {
				let c = ca[i];
				if(c.indexOf(nameEQ) === 0){
					return c.substring(nameEQ.length, c.length);
				}
			}
			return "";
		}
		
		// 팝업 표시
		window.onload = function() {
			const popup = document.querySelector("#cookie-popup");
			const popupClosed = getCookie("popupClosed");
			
			if(!popupClosed){
				popup.style.display = "block";
				// closeModal();
			}
			// 닫기 버튼 클릭
			document.querySelector("#close-btn").addEventListener('click', function() {
				const popup = document.querySelector("#cookie-popup");
				if(document.querySelector("#no-show-checkbox").checked){
					setCookie("popupClosed", "true", 1);
				}
				popup.style.display = "none";
				// closeModal();
			});
		}
	</script>

</body>
</html>