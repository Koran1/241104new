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
	body{
		margin: 0;
		padding: 0;
	}
	.notice-table {
		width: 70%;
		margin: 20px auto;
		border-collapse: collapse;
		border-top: 2px solid #708090;
	}
	th,td{
		padding: 8px;
		text-align: center;
	}
	th{
		background-color: #f2f2f2;
	}
	tr td{
		border-bottom: 1px solid #ddd;
	}
	tr:last-child {
		border-bottom: 1px solid #ddd;
	}
	.noticeSubject {
		text-align: left;
	}
	.subject-detail {
		text-decoration: none;
		color: black;
	}
	.highlight {
		background-color: #99CC66;
	}
	.subject-detail:hover{
		text-decoration: underline;
		color: #666666;
	}
	.search-container {
    	width: 70%;
    	margin: 20px auto ;
    	display: flex;
    	align-items: center;
    	justify-content: flex-end;
	}
	.search-container input[type="text"] {
    	flex-grow: 4;
    	padding: 10px;
    	font-size: 16px;
    	border: 1px solid #ddd;
    	border-radius: 5px;
    	outline: none;
    	box-sizing: border-box;
    	min-width: 0;
	}
	.search-container button {
		margin-left: auto;
    	padding: 10px 20px;
    	font-size: 16px;
    	background-color: #008165;
    	color: white;
    	border: none;
    	border-radius: 5px;
    	margin-left: 10px;
    	cursor: pointer;
    	flex-shrink: 0;
    	transition: background-color 0.3s ease;
	}
	.search-container button:hover {
    	background-color: #007f3b;
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
	/* 페이징 스타일 */
	.paging-container ol.paging {
    	margin: 0 auto;
    	display: table;
    	text-align: center;
    	margin-bottom: 30px;
    	list-style: none;
    	padding: 0;
	}
	.paging-container ol.paging li {
    	display: inline-block;
    	margin: 5px;
	}
	.paging-container ol.paging li a,
	.paging-container ol.paging li.disable,
	.paging-container ol.paging li.now {
    	color: #555;
    	padding: 8px 16px;
    	text-decoration: none;
    	transition: background-color 0.3s;
    	background: #eee;
    	border-radius: 4px;
	}
	.paging-container ol.paging li.disable {
    	background: #ddd;
    	color: #bbb;
	}
	.paging-container ol.paging li a:hover {
    	background: #ccc;
	}
	.paging-container ol.paging li.now {
    	background: #008165;
    	color: white;
    	border: none;
	}
	.paging-container,
	.paging-container ol.paging,
	.paging-container ol.paging li {
    	border: none;
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
		
		<div class="tab-container">
            <ul class="tab-menu">
                <li class="tab-button active"><a href="/add_notice" class="tab-notice-menu">공지사항</a></li>
                <li class="tab-button"><a href="/add_faq" class="tab-notice-menu">자주 묻는 질문</a></li>
                <li class="tab-button"><a href="/add_qna" class="tab-notice-menu">나의 질문</a></li>
            </ul>
        </div>
        
       <div class="search-container">
			<form action="/add_notice_search" onsubmit="return validateSearch()">
				<input type="text" name="keyword" value="${keyword}">
				<button type="submit" id="search_btn">검색</button>
			</form>
		</div>
		<script type="text/javascript">
			function validateSearch() {
				var keyword = document.getElementsByName("keyword")[0].value
						.trim();
				if (keyword === "") {
					alert("검색어를 입력하세요.");
					return false;
				}
				return true;
			}
		</script>
		
		<div class="notice-container">
			<div id="notice-content" class="notice-content">
				<table id="notice-table" class="notice-table">
					<thead>
						<tr>
							<th>제목</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty notice_list2 }">
								<tr>
									<td colspan="2"><h3>공지사항이 없습니다.</h3></td>
								</tr>
							</c:when>
							<c:otherwise>
								<!-- 상단 고정 공지사항 -->
								<c:forEach items="${notice_list }" var="k">
									<tr>
										<td class="noticeSubject" style="background-color: #99CC99"><a href="/add_notice_detail?noticeIdx=${k.noticeIdx }" class="subject-detail">${k.noticeSubject }</a></td>
										<td class="noticeReg" style="background-color: #99CC99">${k.noticeReg.substring(0, 10)}</td>
									</tr>
								</c:forEach>
								<!-- 페이징된 공지사항 목록 -->
								<c:forEach items="${notice_list2 }" var="k">
									<tr>
										<td class="noticeSubject"><a href="/add_notice_detail?noticeIdx=${k.noticeIdx }" class="subject-detail">${k.noticeSubject }</a></td>
										<td class="noticeReg">${k.noticeReg.substring(0, 10)}</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div class="paging-container">
					<ol class="paging">
						<!-- 페이지네이션 코드 -->
						<!-- 맨 첫 페이지로 -->
						<c:choose>
							<c:when test="${pg.nowPage == 1}">
								<li class="disable">&laquo;</li>
							</c:when>
							<c:otherwise>
								<li><a href="/add_notice?cPage=1">&laquo;</a></li>
							</c:otherwise>
						</c:choose>

						<!-- 이전 페이지 블록으로 이동 -->
						<c:choose>
							<c:when test="${pg.beginBlock <= pg.pagePerBlock }">
								<li class="disable">&lsaquo;</li>
							</c:when>
							<c:otherwise>
								<li><a
									href="/add_notice?cPage=${pg.beginBlock - pg.pagePerBlock}">&lsaquo;</a></li>
							</c:otherwise>
						</c:choose>

						<!-- 현재 페이지 블록 내 페이지 번호들 -->
						<c:forEach begin="${pg.beginBlock}" end="${pg.endBlock}" var="k">
							<c:choose>
								<c:when test="${k == pg.nowPage}">
									<li class="now">${k}</li>
								</c:when>
								<c:otherwise>
									<li><a href="/add_notice?cPage=${k}">${k}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<!-- 다음 페이지 블록으로 이동 -->
						<c:choose>
							<c:when test="${pg.endBlock >= pg.totalPage }">
								<li class="disable">&rsaquo;</li>
							</c:when>
							<c:otherwise>
								<li><a
									href="/add_notice?cPage=${pg.beginBlock + pg.pagePerBlock}">&rsaquo;</a></li>
							</c:otherwise>
						</c:choose>

						<!-- 마지막 페이지로 이동 -->
						<c:choose>
							<c:when test="${pg.nowPage == pg.totalPage}">
								<li class="disable">&raquo;</li>
							</c:when>
							<c:otherwise>
								<li><a href="/add_notice?cPage=${pg.totalPage}">&raquo;</a></li>
							</c:otherwise>
						</c:choose>
					</ol>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
