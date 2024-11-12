<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList - FAQ</title>
<link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" rel="stylesheet">
<link type="text/css" href="/resources/css/style.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        overflow-y: auto;
    }
    .main-container {
        margin: 0;
        padding-top: 100px;
        width: 100%;
        min-height: 90vh;
    }
    .tab-container {
        margin-bottom: 20px;
    }
    ul.tab-menu {
        list-style-type: none;
        margin: 0;
        padding: 0;
        border-bottom: 2px solid #008165;
        width: 70%;
        margin: 0 auto;
        display: flex;
    }
    ul.tab-menu::after {
        content: '';
        display: block;
        clear: both;
    }
    .tab-button {
        flex: 1;
        padding: 10px 0;
        text-align: center;
        color: gray;
        text-decoration: none;
        cursor: pointer;
    }
    .tab-button.active {
        background-color: #f5f5f5;
        color: #008165;
    }
    .tab-button:hover {
        background-color: #f0f0f0;
        color: black;
    }
    .tab-notice-menu {
        text-decoration: none;
        color: inherit;
    }
    .tab-button a {
        display: block;
        text-decoration: none;
        color: inherit;
    }
    /* FAQ 스타일 */
    .faq-container {
        width: 70%;
        margin: 0 auto;
    }
    .faq-item {
        border-top: 1px solid #ddd;
        margin-top: 10px;
    }
    .faq-question {
        cursor: pointer;
        padding: 15px;
        font-weight: bold;
    }
    .faq-answer {
        display: none;
        background-color: #f9f9f9;
        padding: 15px;
        color: #333;
        overflow-wrap: break-word;
    }
    .faq-answer.visible {
        display: block;
    }
    .toggle-btn {
        float: right;
        font-size: 14px;
        color: #2c3e50;
    }
    /* 페이징 스타일 */
    ol.paging {
        margin: 0 auto;
        display: table;
        text-align: center;
        margin-bottom: 30px;
        list-style: none;
        padding: 0;
    }
    ol.paging li {
        display: inline-block;
        margin: 5px;
    }
    ol.paging li a,
    ol.paging li.disable,
    ol.paging li.now {
        color: #555;
        padding: 8px 16px;
        text-decoration: none;
        background: #eee;
        border-radius: 4px;
    }
    ol.paging li.disable {
        background: #ddd;
        color: #bbb;
    }
    ol.paging li a:hover {
        background: #ccc;
    }
    ol.paging li.now {
        background: #008165;
        color: white;
        border: none;
    }
</style>
</head>
<body>
<jsp:include page="../MAIN/header.jsp" />
<div class="main-container">
    <div class="tab-container">
        <ul class="tab-menu">
            <li class="tab-button"><a href="/add_notice" class="tab-notice-menu">공지사항</a></li>
            <li class="tab-button active"><a href="/add_faq" class="tab-notice-menu">자주 묻는 질문</a></li>
            <li class="tab-button"><a href="/add_qna" class="tab-notice-menu">나의 질문</a></li>
        </ul>
    </div>
    <div class="faq-container">
        <c:choose>
            <c:when test="${empty faq_list}">
                <div class="faq-item">
                    <p>FAQ가 없습니다.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${faq_list}" var="k">
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleAnswer('answer${k.faqIdx}', 'btn${k.faqIdx}')">
                            ${k.faqQuestion}
                            <span id="btn${k.faqIdx}" class="toggle-btn">∨</span>
                        </div>
                        <div class="faq-answer" id="answer${k.faqIdx}">
                            ${k.faqAnswer}
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <!-- 페이징 -->
        <ol class="paging">
            <!-- 맨 첫 페이지로 -->
            <c:choose>
                <c:when test="${paging.nowPage == 1}">
                    <li class="disable">&laquo;</li>
                </c:when>
                <c:otherwise>
                    <li><a href="/add_faq?cPage=1">&laquo;</a></li>
                </c:otherwise>
            </c:choose>
            <!-- 이전 -->
            <c:choose>
                <c:when test="${paging.beginBlock <= paging.pagePerBlock}">
                    <li class="disable">&lsaquo;</li>
                </c:when>
                <c:otherwise>
                    <li><a href="/add_faq?cPage=${paging.beginBlock - paging.pagePerBlock}">&lsaquo;</a></li>
                </c:otherwise>
            </c:choose>
            <!-- 현재 블록의 페이지 번호 -->
            <c:forEach begin="${paging.beginBlock}" end="${paging.endBlock}" step="1" var="k">
                <c:if test="${k == paging.nowPage}">
                    <li class="now">${k}</li>
                </c:if>
                <c:if test="${k != paging.nowPage}">
                    <li><a href="/add_faq?cPage=${k}">${k}</a></li>
                </c:if>
            </c:forEach>
            <!-- 다음 -->
            <c:choose>
                <c:when test="${paging.endBlock >= paging.totalPage}">
                    <li class="disable">&rsaquo;</li>
                </c:when>
                <c:otherwise>
                    <li><a href="/add_faq?cPage=${paging.beginBlock + paging.pagePerBlock}">&rsaquo;</a></li>
                </c:otherwise>
            </c:choose>
            <!-- 맨 마지막 페이지로 -->
            <c:choose>
                <c:when test="${paging.nowPage == paging.totalPage}">
                    <li class="disable">&raquo;</li>
                </c:when>
                <c:otherwise>
                    <li><a href="/add_faq?cPage=${paging.totalPage}">&raquo;</a></li>
                </c:otherwise>
            </c:choose>
        </ol>
    </div>
</div>
<script type="text/javascript">
    function toggleAnswer(id, btnId) {
        let answer = document.getElementById(id);
        let button = document.getElementById(btnId);
        if (answer.classList.contains("visible")) {
            answer.classList.remove("visible");
            button.textContent = "∨";
        } else {
            answer.classList.add("visible");
            button.textContent = "∧";
            answer.scrollIntoView({ behavior: "smooth", block: "center" });
        }
    }
    window.onload = function() {
        let firstAnswer = document.querySelector('.faq-answer');
        let firstButton = document.querySelector('.toggle-btn');
        if (firstAnswer && firstButton) {
            firstAnswer.classList.add("visible");
            firstButton.textContent = "∧";
        }
    };
</script>
<jsp:include page="../MAIN/footer.jsp" />
</body>
</html>
