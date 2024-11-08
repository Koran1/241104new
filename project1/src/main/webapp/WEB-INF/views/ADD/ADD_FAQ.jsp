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

	body{
		margin: 0;
		padding: 0;
	}
	.main-container{
		margin: 0;
		padding-top: 100px;
		width: 100%;
		height: 90vh;
	}
	table{
		width: 70%;
		height: 100%;
		margin: 20px auto;
		border-collapse: collapse;
		border-top: 2px solid #708090;
	}
	tr{
		border-bottom: 1px solid #ddd;
	}
	td{
		padding: 15px;
		text-align: left;
	}
	.tab-container{
		margin-bottom: 20px;
	}
	.faq-container{
		width: 100%;
		height: 100%;
	}
	.faq-table{
		margin: 0px auto;
		width: 70%;
		height: 100%;
	}
	.faq-question{
		cursor: pointer;
		border-top: 1px solid #ddd;
	}
	.faq-question td{
		padding-top: 10px;
		padding-left: 10px;
		height: 10%;
	}
	.faq-answer{
		height: 10%;
		display: none;
		color: #222222;
		background: #f9f9f9;
	}
	.faq-answer.visible{
		display: table-row;
	}
	.faq-answer.visible td{
		padding-left: 10px;
		padding-top: 10px;
	}
	.toggle-btn{
		cursor: pointer;
		color: #2c3e50;
		text-align: right;
	}
	.logo-img{
		cursor: pointer;
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
    /* paging */
	.pagination {
		margin: 0 auto; 
		display: table; 
		text-align: center; 
		margin-bottom: 30px;
	}

	.pagination a {
		color: #555; 
		float: left; 
		padding: 8px 16px; 
		text-decoration: none; 
		transition: background-color 0.3s;
		background: #eee;
	}

	.pagination a.btn-mark {
		margin: 5px;
	}

	.pagination a.active {
		background: #008165;
		margin: 5px;
		color: white;
	}

	/* 페이징 스타일 */
	table tfoot ol.paging {
		margin: 0 auto;
		display: table;
		text-align: center;
		margin-bottom: 30px;
		list-style: none;
		padding: 0;
	}

	table tfoot ol.paging li {
		display: inline-block;
		margin: 5px;
	}

	table tfoot ol.paging li a,
	table tfoot ol.paging li.disable,
	table tfoot ol.paging li.now {
		color: #555;
		padding: 8px 16px;
		text-decoration: none;
		transition: background-color 0.3s;
		background: #eee;
		border-radius: 4px;
	}

	table tfoot ol.paging li.disable {
		background: #ddd;
		color: #bbb;
	}

	table tfoot ol.paging li a:hover {
		background: #ccc;
	}

	table tfoot ol.paging li.now {
		background: #008165;
		color: white;
		border: none;
	}
	
	table tfoot,
	table tfoot tr,
	table tfoot td,
	table tfoot ol.paging,
	table tfoot ol.paging li {
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
		<table id="faq-table" class="faq-table">
			<tbody>
				<c:choose>
					<c:when test="${empty faq_list}">
						<tr>
							<td colspan="2"><h3>FAQ가 없습니다.</h3></td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${faq_list}" var="k">
							<tr class="faq-question" onclick="toggleAnswer('answer${k.faqIdx}', 'btn${k.faqIdx}')">
								<td>${k.faqQuestion}</td>
								<td id="btn${k.faqIdx}" class="toggle-btn">∨</td>
							</tr>
							<tr class="faq-answer" id="answer${k.faqIdx}">
								<td colspan="2">${k.faqAnswer}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
			<tfoot>
				<tr>
					<td	colspan="4">
						<ol class="paging">
							<!-- 맨 첫 페이지로 -->
							<c:choose>
								<c:when test="${paging.nowPage == 1}">
									<li class="disable">&laquo;</li> <!-- 비활성화 상태 -->
								</c:when>
								<c:otherwise>
									<li><a href="/add_faq?cPage=1">&laquo;</a></li>
								</c:otherwise>
							</c:choose>
							<!-- 이전 -->
							<c:choose>
						   		<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
						   		    <li class="disable">&lsaquo;</li>
						   		</c:when>
						   		<c:otherwise>
						   			<li><a href="/add_faq?cPage=${paging.beginBlock - paging.pagePerBlock}">&lsaquo;</a></li>
						   		</c:otherwise>
						    </c:choose>
						    <!-- 블록안에 들어간 페이지번호들 -->
						    <c:forEach begin="${paging.beginBlock}" end="${paging.endBlock}" step="1" var="k">
						    	
						    	<%-- 현재페이지 (링크X)와 현재 페이지가 아닌 것을 구분하자. --%>
						    	<c:if test="${k == paging.nowPage }">
						    		<li class="now">${k}</li>
						    	</c:if>
						    	<c:if test="${k != paging.nowPage }">
						    		<li><a href="/add_faq?cPage=${k}">${k}</a></li>
						    	</c:if>
						    </c:forEach>
						    
							<!-- 다음 -->
							<c:choose>
						   		<c:when test="${paging.endBlock >= paging.totalPage }">
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
					</td>
				</tr>
			</tfoot>
		</table>
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
</div>
<br>
<br>
<br>
	<jsp:include page="../MAIN/footer.jsp" />
</body>
</html>
