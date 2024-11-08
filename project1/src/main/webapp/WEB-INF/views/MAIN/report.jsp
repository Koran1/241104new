<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 기능</title>
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
        <button onclick="submitReport()">접수</button>
        <button onclick="closeReportForm()">취소</button>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
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
                    if (response.status === 'success') {
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
    </script>
</body>
</html>
