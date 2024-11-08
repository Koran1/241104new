<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>신고접수</title>
<style type="text/css">
/* 메인 페이지 스타일 */
.main-container {
	text-align: center;
	margin-top: 50px;
}

/* 화면 중앙에 위치한 팝업 스타일 */
.popup {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 350px;
	background-color: #fff;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.8);
	padding: 20px;
	border-radius: 8px;
	display: none;
	z-index: 1000;
}

.popup-header {
	cursor: move;
	background-color: #f1f1f1;
	padding: 10px;
	border-bottom: 1px solid #ddd;
	text-align: center;
}

.popup textarea {
	width: 100%;
	height: 200px;
	margin-top: 10px;
	padding: 8px;
	border-radius: 4px;
	resize: none;
}

.button-container {
	display: flex;
	justify-content: space-between;
	margin-top: 10px;
}

.popup button {
	flex: 1;
	margin: 0 5px;
	padding: 10px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	color: white;
}

#submit-btn {
	background-color: #d9534f;
}

#close-btn {
	background-color: gray;
}
</style>
</style>
</head>
<body>
 	<%
 	String userId = (String) session.getAttribute("userId");
 	%>

    <!-- 신고 팝업창 -->
    <div id="report-container" class="popup">
	    <div class="popup-header">
	        <h2>:: 신고 의견 접수 ::</h2>
	    </div>
        <textarea id="reportContent" placeholder="신고 사유를 입력하세요 (100자 이내)"></textarea>
        <div class="button-container">
            <button id="submit-btn" onclick="submitReport()">접수</button>
            <button id="close-btn" onclick="closeReportForm()">취소</button>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
	    $(function() {
	        $("#report-container").draggable({
	            handle: "h2"  // 제목(h2) 부분을 드래그 가능 영역으로 설정
	        });
	    });	
	    
        // 신고 팝업창 열기
        function openReportForm(tourTalkIdx, writer) {
            $('#report-container').show();
            $('#report-container').data('tourTalkIdx', tourTalkIdx);
            $('#report-container').data('writer', writer); // 글 작성자 ID
        }

        // 신고 폼 닫기
        function closeReportForm() {
            $('#report-container').hide();
        }

        // 신고 정보 전송 함수
        function submitReport() {
            const reportContent = $('#reportContent').val();
            const tourTalkIdx = $('#report-container').data('tourTalkIdx');
            const writer = $('#report-container').data('writer');
            const reporter = "<%= userId %>";  // 세션에서 가져온 userId

            // 유효성 검사
            if (!reportContent) {
                alert("신고 사유를 입력하세요.");
                return;
            }

            $.ajax({
                url: '/report',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    reporter: reporter,            // 현재 로그인된 사용자 ID
                    writer: writer,                // 신고 대상 사용자 ID (writer로 설정)
                    tourTalkIdx: tourTalkIdx,      // 신고 대상 게시글 ID
                    reportContent: reportContent   // 신고 사유
                }),
                success: function(response) {
                    if (response.status === 'duplicate') {
                        alert("동일한 신고는 할 수 없습니다");
                    } else if (response.status === 'success') {
                        alert(response.message);
                        closeReportForm();
                    } else {
                        alert(response.message);
                    }
                },
                error: function() {
                    alert("신고 접수에 실패했습니다.");
                }
            });
        }
        
      	// 팝업창 이동
		const popup = document.getElementById("report-container");
		    const popupHeader = document.querySelector(".popup-header"); // 드래그 가능 영역
		    let isDragging = false;
		    let startX, startY, initialX, initialY;
		
		    popupHeader.addEventListener("mousedown", function(e) {
		        // 드래그 상태 활성화
		        isDragging = true;
		
		        // 마우스 클릭 위치 (페이지 내 좌표)
		        startX = e.clientX;
		        startY = e.clientY;
		
		        // 팝업창의 현재 위치
		        initialX = popup.offsetLeft;
		        initialY = popup.offsetTop;
		    });
		
		    document.addEventListener("mousemove", function(e) {
		        if (isDragging) {
		            // 마우스 이동량 계산
		            const deltaX = e.clientX - startX;
		            const deltaY = e.clientY - startY;
		
		            // 팝업창의 새 위치 설정
		            popup.style.left = initialX + deltaX + "px";
		            popup.style.top = initialY + deltaY + "px";
		        }
		    });
		
		    document.addEventListener("mouseup", function() {
		        isDragging = false;
		    });
    </script>
</body>
</html>