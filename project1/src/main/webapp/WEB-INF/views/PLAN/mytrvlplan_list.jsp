<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList - 여행계획관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="resources/css/admin.css" rel="stylesheet"/>
<style type="text/css">
#main_container{
	width: 100%;
}
#main_container table{
	width: 700px;
}
#main_container table thead th, #main_container table tbody td {
	border: 1px solid black;
	padding: 10px;
	text-align: center;
}
#main_container table tfoot td{
	padding: 10px;
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
#container{
	margin: 0;
	padding-top: 100px;
	width: 100%;
	height: 95vh;
}
</style>
</head>
<body>	

	<jsp:include page="../MAIN/header.jsp" />

    <div id="container">
        <div id="button_container">
            <button onclick="location.href='/mytrvlplan'">나의 관심지 관리</button>
            <button onclick="location.href='/mytrvlplan_create'">여행 계획 짜기</button>
            <button style="background-color:#008165; color: white; font-weight: bold;" onclick="location.href='/mytrvlplan_list'">여행 계획 관리</button>
        </div>

        <div id="main_container">
        	<table>
        		<thead>
        			<tr> <th>등록번호</th> <th>제목</th> <th>여행지역</th> <th>여행날짜</th> <th>등록날짜</th> </tr>
        		</thead>
        		<tbody>
					<c:choose>
						<c:when test="${empty list_user}">
							<tr><td colspan="5">여행 계획이 없습니다</td></tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="k" items="${list_user}" varStatus="c">
								<tr>
									<td>${plans_Paging.totalRecord - ((plans_Paging.nowPage-1)*plans_Paging.numPerPage + c.index)}</td>
									<td><a href="/mytrvlplan_list_detail?trvlPlanIdx=${k.trvlPlanIdx}">${k.trvlPlanSubject}</a></td>
									<td>${k.trvlPlanEtc01 } </td>
									<td>${k.trvlPlanDate } </td>
									<td>${k.trvlPlanRegDate } </td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
        		</tbody>
        		<tfoot>
				<tr>
					<td colspan="5">
					<ol class="paging">
						<!-- 이전 -->
						<c:choose>
							<c:when test="${plans_Paging.beginBlock <= plans_Paging.pagePerBlock}">
								<li class="disable">◀ 이전</li>
							</c:when>
							<c:otherwise>
								<li><a href="/mytrvlplan_list?intrst_cPage=${plans_Paging.beginBlock-plans_Paging.pagePerBlock}">◀ 이전</a></li>
							</c:otherwise>
						</c:choose>

						<!-- 블록안에 들어간 페이지번호들 -->
						<c:forEach begin="${plans_Paging.beginBlock}" end="${plans_Paging.endBlock}"
							step="1" var="k">
							<!-- 현재 페이지와 현재 페이지가 아닌 것을 구분하자 -->
							<c:if test="${k == plans_Paging.nowPage}">
								<li class="now">${k}</li>
							</c:if>
							<c:if test="${k != plans_Paging.nowPage}">
								<li><a href="/mytrvlplan_list?intrst_cPage=${k}">${k}</a></li>
							</c:if>
						</c:forEach>

						<!-- 다음 -->
						<c:choose>
							<c:when test="${plans_Paging.endBlock >= plans_Paging.totalPage}">
								<li class="disable">다음 ▶</li>
							</c:when>
							<c:otherwise>
								<%-- <li><a href="/bbs?cPage=${paging.beginBlock+paging.pagePerBlock}">다음으로</a></li> --%>
								<li><a href="/mytrvlplan_list?intrst_cPage=${plans_Paging.endBlock+1}">다음 ▶</a></li>
							</c:otherwise>
						</c:choose>
					</ol>
				</tr>
			</tfoot>
        	</table>
			
		    <br><br>
		    <button id="unlike-item">삭제에요</button>
		</div>

</div>
<jsp:include page="../MAIN/footer.jsp" />


</body>
</html>