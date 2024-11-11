<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList - Q&A</title>
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
	.write-cotainer{
		display: flex;
		margin: 20px auto;
		width: 70%;
	}
	.write-cotainer > button{
		margin-left: auto;
		padding: 10px 30px;
		background-color: #02B08A;
		color: white;
		border: none;
		border-radius: 5px;
		cursor: pointer;
	}
	.qna-table{
		width: 70%;
		margin: 20px auto;
		border-collapse: collapse;
		border-top: 2px solid #708090;
	}
	th, td{
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
	.qnaSubject{
		text-align: left;
	}
	.qnaReg{
		width: 30%;
		text-align: center;
	}
	.subject-detail{
		text-decoration: none;
		color: black;
	}
	.subject-detail:hover{
		text-decoration: underline;
		color: #666666;
	}
	
	.qnaSubject, .qnaReg {
		padding: 10px;
	}
	.logo-img{
		cursor: pointer;
	}
	.qna-table th, td{
		padding: 10px;
		margin: 10px;
		text-align: center;
		font-weight: bold;
	}
	.pagination {
		margin: 0 auto ; 
		display: table; 
		text-align: center; 
		margin-bottom: 30px;
	}
	.pagination a {
		 color: #555; 
		 float: left; 
		 padding: 8px 16px; 
		 text-decoration: none; 
		 transition: background-color .3s;
		 background: #eee;
	}
	.pagination a.btn-mark{
		margin: 5px;
	}
	.pagination a.active {
		background: #008165;
		margin: 5px;
		color: white;
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
	
	table tfoot,
	table tfoot tr,
	table tfoot td {
		border-top: none !important;
		border-bottom: none !important;
	}
</style>
</head>
<body>
<jsp:include page="../MAIN/header.jsp" />
	<div class="main-container">
		<div class="tab-container">
			<ul class="tab-menu">
				<li class="tab-button"><a href="/add_notice" class="tab-notice-menu">공지사항</a></li>
				<li class="tab-button"><a href="/add_faq" class="tab-notice-menu">자주 묻는 질문</a></li>
				<li class="tab-button active"><a href="/add_qna" class="tab-notice-menu">나의 질문</a></li>
			</ul>
		</div>
		<div class="write-cotainer">
			<button class="write_btn" onclick="location.href='/add_qna_ask';">질문하기</button>
		</div>
		<div class="qna-container">
			<div id="qna-content" class="qna-content">
				<table id="qna-table" class="qna-table">
					<thead>
						<tr>
							<th>제목</th>
							<th class="qnaReg">등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty qna_list }">
								<tr>
									<td colspan="2"><h3>나의 문의 내역이 존재하지 않습니다.</h3></td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${qna_list }" var="k">
									<tr>
										<td class="qnaSubject"><a href="add_qna_detail?qnaIdx=${k.qnaIdx }" class="subject-detail">${k.qnaSubject }</a></td>
										<td class="qnaReg">${k.qnaReg.substring(0, 10) }</td>
									</tr>
									<c:if test="${not empty k.qnaReSubject }">
										<tr>
											<td class="qnaSubject"><a href="add_qna_detail_admin?qnaIdx=${k.qnaIdx }" class="subject-detail">
											&nbsp;&#8618;&nbsp;${k.qnaReSubject }</a></td>
											<td class="qnaReg">${k.qnaReRegdate != null ? k.qnaReRegdate.substring(0, 10) : '-'}</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4">
								<ol class="paging">
									<!-- 맨 첫 페이지로 -->
									<c:choose>
										<c:when test="${paging_qna.nowPage == 1}">
											<li class="disable">&laquo;</li>
											<!-- 비활성화 상태 -->
										</c:when>
										<c:otherwise>
											<li><a href="/add_qna?cPage=1">&laquo;</a></li>
										</c:otherwise>
									</c:choose>
									<!-- 이전 -->
									<c:choose>
										<c:when test="${paging_qna.beginBlock <= paging_qna.pagePerBlock }">
											<li class="disable">&lsaquo;</li>
										</c:when>
										<c:otherwise>
											<li><a
												href="/add_qna?cPage=${paging_qna.beginBlock - paging_qna.pagePerBlock}">&lsaquo;</a></li>
										</c:otherwise>
									</c:choose>
									<!-- 블록안에 들어간 페이지번호들 -->
									<c:forEach begin="${paging_qna.beginBlock}"
										end="${paging_qna.endBlock}" step="1" var="k">

										<%-- 현재페이지 (링크X)와 현재 페이지가 아닌 것을 구분하자. --%>
										<c:if test="${k == paging_qna.nowPage }">
											<li class="now">${k}</li>
										</c:if>
										<c:if test="${k != paging_qna.nowPage }">
											<li><a href="/add_qna?cPage=${k}">${k}</a></li>
										</c:if>
									</c:forEach>

									<!-- 다음 -->
									<c:choose>
										<c:when test="${paging_qna.endBlock >= paging_qna.totalPage }">
											<li class="disable">&rsaquo;</li>
										</c:when>
										<c:otherwise>
											<li><a
												href="/add_qna?cPage=${paging_qna.beginBlock + paging_qna.pagePerBlock}">&rsaquo;</a></li>
										</c:otherwise>
									</c:choose>

									<!-- 맨 마지막 페이지로 -->
									<c:choose>
										<c:when test="${paging_qna.nowPage == paging_qna.totalPage}">
											<li class="disable">&raquo;</li>
										</c:when>
										<c:otherwise>
											<li><a href="/add_qna?cPage=${paging_qna.totalPage}">&raquo;</a></li>
										</c:otherwise>
									</c:choose>
								</ol>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="../MAIN/footer.jsp" />
</body>
</html>