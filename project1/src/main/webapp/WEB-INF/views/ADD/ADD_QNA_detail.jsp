<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyTravelList - Q&A</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link type="text/css" href="/resources/css/style.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        background-color: #f9f9f9;
    }
    .main-container {
        margin: 0;
        padding-top: 100px;
        width: 100%;
        height: 90vh;
        display: flex;
        flex-direction: column;
    }
    .qna-detail-container {
        flex: 1;
        overflow-y: auto;
        padding: 20px;
    }
    .qna-detail {
        width: 70%;
        margin: 0 auto;
        border: 1px solid #ddd;
        background-color: white;
        border-radius: 5px;
        overflow: hidden;
    }
    .qna-header, .qna-file, .qna-content {
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }
    .qna-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #f1f1f1;
    }
    .qna-header .qnaSubject {
        font-size: 20px;
        font-weight: bold;
    }
    .qna-header .userId, .qna-header .qnaReg {
        font-size: 15px;
    }
    .qna-file {
        font-size: 15px;
        text-align: left;
    }
    .qna-file img {
        max-width: 100px;
        margin-right: 10px;
        vertical-align: middle;
    }
    .qna-file a {
        text-decoration: none;
        color: black;
    }
    .qna-file a:hover {
        text-decoration: underline;
        color: #666666;
    }
    .qna-content {
        font-size: 16px;
        line-height: 1.6;
    }
    .list_btn {
        margin: 20px auto;
        padding: 10px 30px;
        background-color: #008165;
        color: white;
        border: none;
        border-radius: 5px;
        display: block;
        cursor: pointer;
        width: fit-content;
    }
    .list_btn:hover {
        background-color: #006b12;
    }
    .logo-img {
        cursor: pointer;
    }
</style>
</head>
<body>
<jsp:include page="../MAIN/header.jsp" />
<div class="main-container">
    <div class="qna-detail-container">
        <div class="qna-detail">
            <div class="qna-header">
                <div class="qnaSubject">${qnavo.qnaSubject }</div>
                <div class="userId">${qnavo.userId }</div>
                <div class="qnaReg">${qnavo.qnaReg.substring(0, 10) }</div>
            </div>
            <div class="qna-file">
                <c:choose>
                    <c:when test="${empty qnavo.qnaFile}">
                        첨부 파일 없음
                    </c:when>
                    <c:otherwise>
                        <img alt="img" src="/resources/upload/${qnavo.qnaFile}">
                        <a href="/add_qna_ask_filedown?qnaFile=${qnavo.qnaFile }">${qnavo.qnaFile }</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="qna-content">${qnavo.qnaContent }</div>
        </div>
    </div>
    <button class="list_btn" onclick="location.href='/add_qna';">목록</button>
</div>
<jsp:include page="../MAIN/footer.jsp" />
</body>
</html>