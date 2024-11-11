<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Main</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="resources/css/admin.css" rel="stylesheet"/>
<style type="text/css">
	#main_container button{
		width: 100%;
		padding: 10px 20px;
		width: 150px;
	}
	
	#main_container button:hover{
		background-color: black;
		color: white;
		font-weight: bold;
	}
	#main_container .main_button{
		display: flex;
		justify-content: flex-end;
		width: 100%;
		margin: 20px 0;
	}
	    	/* paging */
table tfoot ol.paging {
	list-style: none;
}

table tfoot ol.paging li {
	float: left;
	margin-right: 8px;
}

table tfoot ol.paging li a {
	display: block;
	padding: 3px 7px;
	border: 1px solid #00B3DC;
	color: #2f313e;
	font-weight: bold;
}

table tfoot ol.paging li a:hover {
	background: #00B3DC;
	color: white;
	font-weight: bold;
}

.disable {
	padding: 3px 7px;
	border: 1px solid silver;
	color: silver;
}

.now {
	padding: 3px 7px;
	border: 1px solid #ff4aa5;
	background: #ff4aa5;
	color: white;
	font-weight: bold;
}
</style>
</head>
<body>
	<div id="header">
		<img id="logo" alt="logo" src="../resources/images/logo.png" onclick='location.href ="/admin_index"'>
		<h2>ADMIN</h2>
	 </div>
	 
	 <div id="container">
		<div id="button_container">
			<button onclick='location.href ="/admin_members"'>회원정보관리</button>
			<button onclick='location.href ="/admin_notice"'>공지사항관리</button>
			<button onclick='location.href ="/admin_faq"'>FAQ관리</button>
			<button onclick='location.href ="/admin_qa"'>Q&A관리</button>
			<button style="color: red" onclick='location.href ="/admin_main"'>게시판관리</button>
		</div>
	
		<div id="main_container">
			<div class="main_button"><button onclick='location.href ="/admin_main_create"'>작성하기</button></div>
			<table id="table">
				<thead>
					<tr>
						<th>Index번호</th><th>관광지명</th><th>최신화날짜</th><th>지역</th>
					</tr>
				</thead>
				<tbody id="data">
				<c:choose>
					<c:when test="${empty main_list}">
						<td colspan="4">표기할 정보가 없습니다</td>
					</c:when>
					<c:otherwise>
						<c:forEach var="k" items="${main_list}">
							<tr>
								<td>${k.travelIdx}</td>
								<td><a href="/admin_main_update?travelIdx=${k.travelIdx}">${k.trrsrtNm}</a></td>
								<td>${k.referenceDate}</td>
								<td>${k.touritEtc01}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				</tbody>
				<tfoot>
				<tr>
					<td colspan="4">
						<ol class="paging">
							<!-- 이전 -->
							<c:choose>
								<c:when test="${main_Paging.beginBlock <= main_Paging.pagePerBlock}">
									<li class="disable">◀ 이전</li>
								</c:when>
								<c:otherwise>
									<li><a
										href="/admin_main?main_cPage=${main_Paging.beginBlock-main_Paging.pagePerBlock}">◀ 이전</a></li>
								</c:otherwise>
							</c:choose>

							<!-- 블록안에 들어간 페이지번호들 -->
							<c:forEach begin="${main_Paging.beginBlock}" end="${main_Paging.endBlock}"
								step="1" var="k">
								<!-- 현재 페이지와 현재 페이지가 아닌 것을 구분하자 -->
								<c:if test="${k == main_Paging.nowPage}">
									<li class="now">${k}</li>
								</c:if>
								<c:if test="${k != main_Paging.nowPage}">
									<li><a href="/admin_main?main_cPage=${k}">${k}</a></li>
								</c:if>
							</c:forEach>

							<!-- 다음 -->
							<c:choose>
								<c:when test="${main_Paging.endBlock >= main_Paging.totalPage}">
									<li class="disable">다음 ▶</li>
								</c:when>
								<c:otherwise>
									<li><a href="/admin_main?main_cPage=${main_Paging.endBlock+1}">다음 ▶</a></li>
								</c:otherwise>
							</c:choose>
						</ol>
					</td>
				</tr>
			</tfoot>
				
			</table>
		</div>
	</div>
	
	<script type="text/javascript">
	
	
	</script>
</body>
</html>