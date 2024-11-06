<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 - MyTravelList</title>
<link type="text/css" href="/resources/css/style.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        background-color: #f9f9f9;
    }
    .notice-table {
        width: 70%;
        margin: 20px auto;
        border-collapse: collapse;
        margin-bottom: 20px;
        border-top: 2px solid #708090;
    }
    .noticeSubject {
        font-size: 20px;
        text-align: left;
        padding: 10px;
        background-color: #f1f1f1;
        font-weight: bold;
    }
    .noticeReg {
        font-size: 15px;
        text-align: right;
        padding: 10px;
        background-color: #f1f1f1;
        border-bottom: 1px solid #ddd;
    }
    .noticeContent {
        padding: 20px;
        font-size: 16px;
        line-height: 1.6;
        border-bottom: 1px solid #ddd;
    }
    .pagination-table {
        width: 70%;
        margin: 0 auto;
        margin-bottom: 20px;
    }
    .pagination-label {
        text-align: left;
        font-weight: bold;
        width: 10%;
        padding: 15px;
        color: #008615;
    }
    .pagination-link a {
        text-decoration: none;
        color: black;
    }
    #pagination-now a {
        font-weight: bold;
    }
    .pagination-link a:hover {
        text-decoration: underline;
        color: #666666;
    }
    .pagination-link a, .pagination-label a {
    	text-decoration: none;
    	color: black;
    	font-weight: normal;
	}
	.pagination-link a:hover, .pagination-label a:hover {
    	text-decoration: underline;
    	color: #666666;
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
    .list-button:hover {
        background-color: #006b12;
    }
    .logo-img {
        cursor: pointer;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="header-wrap">
            <img alt="" src="<c:url value='/resources/images/logo.png' />"
                class="logo-img" style="width: 250px; height: 50px;" onclick="location.href='/'" />
            <p class="notice-title" style="text-align: center;">공지사항</p>
            <hr color="008615">
        </div>
        <div class="notice-detail-container">
            <table class="notice-table">
                <thead>
                    <tr>
                        <th class="noticeSubject">${noticevo.noticeSubject }</th>
                        <th class="noticeReg">${noticevo.noticeReg.substring(0, 10)}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="2" class="noticeContent">${noticevo.noticeContent }</td>
                    </tr>
                </tbody>
            </table>
            <table class="pagination-table">
                <tbody>
                    <tr>
                        <td class="pagination-label" id="pagination-pre">
                            <c:if test="${not empty previous}">
                                <a href="/add_notice_detail?noticeIdx=${previous.noticeIdx}">이전 ∧</a>
                            </c:if>
                        </td>
                        <td class="pagination-link">
                            <c:if test="${not empty previous}">
                                <a href="/add_notice_detail?noticeIdx=${previous.noticeIdx}">${previous.noticeSubject}</a>
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <td class="pagination-label">현재글</td>
                        <td class="pagination-link" id="pagination-now">
                            <a href="/add_notice_detail?noticeIdx=${noticevo.noticeIdx}">${noticevo.noticeSubject}</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="pagination-label" id="pagination-next">
                            <c:if test="${not empty next}">
                                <a href="/add_notice_detail?noticeIdx=${next.noticeIdx}">다음 ∨</a>
                            </c:if>
                        </td>
                        <td class="pagination-link">
                            <c:if test="${not empty next}">
                                <a href="/add_notice_detail?noticeIdx=${next.noticeIdx}">${next.noticeSubject}</a>
                            </c:if>
                        </td>
                    </tr>
                </tbody>
            </table>
            <button class="list_btn" onclick="location.href='/add_notice';">목록</button>
        </div>
    </div>
</body>
</html>
