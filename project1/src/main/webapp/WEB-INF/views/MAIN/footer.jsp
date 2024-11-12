<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="resources/css/reset.css">
<link rel="stylesheet" href="resources/css/footer.css">
<style type="text/css">
.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
	background-color: #fff;
	margin: 5% auto;
	padding: 30px;
	border-radius: 5px;
	width: 80%;
	max-width: 1000px;
	height: 70%;
	max-height: 600px;
	overflow-y: hidden;
}

.modal-in-title {
	color: #333;
	border-bottom: 2px solid #008165;
	padding-bottom: 5px;
	font-size: 24px;
}

.modal-header {
	display: flex;
	justify-content: space-between; /* 좌우 정렬 */
	align-items: center;
}

.close {
	color: #aaa;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
}

.agree-list {
	list-style-type: none;
}

.disabled {
	margin: 20px 0px 0px;
	padding: 10px 30px;
	background-color: #88B0AB;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.enabled {
	margin: 20px 0px 0px;
	padding: 10px 30px;
	background-color: #008165;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.logo-img {
	cursor: pointer;
}

.footer_center {
	display: flex;
	flex-direction: column; /* 세로 정렬 */
	align-items: center; /* 중앙 정렬 */
	gap: 0; /* 상단과 하단 간격 */
}

.footer_center_top ul {
	list-style-type: none;
	padding: 0;
	margin: 0;
	display: flex;
	gap: 15px; /* 리스트 아이템 간격 */
}

.footer_center_top li {
	font-weight: bold;
	font-size: 20px;
	color: inherit; /* 부모 요소의 텍스트 색상과 동일하게 설정 */
}

.footer_center_bottom {
	text-align: center;
	font-size: 18px; /* 글씨 크기 조정 */
	color: #555; /* 글씨 색상 조정 */
	text-align: left;
}

.footer_center_bottom p {
	margin: 10px 0;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<!-- 풋터 -->
	<footer>
		<div class="footer_container">
			<div class="footer_wrapper">
				<div class="footer_left"></div>
				
				<div class="footer_center">
					<div class="footer_center_top">
						<ul>
							<li id="btn-modal1" class="btn btn-modal">서비스이용약관 
							<li id="btn-modal2" class="btn btn-modal">개인정보처리방침
						</ul>
					</div>
					<div class="footer_center_bottom">
						<p>서울시 마포구 백범로 23 3층 한국ICT인재개발원 (우)04108 | Email:
							ictgroup5@ictgroup5.com</p>
						<p>대표번호: 02-739-7235 | Copyright ⓒ 2024 ictgroup5 All rights
							reserved.</p>
					</div>
				</div>
				
				<div class="footer_right"></div>
			</div>
		</div>
	</footer>
	
	<!-- 모달 1 -->
	<div id="modal1" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-in-title">My TravelList 이용약관</h2>
				<span class="close" data-modal="modal1">&times;</span>
			</div>
			<iframe src="<c:url value='/resources/html/terms.html' />"
				width="100%" height="100%" style="border: none;"> </iframe>
		</div>
	</div>

	<!-- 모달 2 -->
	<div id="modal2" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-in-title">My TravelList 개인정보 수집 및 이용 동의</h2>
				<span class="close" data-modal="modal2">&times;</span>
			</div>
			<iframe src="<c:url value='/resources/html/privacy.html' />"
				width="100%" height="100%" style="border: none;"> </iframe>
		</div>
	</div>
	
	<!-- 모달창 스크립트 -->
 	<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', () => {
        // 모달 열기 버튼
        const openModal1 = document.getElementById('btn-modal1');
        const openModal2 = document.getElementById('btn-modal2');

        // 모달 요소
        const modal1 = document.getElementById('modal1');
        const modal2 = document.getElementById('modal2');

        // 모달 닫기 버튼 (X 버튼)
        const closeButtons = document.querySelectorAll('.close');

        // 모달 열기 함수
        function openModal(modal) {
            modal.style.display = 'block';
        }

        // 모달 닫기 함수
        function closeModal(modal) {
            modal.style.display = 'none';
        }

        // 외부 클릭 시 모달 닫기
        function outsideClick(event, modal) {
            if (event.target === modal) {
                closeModal(modal);
            }
        }

        // 이벤트 리스너 등록
        openModal1.addEventListener('click', () => openModal(modal1));
        openModal2.addEventListener('click', () => openModal(modal2));

        closeButtons.forEach(button => {
            button.addEventListener('click', (event) => {
                const modalId = event.target.getAttribute('data-modal');
                const modal = document.getElementById(modalId);
                closeModal(modal);
            });
        });

        modal1.addEventListener('click', (event) => outsideClick(event, modal1));
        modal2.addEventListener('click', (event) => outsideClick(event, modal2));
    });
	</script>
</body>
</html>