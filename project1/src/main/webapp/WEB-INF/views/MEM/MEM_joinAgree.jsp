<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyTravelList - 회원가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link type="text/css" href="/resources/css/style.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
	body {
		margin: 0;
		padding: 0;
	}
	.main-container-join {
		margin: 0;
		padding-top: 100px;
		width: 100%;
		height: 90vh;
	}
	.main-container {
		width: 50%;
		margin: 50px auto;
		padding: 20px;
	}
	.agreement-content {
		font-size: 1.5em;
		color: #333;
		text-align: center;
		margin: 20px auto;
		padding: 20px;
	}
	.agreement-content .highlight {
		font-weight: bold;
	}
	.agreement-table {
		width: 100%;
		margin: 20px auto;
		border-spacing: 0 15px;
	}
	.agreement-table td {
		padding: 10px;
		vertical-align: middle;
	}
	.agreement-table input[type="checkbox"] {
		margin-right: 10px;
		transform: scale(1.2);
		cursor: pointer;
	}
	.checkbox-label {
		font-size: 1rem;
		color: #333;
		font-weight: bold;
	}
	.btn-modal {
		padding: 8px 16px;
		font-size: 14px;
		color: #fff;
		background-color: #02B08A;
		border: none;
		border-radius: 5px;
		cursor: pointer;
		transition: background-color 0.3s ease, transform 0.2s ease;
	}
	.btn-modal:hover {
		background-color: #005d52;
		transform: scale(1.05);
	}
	.button-container {
		display: flex;
		justify-content: center;
		margin-top: 30px;
	}
	#proceed.disabled {
		background-color: #88B0AB;
		color: white;
		border: none;
		border-radius: 5px;
		padding: 10px 30px;
		cursor: not-allowed;
	}
	#proceed.enabled {
		background-color: #008165;
		color: white;
		border: none;
		border-radius: 5px;
		padding: 10px 30px;
		cursor: pointer;
		transition: background-color 0.3s ease;
	}
	#proceed.enabled:hover {
		background-color: #005d52;
	}
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
	}
	.close {
		color: #aaa;
		float: right;
		font-size: 28px;
		font-weight: bold;
		cursor: pointer;
	}
	.close:hover,
	.close:focus {
		color: black;
		text-decoration: none;
	}
</style>
</head>
<body>
<jsp:include page="../MAIN/header.jsp" />
<div class="main-container-join">
	<div class="main-wrap">
		<div class="main-container">
			<p class="agreement-content">
				<span class="highlight">회원가입을 위해</span><br>
				<span class="highlight">약관 내용에 먼저 동의해 주세요.</span>
			</p>
			<form action="/mem_joinPage" method="post" id="agreement-form">
				<div>
					<table class="agreement-table">
						<thead>
							<tr>
								<td colspan="2">
									<label>
										<input type="checkbox" name="agreements" value="전체 동의하기" id="selectAll">
										<span class="checkbox-label">전체 동의하기</span>
									</label>
								</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<label>
										<input type="checkbox" name="agreements" value="필수 약관 동의" class="agree-item">
										<span class="checkbox-label">(필수) My TravelList 이용약관 동의</span>
									</label>
								</td>
								<td>
									<button type="button" id="btn-modal1" class="btn-modal">내용 보기</button>
								</td>
							</tr>
							<tr>
								<td>
									<label>
										<input type="checkbox" name="agreements" value="필수 개인정보 수집 및 이용 동의" class="agree-item">
										<span class="checkbox-label">(필수) My TravelList 개인정보 수집 및 이용 동의</span>
									</label>
								</td>
								<td>
									<button type="button" id="btn-modal2" class="btn-modal">내용 보기</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="button-container">
					<button type="submit" id="proceed" class="disabled" disabled>다음</button>
				</div>
			</form>
		</div>
	</div>

	<!-- 모달 1 -->
	<div id="modal1" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<span class="close" data-modal="modal1">&times;</span>
				<h2 class="modal-in-title">My TravelList 이용약관</h2>
			</div>
			<iframe src="<c:url value='/resources/html/terms.html' />"
				width="100%" height="100%" style="border: none;"> </iframe>
		</div>
	</div>

	<!-- 모달 2 -->
	<div id="modal2" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<span class="close" data-modal="modal2">&times;</span>
				<h2 class="modal-in-title">My TravelList 개인정보 수집 및 이용 동의</h2>
			</div>
			<iframe src="<c:url value='/resources/html/privacy.html' />"
				width="100%" height="100%" style="border: none;"> </iframe>
		</div>
	</div>

	<!-- 체크박스 스크립트 -->
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', () => {
			const selectAll = document.querySelector("#selectAll");
			const checkboxs = document.querySelectorAll(".agree-item");
			const proceed = document.querySelector("#proceed");

			function updateProceed() {
				const allRequiredChecked = Array.from(checkboxs).every(item => item.checked);
				if (allRequiredChecked) {
					proceed.classList.remove('disabled');
					proceed.classList.add('enabled');
					proceed.disabled = false;
				} else {
					proceed.classList.remove('enabled');
					proceed.classList.add('disabled');
					proceed.disabled = true;
				}
			}

			selectAll.addEventListener("change", () => {
				checkboxs.forEach(item => item.checked = selectAll.checked);
				updateProceed();
			});

			checkboxs.forEach(item => {
				item.addEventListener("change", () => {
					const chk = Array.from(checkboxs).every(item => item.checked);
					selectAll.checked = chk;
					updateProceed();
				});
			});
		});
	</script>

	<!-- 모달창 스크립트 -->
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', () => {
			const openModal1 = document.getElementById('btn-modal1');
			const openModal2 = document.getElementById('btn-modal2');
			const modal1 = document.getElementById('modal1');
			const modal2 = document.getElementById('modal2');
			const closeButtons = document.querySelectorAll('.close');

			function openModal(modal) {
				modal.style.display = 'block';
			}

			function closeModal(modal) {
				modal.style.display = 'none';
			}

			function outsideClick(event, modal) {
				if (event.target === modal) {
					closeModal(modal);
				}
			}

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
</div>
<jsp:include page="../MAIN/footer.jsp" />
</body>
</html>
