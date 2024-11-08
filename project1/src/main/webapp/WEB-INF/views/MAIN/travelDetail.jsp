<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" %>
	
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList - 관광지 상세보기</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="resources/css/summernote-lite.css">
	
<link rel="stylesheet" href="resources/css/reset.css">
<link rel="stylesheet" href="resources/css/header.css">
<link rel="stylesheet" href="resources/css/footer.css">
<style type="text/css">

/* 메뉴 컨테이너 스타일 */
.menu_container {
	width: 100%;
	display: flex;
	margin-top: 69px;
	justify-content: center;
	align-content: center;
	background-color: white;
	border: 0.5px solid #ddd;
	border-left: none;
	border-right: none;
	padding: 10px 0;
	position: fixed;
	z-index: 5;
	top: 0;
}

.menu_container ul {
	display: flex;
	list-style-type: none;
	padding: 10px 0;
}
/* 메뉴 항목 스타일 */
.menu_container ul li {
	padding: 10px 50px;
	border-left: 1px solid rgb(211, 209, 209);
	border-right: 1px solid rgb(211, 209, 209);
}

.menu_container ul li:first-child {
	border-left: none;
}

.menu_container ul li:last-child {
	border-right: none;
}

/* 메뉴 버튼 스타일 */
.menu-btn {
	background-color: white;
	color: black;
	font-weight: bold;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	font-size: 1.2rem;
}

/* 전체 컨테이너 */
.main_wrapper {
	width: 100%;
	padding-top: 130px;
}

.main_left, .main_right {
	flex: 1 1 10%;
	/* background-color: red; 디버깅 완료 후 제거 */
}

.main_center {
	flex: 1 1 80%;
	padding: 20px;
	box-sizing: border-box;
}

/* 관광지 이름 컨테이너 */
.trrname {
	text-align: center;
	font-size: 28px;
	color: rgba(100, 50, 15, 10);
	font-weight: bold;
	margin: 30px 0;
	text-decoration: underline;
	text-decoration-color: rgba(255, 249, 196, 0.6); /* 줄의 색을 노란색으로 */
	text-decoration-thickness: 10px; /* 줄 두께 */
}
/* 사진 갤러리 */
.photo_gallery {
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
	justify-content: center;
}

.photo_big {
	width: 700px;
	height: 500px;
}

.photo_small {
	display: flex;
	justify-content: space-between;
	flex-direction: column;
}

.small {
	width: 170px;
	height: 120px;
}

/* 상세정보 */
.travel_info {
	width: 65%;
	margin: 10px auto;
	padding: 20px;
	/* box-sizing: border-box; */
}

.details_box {
	line-height: 1.5;
	padding: 20px;
	margin-bottom: 20px;
	border-bottom: 1px solid #ddd;
	color: rgb(61, 57, 57);
}

/* 지도 섹션 */
.kakaoMap {
	width: 100%;
	align-items: center;
	justify-content: center;
}

.maps {
	line-height: 1.5;
	padding: 20px;
	margin-bottom: 20px;
	border-bottom: 1px solid #ddd;
}

/* 여행톡 섹션 */
#bbs form {
	text-align: right; /* 폼 내 콘텐츠 오른쪽 정렬 */
	margin-top: 5px;
}

.title {
	font-size: 18px;
	font-weight: bold;
	color: #666;
}

.tourTList {
	padding: 15px;
	border-bottom: 1px solid #e6e6e6;
	max-width: 800px; /* 고정 너비 */
	margin: 0 auto; /* 가운데 정렬 */
	text-align: left; /* 왼쪽 정렬 */
}
/* 내용 텍스트 정렬 */
.tourTContent {
	max-width: 800px;
	margin-bottom: 10px; /* 하단 여백 추가 */
	text-align: left; /* 왼쪽 정렬 */
	color: #666;
}
/* 사용자 정보와 날짜를 가로로 정렬 */
.tourinfo {
	display: flex;
	align-items: center;
	gap: 10px;
}

