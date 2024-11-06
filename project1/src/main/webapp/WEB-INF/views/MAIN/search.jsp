<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>검색결과 페이지</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="resources/css/reset.css">
<style type="text/css">

/* 메인 레이아웃 */
.main_container {
	flex: 1;
	width: 100%;
	display: flex;
	justify-content: space-between;
	box-shadow: 0 0 3px #8f8f8f;
	text-align: left;
	padding-bottom: 50px;
}

.main_left {
	flex: 1 1 10%;
	margin-top: 110px;
}

.travel_result {
	margin-left: 155px;
	font-size: 24px;
	font-weight: bold;
	display: flex;
	gap: 50px;
}

#region-filter {
	width: 15%;
	text-align: center;
	border-radius: 20px;
}

.main_center {
	flex: 1 1 80%;
	margin-top: 105px;
}

/* 지역 선택 메뉴 */
.region_menu {
	width: 150px;
	height: 40px;
	text-align: center;
	border-radius: 5px;
	background-color: #ddf7d8;
	font-weight: bold;
}

/* 여행 박스 컨테이너 */
.main_wrapper {
	margin-left: 110px;
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
	gap: 40px;
	padding: 20px;
}

/* 여행 박스 */
.travel_box {
	width: 300px;
	height: 390px;
	/* border: 1px solid #7bbe6e; */
	border-radius: 12px;
	overflow: hidden;
	text-align: center;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	padding: 8px;
	box-shadow: 1px 1px 1px 0 gray;
}

/* 여행 이미지 */
.travel_image {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
	min-height: 250px;
	overflow: hidden;
	border-radius: 5px;
}

.travel_image img {
    max-width: 282px;
    height: 250px;
    object-fit: cover;
    border-radius: 8px;
}

/* 여행 정보 */
.travel_info {
	width: 100%;
	height: 147px;
	text-align: left;
	padding-left: 10px;
	display: flex;
	flex-direction: column;
	padding-top: 10px;
}


.travel_location_title {
	font-size: 20px;
	margin-bottom: 12px;
	font-weight: bold;
	color: rgba(100, 50, 15, 10);
}

.travel_location_addr, .travel_location_phone {
	font-size: 17px;
	margin-bottom: 12px;
}

/* 오른쪽 영역 */
.main_right {
	flex: 1 1 10%;
}

.paging {
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto;
	gap: 30px;
	font-size: 20px;
	font-weight: bold;
	color: gray;
	padding-right: 30px;
	list-style-type: none;
	margin-left: 60px;
}
.disable{color: lightgray;}
.now{color: black;}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	
	<% String userId = (String) session.getAttribute("userId"); %>	

	<!-- 메인 컨텐츠 -->
	<!-- main -->
	<div class="main_container">
		<div class="main_left"></div>

		<div class="main_center">
			<div class="travel_result">
				<p>검색결과: ${keyword} ${count}건</p>
				<br> <select id="region-filter" onchange="filterByRegion()">
				    <option value="0" ${region == '' ? 'selected' : ''}>:: 전체 ::</option>
				    <option value="1" ${region == '1' ? 'selected' : ''}>서울</option>
				    <option value="2" ${region == '2' ? 'selected' : ''}>부산</option>
				    <option value="3" ${region == '3' ? 'selected' : ''}>대구</option>
				    <option value="4" ${region == '4' ? 'selected' : ''}>인천</option>
				    <option value="5" ${region == '5' ? 'selected' : ''}>광주</option>
				    <option value="6" ${region == '6' ? 'selected' : ''}>대전</option>
				    <option value="7" ${region == '7' ? 'selected' : ''}>울산</option>
				    <option value="8" ${region == '8' ? 'selected' : ''}>경기</option>
				    <option value="9" ${region == '9' ? 'selected' : ''}>강원</option>
				    <option value="10" ${region == '10' ? 'selected' : ''}>충북</option>
				    <option value="11" ${region == '11' ? 'selected' : ''}>충남</option>
				    <option value="12" ${region == '12' ? 'selected' : ''}>전북</option>
				    <option value="13" ${region == '13' ? 'selected' : ''}>전남</option>
				    <option value="14" ${region == '14' ? 'selected' : ''}>경북</option>
				    <option value="15" ${region == '15' ? 'selected' : ''}>경남</option>
				    <option value="16" ${region == '16' ? 'selected' : ''}>제주</option>
				</select>
			</div>
			<c:choose>
				<c:when test="${empty list}">
					<h2>검색 결과가 존재하지 않습니다</h2>
				</c:when>
				<c:otherwise>
					<section class="searchs">
						<div class="main_wrapper">
							<c:forEach var="k" items="${list}">
								<div class="travel_box" data-category="${k.region}">
									<div class="travel_image">
										<a href="/travelDetail_go?travelIdx=${k.travelIdx}"> 
										<img alt="관광지 이미지" src="${k.placeImg01}"></a>
									</div>
									<div class="travel_info">
										<p class="travel_location_title">${k.trrsrtNm}</p>
										<c:choose>
											<c:when test="${empty k.rdnmadr}">
												<p class="travel_location_addr">${k.lnmadr}</p>
											</c:when>
											<c:otherwise>
												<p class="travel_location_addr">${k.rdnmadr}</p>
											</c:otherwise>
										</c:choose>
										<p class="travel_location_phone">☎: ${k.phoneNumber}</p>
									</div>
								</div>
							</c:forEach>
						</div>
					</section>
				</c:otherwise>
			</c:choose>

			<div class="paging">
				<!-- 이전 버튼 -->
				<c:choose>
					<c:when test="${paging.beginBlock <= paging.pagePerBlock}">
						<div class="disable">◀ 이전</div>
					</c:when>
					<c:otherwise>
						<div>
							<a href="/search_go?cPage=${paging.beginBlock - paging.pagePerBlock}&keyword=${keyword}&region=${region}">◀이전</a>
						</div>
					</c:otherwise>
				</c:choose>
				<!-- 페이지번호 -->
				<c:forEach begin="${paging.beginBlock}" end="${paging.endBlock}" step="1" var="k">
					<!-- 현재 페이지 (링크x)와 현재 페이지가 아닌 것을 구분하자 -->
					<c:if test="${k == paging.nowPage}">
						<li class="now">${k}</li>
					</c:if>
					<c:if test="${k != paging.nowPage}">
						<li><a href="/search_go?cPage=${k}&keyword=${keyword}&region=${region}">${k}</a></li>
					</c:if>
				</c:forEach>
				<!-- 다음 버튼 -->
				<c:choose>
					<c:when test="${paging.endBlock >= paging.totalPage}">
						<div class="disable">다음 ▶</div>
					</c:when>
					<c:otherwise>
						<div>
							<a href="/search_go?cPage=${paging.beginBlock + paging.pagePerBlock}&keyword=${keyword}&region=${region}">다음▶</a>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<div class="main_right">
			<jsp:include page="scroll.jsp" />
		</div>
	</div>

	<jsp:include page="footer.jsp" />
	
	<script type="text/javascript">
		function filterByRegion() {
		    const regionSelect = document.getElementById("region-filter");
		    const region = regionSelect.value;
		    const keyword = "${keyword}"; // 기존 검색어 유지
	
		    // URL 파라미터로 안전하게 전달
		    location.href = "/search_go?keyword=" + encodeURIComponent(keyword) + "&region=" + encodeURIComponent(region);
		}
	</script>
	
</body>
</html>