<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin LoginPage</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background-color: white;
            padding: 40px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 300px;
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .login-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #008165;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .login-container input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
<script type="text/javascript">
	<c:if test="${!empty errorMsg}">
		alert("${errorMsg}")
	</c:if>
</script>
</head>
<body>
	<div class=login-container>
		<form action="/admin_index" method="post">
			<h2>Admin Login</h2>
			<label>ID : <input type="text" name="adminID" placeholder="아이디 입력" required></label>
			<br>
			<label>PW : <input type="password" name="adminPW" placeholder="패스워드 입력" required> </label>
			<input type="submit" value="로그인">
		</form>
	</div>
</body>
</html>