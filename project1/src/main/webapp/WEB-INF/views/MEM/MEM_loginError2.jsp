<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyTravelList - 로그인 에러</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
    let redirectToMain = "${redirectToMain}" === "true";
    let redirectToLogin = "${redirectToLogin}" === "true";

    if (redirectToMain) {
        alert("로그인 5회 이상 실패했습니다. 메인 화면으로 이동합니다.");
        location.href = "/"; // 메인 페이지로 리다이렉트
    } else if (redirectToLogin) {
        alert("아이디 또는 비밀번호가 맞지 않습니다. 다시 시도해 주세요.");
        location.href = "/mem_login"; // 로그인 페이지로 리다이렉트
    }
});
</script>
</head>
<body>
</body>
</html>