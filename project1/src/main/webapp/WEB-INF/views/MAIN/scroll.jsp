<%@ page contentType="text/html; charset=UTF-8" language="java"%>
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
/* 스크롤 탑 버튼 */
.scroll-top-btn {
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 50px; /* 아이콘 너비 */
    height: 50px; /* 아이콘 높이 */
    background-image: url('resources/images/top.png');
    background-size: contain;
    background-repeat: no-repeat;
    cursor: pointer;
    border: none;
    background-color: white;
    display: none;
}
</style>
</head>
<body>
	<button class="scroll-top-btn" id="scrollTopBtn" onclick="scrollToTop()"><img alt="Top" src="resources/images/top.png"></button>
	
	<script type="text/javascript">
		function scrollToTop() {
			window.scrollTo({
				top : 0,
				behavior : 'smooth'
			});
		}
		 // 페이지 로드 시 초기 버튼 가시성 설정
        document.addEventListener('DOMContentLoaded', function() {
            const scrollTopBtn = document.getElementById('scrollTopBtn');
            if (window.scrollY === 0) { // 페이지 로드 시 최상단에 있는 경우
                scrollTopBtn.style.display = 'none'; // 버튼 숨김
            }
        });

        // 스크롤 이벤트 리스너 추가
        window.addEventListener('scroll', function() {
            const scrollTopBtn = document.getElementById('scrollTopBtn');
            if (window.scrollY > 50) {  // 스크롤이 100px 이상 내려갔을 때만 버튼 표시
                scrollTopBtn.style.display = 'block';
            } else {
                scrollTopBtn.style.display = 'none'; // 최상단에 있을 때는 숨김
            }
        });
	</script>
</body>
</html>