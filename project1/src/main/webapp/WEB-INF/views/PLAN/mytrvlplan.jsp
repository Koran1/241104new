<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList - Plan</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="resources/css/admin.css" rel="stylesheet" />
<style type="text/css">
.image-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 20px;
	margin-top: 10px;
}

.image-item {
	text-align: center;
	border: 2px solid #008165;
	border-radius: 8px;
	padding: 5px;
	width: 200px;
	height: 200px;
}

/* Hide items with display: none smoothly */
.image-item {
	transition: opatest2 0.3s ease;
}

.image-item img {
	width: 80%;
	height: 80%;
}
.image-item:hover{
	border: 5px solid pink;
}

/* paging */
ol.paging {
	list-style: none;
}

ol.paging li {
	float: left;
	margin-right: 8px;
}

ol.paging li a {
	display: block;
	padding: 3px 7px;
	border: 1px solid #00B3DC;
	color: #2f313e;
	font-weight: bold;
}

ol.paging li a:hover {
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
			<button style="background-color:#008165; color: white; font-weight: bold;" onclick="location.href='/mytrvlplan'">나의
				관심지 관리</button>
			<button onclick="location.href='/mytrvlplan_create'">여행 계획
				짜기</button>
			<button onclick="location.href='/mytrvlplan_list'">여행 계획 관리</button>
		</div>

		<div id="main_container">
			<select id="region-filter">
				<option value="all">All</option>
				<option value="1">서울</option>
				<option value="2">부산</option>
				<option value="3">대구</option>
				<option value="4">인천</option>
				<option value="5">광주</option>
				<option value="6">대전</option>
				<option value="7">울산</option>
				<option value="8">경기</option>
				<option value="9">강원</option>
				<option value="10">충북</option>
				<option value="11">충남</option>
				<option value="12">전북</option>
				<option value="13">전남</option>
				<option value="14">경북</option>
				<option value="15">경남</option>
				<option value="16">제주</option>
			</select>

			<form action="/mytrvlplan_unlike" method="post" style="display: inline;">
				<div class="image-grid">
					<c:choose>
						<c:when test="${empty list_trvlfav_paged}">
							<h2>자료가 존재하지 않습니다</h2>
						</c:when>
						<c:otherwise>
						<c:forEach var="k" items="${list_trvlfav_paged}">
							<div class="image-item" data-category="${k.region}" data-idx="${k.travelIdx}">
								<img src="${k.placeImg01}" alt="test1">
								<p><input type="checkbox" name="travelIdx" value="${k.travelIdx}">
								<a href="/travelDetail_go?travelIdx=${k.travelIdx}">${k.trrsrtNm}</a></p>
							</div>
						</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				<br>
				<div>
					<ol class="paging">
						<!-- 이전 -->
						<c:choose>
							<c:when test="${intrst_Paging.beginBlock <= intrst_Paging.pagePerBlock}">
								<li class="disable">◀ 이전</li>
							</c:when>
							<c:otherwise>
								<li><a href="/mytrvlplan?intrst_cPage=${intrst_Paging.beginBlock-intrst_Paging.pagePerBlock}">◀ 이전</a></li>
							</c:otherwise>
						</c:choose>

						<!-- 블록안에 들어간 페이지번호들 -->
						<c:forEach begin="${intrst_Paging.beginBlock}" end="${intrst_Paging.endBlock}"
							step="1" var="k">
							<!-- 현재 페이지와 현재 페이지가 아닌 것을 구분하자 -->
							<c:if test="${k == intrst_Paging.nowPage}">
								<li class="now">${k}</li>
							</c:if>
							<c:if test="${k != intrst_Paging.nowPage}">
								<li><a href="/mytrvlplan?intrst_cPage=${k}">${k}</a></li>
							</c:if>
						</c:forEach>

						<!-- 다음 -->
						<c:choose>
							<c:when test="${intrst_Paging.endBlock >= intrst_Paging.totalPage}">
								<li class="disable">다음 ▶</li>
							</c:when>
							<c:otherwise>
								<%-- <li><a href="/bbs?cPage=${paging.beginBlock+paging.pagePerBlock}">다음으로</a></li> --%>
								<li><a href="/mytrvlplan?intrst_cPage=${intrst_Paging.endBlock+1}">다음 ▶</a></li>
							</c:otherwise>
						</c:choose>
					</ol>
				</div>
			<br><br>
			<button id="unlike-item" onclick="unlikeItem()" type="button">관심해제</button>
			</form>
		</div>

	</div>
<jsp:include page="../MAIN/footer.jsp" />
	<script type="text/javascript">
		document.getElementById('region-filter').addEventListener('change', function () {
		    const selectedCategory = this.value;
		    const imageItems = document.querySelectorAll('.image-item');
		    imageItems.forEach((item) => {
		        const itemCategory = item.getAttribute('data-category');
		        if (selectedCategory === 'all' || itemCategory === selectedCategory) {
		            item.style.display = 'block';
		        } else {
		            item.style.display = 'none';
		        }
	    	});
		});
		
		document.querySelectorAll('.image-item').forEach(item => {
            item.addEventListener('click', function (e) {
                if (e.target.tagName !== 'INPUT') {
                    const checkbox = this.querySelector('input[type="checkbox"]');
                    checkbox.checked = !checkbox.checked;
                }
            });
        });
		
		function unlikeItem() {
			const selectedItems = document.querySelectorAll('.image-item input[type="checkbox"]:checked');
			const travelIdxes = Array.from(selectedItems).map(item=>
				item.closest('.image-item').getAttribute('data-idx'));
			if(travelIdxes.length === 0){
				alert('관심 해제할 항목을 선택하세요.');
		        return;
			}
			const query = travelIdxes.map(item => "travelIdx="+item).join('&');
			location.href = "/mytrvlplan_unlike?"+query;
		}
	</script>

</body>
</html>