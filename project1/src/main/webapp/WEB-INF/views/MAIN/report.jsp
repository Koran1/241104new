<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고하기</title>
    <style>
        /* 간단한 CSS */
        #report-container {
            width: 300px;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            border-radius: 5px;
        }
        textarea {
            width: 100%;
            height: 100px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

	<% String userId = (String) session.getAttribute("userId"); %>	

	 <div id="report-container" style="display:none;">
	    <h2>신고하기</h2>
	    <textarea id="reportContent" placeholder="신고 사유를 입력하세요 (최대 100자)"></textarea>
	    <button onclick="submitReport()">신고 제출</button>
	    <button onclick="closeReportForm()">취소</button>
	</div>

	<script>
    // 특정 글(tourTalkIdx)에 대한 신고 버튼을 클릭하면 신고 창을 엽니다
	    function openReportForm(tourTalkIdx, reportedUser) {
	        $('#report-container').show();
	        $('#reportContent').val(''); // 기존 입력 내용 초기화
	        $('#report-container').data('tourTalkIdx', tourTalkIdx);  // tourTalkIdx 저장
	        $('#report-container').data('reportedUser', reportedUser); // reportedUser 저장
	    }
	
	    // 신고 폼 닫기
	    function closeReportForm() {
	        $('#report-container').hide();
	    }
	
	    // 신고 제출 함수
	    function submitReport() {
	        const reportContent = $('#reportContent').val();
	        const tourTalkIdx = $('#report-container').data('tourTalkIdx');
	        const reportedUser = $('#report-container').data('reportedUser');
	
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
	                reporter: userId,         // 현재 로그인된 사용자 ID (userId는 서버에서 가져와 설정)
	                reportedUser: reportedUser, // 신고 대상 사용자 ID
	                tourTalkIdx: tourTalkIdx,   // 신고 대상 게시글 ID
	                reportContent: reportContent // 신고 사유
	            }),
	            success: function(response) {
	                alert("신고가 접수되었습니다.");
	                closeReportForm();
	            },
	            error: function() {
	                alert("신고 접수에 실패했습니다.");
	            }
	        });
	    }
	</script>
</body>
</html>