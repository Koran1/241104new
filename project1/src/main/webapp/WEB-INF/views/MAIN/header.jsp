<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>MyTravelList</title>
        <style type="text/css">
    header{ 
    	width: 100%;
    	position: fixed;
    	background-color: white;
    	z-index: 1000;
    	padding-left: 20px;
    }
    </style>
    <link rel="canonical" href="https://getbootstrap.kr/docs/5.3/examples/headers/">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

  </head>
  <body>
	<main>
	  <header class="p-3 mb-3 border-bottom">
	    <div class="container">
	      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
	        <a href="/main_go" class="d-flex align-items-center mb-2 mb-lg-0 link-body-emphasis text-decoration-none">
	          <svg class="bi me-2" width="40" height="32" role="img" aria-label="HOME">
	          <img src="/resources/images/logo.png" width="220"></svg>
	        </a>
	        
	        <!-- 검색  -->
	        <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search" action="/search_go" method="get" autocomplete="on" onsubmit="return validateSearch()">
	          <input type="search" class="form-control" placeholder="여행 검색" aria-label="Search" name="keyword" value="${keyword}">
	        </form>
	        
	        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
	          <li><a href="/add_notice" class="nav-link px-2 link-body-emphasis" style="font-size:18px; font-weight:bold;"><b>공지사항</b></a></li>
				<c:choose>
				 <c:when test="${empty userId}">
	          		<li><a href="/mem_login" class="nav-link px-2 link-body-emphasis" style="font-size:18px; font-weight:bold;"><b>여행계획</b></a></li>
				 </c:when>
				 <c:otherwise>
				   	<li><a href="/mytrvlplan" class="nav-link px-2 link-body-emphasis" style="font-size:18px; font-weight:bold;"><b>여행계획</b></a></li>
				 </c:otherwise>
				</c:choose>
	        </ul>

		<!-- 세션에 저장된 id를 불러옴 -->
		<% String userId = (String) session.getAttribute("userId"); %>	

	        <div class="dropdown text-end">
			        <a href="/go_my_page" class="d-block link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
			            <img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle">
			        </a>
			        <ul class="dropdown-menu text-small">
	            <c:choose>
				 <c:when test="${empty userId}">
	            		<li><a class="dropdown-item" href="/mem_login">Sign in</a></li>
	             </c:when>
				 <c:otherwise>
			            <li><a class="dropdown-item" href="/go_my_page">My Page</a></li>
			            <li><hr class="dropdown-divider"></li>
					 	<li><a class="dropdown-item" href="/mem_logout">Sign out</a></li>
				 </c:otherwise>
				</c:choose>
	          </ul>
	        </div>
	      </div>
	    </div>
	  </header>
	</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script type="text/javascript">
    function validateSearch() {
        const keyword = document.querySelector("input[name='keyword']").value.trim();
        if (keyword === "") {
            alert("검색어를 입력하세요");
            return false; // 폼 제출 중단
        }
        return true; // 폼 제출 진행
    }
</script>
</body>
</html>