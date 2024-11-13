<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList - 공지사항 검색</title>
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
	.noticeReg{
		width: 30%;
		text-align: center;
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
	.noticeSubject, .noticeReg {
		padding: 10px;
	}
	.logo-img{
		cursor: pointer;
	}
	.notice-table th, td{
		padding: 10px;
		margin: 10px;
		text-align: center;
		font-weight: bold;
	}
	    .pagination {
	        width: 50%;
	        margin: 20px auto;
	        text-align: center;
	    }
	    .pagination a {
	        color: #555;
	        display: inline-block;
	        padding: 6px 12px;
	        text-decoration: none;
	        transition: background-color .3s;
	        background: #eee;
	        border-radius: 3px;
	        margin: 0 2px;
	        font-size: 14px;
	    }
	    .pagination a.btn-mark {
	        margin: 0 5px;
	    }
	    .pagination a.active {
	        background: #008165;
	        color: white;
	        font-weight: bold;
	    }
	    .pagination a:hover {
	        background: #d9d9d9;
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
        display: block;
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
    	display: block;=
    	text-decoration: none;
    	color: inherit;
	}
</style>
</head>
<body>
<jsp:include page="../MAIN/header.jsp" />
	<div class="main-container">
		<div class="tab-container">
            <ul class="tab-menu">
                <li class="tab-button active"><a href="/add_notice" class="tab-notice-menu">공지사항</a></li>
                <li class="tab-button"><a href="/add_faq" class="tab-notice-menu">자주 묻는 질문</a></li>
                <li class="tab-button"><a href="/add_qna" class="tab-notice-menu">나의 질문</a></li>
            </ul>
        </div>

		<div class="search-container">
			<form action="/add_notice_search" onsubmit="return validateSearch_notice()">
				<input type="text" name="notice_keyword" value="${notice_keyword}">
				<button type="button" id="search_btn" onclick="noticeSearch(this.form)">검색</button>
			</form>
		</div>
		<script type="text/javascript">
			function validateSearch_notice() {
				var search = document.getElementsByName("notice_keyword")[0].value
						.trim();
				if (search === "") { 
					alert("검색어를 입력하세요.");
					return false;
				}
				return true;
			}
			function noticeSearch(f){
				f.submit();
			}
		</script>
		
		<div class="notice-container">
			<div id="notice-content" class="notice-content">
				<table id="notice-table" class="notice-table">
					<thead>
						<tr>
							<th>제목</th>
							<th class="noticeReg">작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty searchResults }">
								<tr>
									<td colspan="2" style="padding: 30px 0; text-align: center;"><h3 style="font-size: 25px; font-weight: bold;">검색 결과가 없습니다.</h3></td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${searchResults }" var="k">
									<tr>
										<td class="noticeSubject"><a href="/add_notice_detail?noticeIdx=${k.noticeIdx }" class="subject-detail">${k.noticeSubject }</a></td>
										<td class="noticeReg">${k.noticeReg.substring(0, 10)}</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
					<tfoot>
					</tfoot>
				</table>
			</div>

			<div class="pagination">
                <a class="btn-mark" href="#">&laquo;</a>
                <a class="btn-mark" href="#">&lsaquo;</a>
                <a class="btn-page active" href="#">1</a>
                <a class="btn-mark" href="#">&rsaquo;</a>
                <a class="btn-mark" href="#">&raquo;</a>
            </div>
		</div>
	</div>
    <jsp:include page="../MAIN/footer.jsp" />
</body>
</html>