.tourinfo li {
	display: flex;
	margin-right: 20px;
	color: #666;
	font-size: 16px;
	margin-right: 10px;
}

.tourTId, .tourTReg {
	list-style: none;
	font-size: 18px;
	color: #666;
	text-align: left;
}

.userReport {
	flex: right;
}

/* 신고 버튼 스타일 */
.report-icon-button {
	color: #666; /* 기본 아이콘 색상 */
	font-size: 16px;
	cursor: pointer;
	transition: color 0.3s;
	border: none;
	background: none;
}
.report-icon-button:hover {
	color: #d9534f;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />

	<!-- 세션에 저장된 id를 불러옴 -->
	<%
	String userId = (String) session.getAttribute("userId");
	%>

	<!-- 고정된 메뉴 섹션 -->
	<div class="menu_container">
		<ul>
			<li class="select_tab on">
				<button class="menu-btn" onclick="scrollToSection('photos')">사진보기</button>
			</li>
			<li class="select_tab">
				<button class="menu-btn" onclick="scrollToSection('details')">상세보기</button>
			</li>
			<li class="select_tab">
				<button class="menu-btn" onclick="scrollToSection('map')">지도보기</button>
			</li>
			<li class="select_tab">
				<button class="menu-btn" onclick="scrollToSection('tourTalk')">여행톡</button>
			</li>
		</ul>
	</div>

	<!-- 본문 내용 -->
	<div class="main_wrapper" id="photos">
		<div class="main_left"></div>

		<!-- 메인 센터 -->
		<div class="main_center">
			<div class="trrname">${list.trrsrtNm} </div>
			<!-- 사진 섹션 -->
			<div class="photo_gallery">
				<img src="${list.placeImg01}" alt="관광지 이미지01" class="photo_big" id="photo_big">
				<div class="photo_small">
					<img src="${list.placeImg01}" alt="관광지 이미지01" class="small" onclick="changeBig(this)"> 
					<img src="${list.placeImg02}" alt="관광지 이미지02" class="small" onclick="changeBig(this)"> 
					<img src="${list.placeImg03}" alt="관광지 이미지03" class="small" onclick="changeBig(this)"> 
					<img src="${list.placeImg04}" alt="관광지 이미지04" class="small" onclick="changeBig(this)">
				</div>
			</div>

			<!-- 모달 창 구조 -->
			<div id="imageModal" class="modal">
				<span class="close">&times;</span> <img class="modal-content"
					id="modalImage">
			</div>

			<!-- 상세보기 섹션 -->
			<div id="details"></div>
			<div class="travel_info">
				<div class="title">상세정보</div>
				<hr>
				<div class="details_box">
					<ul>
						<li><p style="font-weight: bold;">관광지 소개</p>
							<p>${list.trrsrtIntrcn}</p>
							<br>
						</li>
						<li><c:if test="${empty list.rdnmadr and empty list.lnmadr}">
							</c:if> <c:if test="${not empty list.rdnmadr and empty list.lnmadr}">
								<p>
									<span style="font-weight: bold;">주소:</span> ${list.rdnmadr}
								</p>
							</c:if> <c:if test="${empty list.rdnmadr and not empty list.lnmadr}">
								<p>
									<span style="font-weight: bold;">주소:</span> ${list.lnmadr}
								</p>
							</c:if> <c:if test="${not empty list.rdnmadr and not empty list.lnmadr}">
								<p>
									<span style="font-weight: bold;">주소:</span> ${list.rdnmadr}
								</p>
							</c:if>
						</li>
						<c:if
							test="${not empty list.cnvnncFclty or not empty list.recrtClturFclty or not empty list.mvmAmsmtFclty or not empty list.hospitalityFclty or not empty list.sportFclty}">
							<li><span style="font-weight: bold;">시설정보:</span> <c:if
									test="${not empty list.cnvnncFclty}">${list.cnvnncFclty} </c:if>
								<c:if test="${not empty list.recrtClturFclty}">${list.recrtClturFclty} </c:if>
								<c:if test="${not empty list.mvmAmsmtFclty}">${list.mvmAmsmtFclty} </c:if>
								<c:if test="${not empty list.hospitalityFclty}">${list.hospitalityFclty} </c:if>
								<c:if test="${not empty list.sportFclty}">${list.sportFclty}</c:if>
							</li>
						</c:if>

						<c:if test="${not empty list.stayngInfo}">
							<li><span style="font-weight: bold;">숙박시설:</span>${list.stayngInfo}</li>
						</c:if>

						<c:if test="${not empty list.aceptncCo}">
							<li><span style="font-weight: bold;">수용인원:</span> <fmt:formatNumber value="${list.aceptncCo}" pattern="#,##0" />명</li>
						</c:if>

						<c:if test="${not empty list.prkplceCo}">
							<li><span style="font-weight: bold;">주차대수:</span> <fmt:formatNumber value="${list.prkplceCo}" pattern="#,##0" />대</li>
						</c:if>

						<c:if test="${not empty list.phoneNumber}">
							<li><span style="font-weight: bold;">☎</span>${list.phoneNumber}</li>
						</c:if>

						<c:if test="${not empty list.referenceDate}">
							<li><span style="font-weight: bold;">정보 업데이트:</span>${list.referenceDate}</li>
						</c:if>
					</ul>
				</div>

				<!-- 카카오 지도 섹션 -->
				<div class="title">지도보기</div><br>
				<div class="kakaoMap" id="kakaoMap">
					<div id="map" class="map" style="width: 100%; height: 450px;"></div>
				</div><br><br>

				<!-- 여행톡 섹션 -->
				<div class="title" id="tourTalk">여행톡</div><br>
				<div id="bbs" align="center">
					<input type="hidden" id="travelIdx" value="${param.travelIdx}">
					<form id="bbsForm" method="post" encType="multipart/form-data">
						<textarea name="content" id="content"></textarea>
						<c:choose>
							<c:when test="${empty userId}">
								<input type="button" value="로그인" onclick="mem_login()">
							</c:when>
							<c:otherwise>
								<input type="button" value="등록" onclick="tourtalk_write_ok()">
							</c:otherwise>
						</c:choose>
					</form>
					<div id="tourTalkList"></div>
					<div>
						<jsp:include page="report.jsp" />
					</div>
				</div>

			</div>
		</div>

		<div class="main_right">
			<jsp:include page="scroll.jsp" />
		</div>
	</div>

	<div><jsp:include page="footer.jsp" /></div>


	<script type="text/javascript">
		function mem_login() {
			location.href="/mem_login";
		}
	</script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>
	<script src="resources/js/summernote-lite.js" ></script>
	<script src="resources/js/lang/summernote-ko-KR.js" ></script>

	<script type="text/javascript">
	    const userId = "<%= userId %>";
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
		    // travelIdx를 hidden 필드에서 가져오기
		    const travelIdx = $('#travelIdx').val();
		    
		    // 페이지 로드 시 해당 travelIdx에 맞는 글 목록을 불러오기
		    loadTourTalkData(travelIdx);
		    
		    // Summernote 초기화
		    $("#content").summernote({
		        lang: 'ko-KR',
		        height: 100,
		        focus: false,
		        placeholder: "최대 500자까지 쓸 수 있습니다.",
		        callbacks: {
		            onImageUpload: function(files, editor) {
		                for (let i = 0; i < files.length; i++) {
		                    sendImage(files[i], editor);
		                }
		            }
		        }
		    });
 		    $(".note-editable").css({
		        "text-align": "left",
		        "width": "100%",  // 에디터 너비 조절 가능
		    }); 
		});
		    
		// 서버에서 travelIdx에 맞는 글 목록 데이터를 가져와 표시
		function loadTourTalkData(travelIdx) {
		    $.ajax({
		        url: "/getTourTalkList",
		        method: "post",
		        data: { travelIdx: travelIdx },
		        dataType: "json",
		        success: function(response) {
		            updateRecentlists(response);
		        },
		        error: function() {
		            /* alert("데이터 요청 중 오류가 발생했습니다."); */
		        }
		    });
		}
		
		function formatDateTime(dateTimeString) {
		    // "YYYY-MM-DD HH:MM:SS"에서 "MM-DD HH:MM"만 잘라냅니다.
		    return dateTimeString.substring(5, 16);
		}
		
		// 가져온 데이터로 최신 글 목록을 동적으로 렌더링
		function updateRecentlists(lists) {
		    let talkHtml = "";
		    lists.forEach(list => {
		        const tourTalkIdx = list.tourTalkIdx;
		        const userId = list.userId;
		
		        talkHtml += "<div class='tourTList'>";
		        talkHtml += "<div class='tourTContent'><p>" + list.tourTalkContent + "</p></div>";
		        talkHtml += "<ul class='tourinfo'>";
		        talkHtml += "<li class='tourTId'>" + userId + "</li>";
		        talkHtml += "<li class='tourTReg'>" + formatDateTime(list.tourTalkReg) + "</li>";
		        talkHtml += "<li class='userReport'>";
		        // 신고 버튼 클릭 시 openReportForm 함수 호출
		        talkHtml += "<button class='report-icon-button' onclick='openReportForm(" + tourTalkIdx + ", \"" + userId + "\")'>신고 <i class='fas fa-exclamation-circle'></i></li>";
		        talkHtml += "</ul>";
		        talkHtml += "</div>";
		        talkHtml += "</div>";
		    });
		    $('#tourTalkList').html(talkHtml);
		}

		// 글 등록 버튼 클릭 시 호출되는 함수
	    function tourtalk_write_ok() {
	        const tourTalkContent = $('#content').val();
	        const travelIdx = $('#travelIdx').val(); // travelIdx 값을 가져옵니다
	        
	        // 입력 값이 비어 있거나 공백만 있는 경우 경고창 띄우기
	        if (!tourTalkContent || tourTalkContent.trim() === "") {
	            alert("내용을 입력해주세요");
	            return; // 함수를 종료하여 서버에 요청하지 않음
	        }
	        
	        $.ajax({
	            url: "/tourtalk_write_ok",
	            method: "POST",
	            data: {
	            	tourTalkContent: tourTalkContent,
	                travelIdx: travelIdx 	
	            },
	            success: function(response) {
	            	loadTourTalkData(travelIdx);
                    $('#content').summernote('reset'); // 입력 필드 초기화
	            },
	            error: function() {
	                alert("오류가 발생했습니다.");
	            }
	        });
	    }
		
		// 이미지 업로드 처리
		function sendImage(file, editor) {
		    let formData = new FormData();
		    formData.append("s_file", file);
		    $.ajax({
		        url: "/saveImg",
		        data: formData,
		        method: "POST",
		        contentType: false,
		        processData: false,
			  	cache : false,
			  	dataType : "json",
			  	success : function(data) {
					 const path = data.path;
					 const fname = data.fname ;
					 $("#content").summernote("editor.insertImage", path+"/"+fname);
			  	},
			  error : function() {
				alert("이미지 업로드 실패");
			}
		  });
		}
	    </script>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=590d5be37368c91772ba5516b2944ed1"></script>
	<script type="text/javascript">
	    // Controller로부터 전달된 데이터를 자바스크립트 변수에 할당
	    const lat = "${list.latitude}";
	    const lng = "${list.longitude}";
	
	    // 지도 생성 함수 호출
	    geo_map(lat, lng);

        function geo_map(lat, lng) {
            let mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
                level: 4 // 지도의 확대 레벨 (1~14)
            };

            // 지도를 생성합니다
            let map = new kakao.maps.Map(mapContainer, mapOption);

            // 마커 위치 설정
            let markerPosition = new kakao.maps.LatLng(lat, lng);

            // 마커를 생성하고 지도에 표시합니다
            let marker = new kakao.maps.Marker({
                position: markerPosition
            });
            marker.setMap(map);

            // 인포윈도우 설정
            let iwContent = '<div style="padding:10px;">${list.trrsrtNm}</div>',
                iwPosition = new kakao.maps.LatLng(lat, lng);

            let infowindow = new kakao.maps.InfoWindow({
                position: iwPosition,
                content: iwContent
            });

            // 마커에 인포윈도우를 표시합니다
            infowindow.open(map, marker);
        }
    </script>
    
	<script type="text/javascript">
	    document.addEventListener("DOMContentLoaded", function () {
	        // URL에 #tourTalk 등의 앵커가 있을 경우 제거
	        if (window.location.hash === "#tourTalk") {
	            history.replaceState(null, null, ' '); // URL에서 앵커 제거
	        }
	
	        // 페이지 로드 시 photo_gallery 섹션으로만 자동 스크롤 이동
	        scrollToSection('photo_gallery');
	    });
	</script>
	<script type="text/javascript">
		// 섹션으로 부드럽게 스크롤하는 함수
		function scrollToSection(sectionId) {
			// 섹션 ID에 해당하는 요소를 찾음
			const section = document.getElementById(sectionId);
			// 해당 섹션의 화면 위치를 계산
			// 고정된 메뉴의 높이를 계산
	        const menuHeight = document.querySelector('.menu_container').offsetHeight;

	        // 추가로 100px 오프셋 설정
	        const additionalOffset = 160;

	        // 스크롤 위치 조정 (고정 메뉴 높이 + 추가 오프셋)
	        const sectionPosition = section.getBoundingClientRect().top + window.scrollY - menuHeight - additionalOffset;

	        window.scrollTo({ top: sectionPosition, behavior: 'smooth' });
	    }

		// 사진보기 버튼 클릭 시 photo_gallery 섹션으로 이동
		function goToPhotoGallery() {
			scrollToSection('photo_gallery');
		}

		// 상세보기 버튼 클릭 시 details_box 섹션으로 이동
		function goToDetailsBox() {
			scrollToSection('details');
		}

		// 지도보기 버튼 클릭 시 kakaoMap 섹션으로 이동
		function goToKakaoMap() {
			scrollToSection('kakaoMap');
		}

 		// 여행톡 버튼 클릭 시 tourTalk 섹션으로 이동
		function goToTourTalk() {
			scrollToSection('tourTalk');
		} 
	</script>

	<script type="text/javascript">
	    document.addEventListener("DOMContentLoaded", function () {
	        const bigImage = document.getElementById("photo_big");
	        const smallImages = document.querySelectorAll(".photo_small .small");
	        const modal = document.getElementById("imageModal");
	        const modalImage = document.getElementById("modalImage");
	        const closeModal = document.querySelector(".close");
	
	        // 작은 이미지를 클릭하면 큰 이미지 변경
	        smallImages.forEach(function (smallImg) {
	            smallImg.addEventListener("click", function () {
	                bigImage.src = smallImg.src;
	            });
	        });
	
	        // 큰 이미지 클릭 시 모달 창 열기
	        bigImage.addEventListener("click", function () {
	            modal.style.display = "block";
	            modalImage.src = bigImage.src;
	        });
	
	    	 // 모달 배경을 클릭하면 모달 닫기
	        modal.addEventListener("click", function (event) {
	            if (event.target !== modalImage) {  // 모달 배경 클릭 시 닫기
	                modal.style.display = "none";
	            }
	        });

	        // 모달 이미지 클릭 시 모달 닫기
	        modalImage.addEventListener("click", function () {
	            modal.style.display = "none";
	        });
	    });
	</script>

</body>
</html>