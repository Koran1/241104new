<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList - 비밀번호 변경</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        height: 100vh;
        display: flex;
        flex-direction: column;
    }
    .main-container {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .changepw-container {
        width: 100%;
        max-width: 400px;
        background-color: #ffffff;
        padding: 20px 30px;
        border: 1px solid #eee;
        border-radius: 8px;
        box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
        color: #333;
    }
    h3 {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        color: #006a12;
        margin-bottom: 20px;
    }
    label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
    }
    .userpw, .userpw2 {
        margin-top: 20px;
    }
    input[type="password"] {
        width: 100%;
        padding: 15px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
        box-sizing: border-box;
    }
    input[type="password"]:focus {
        border-color: #008165;
        outline: none;
    }
    .span-subject {
        color: red;
        font-weight: bold;
    }
    .button-container {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-top: 20px;
    }
    .changPW_btn, .cancel_btn {
        width: 150px;
        padding: 10px 0;
        font-size: 16px;
        border-radius: 5px;
        cursor: pointer;
        border: none;
        text-align: center;
    }
    .changPW_btn {
        background-color: #008615;
        color: white;
    }
    .changPW_btn:disabled {
        background-color: #88B0AB;
        cursor: not-allowed;
    }
    .changPW_btn:hover:not(:disabled) {
        background-color: #006a12;
    }
    .cancel_btn {
        background-color: #008165;
        color: white;
    }
    .cancel_btn:hover {
        background-color: #02B08A;
    }
</style>
</head>
<body>
<jsp:include page="../MAIN/header.jsp" />
<div class="main-container">
    <div class="changepw-container">
        <form action="/mem_findPW_Change" method="post" name="findPwChangeForm">
            <h3 style="text-align: center; font-size: 22px; font-weight: bold; color: #006a12; margin-bottom: 22px;">
    			비밀번호 변경을 위해<br>새로운 비밀번호를 입력해 주세요.
			</h3>
            <div class="userpw" id="userpw">
                <label for="userPw"><span class="span-subject">*</span> 새 비밀번호</label>
                <input type="password" id="userPw" name="userPw" placeholder="새 비밀번호 입력" required>
                <div class="pw_regex" id="pw_regex"></div>
            </div>
            <div class="userpw2" id="userpw2">
                <label for="userPw2"><span class="span-subject">*</span> 새 비밀번호 확인</label>
                <input type="password" id="userPw2" name="userPw2" placeholder="(8~15문자, 영문자, 숫자, 특수문자 포함)" required>
                <div class="pw_equal" id="pw_equal"></div>
            </div>
            <!-- 버튼 영역 -->
            <div class="button-container">
                <input type="hidden" value="findPW_Change">
                <input type="submit" class="changPW_btn" id="changPW_btn" disabled value="변경">
                <button type="button" class="cancel_btn" onclick="location.href='/mem_login';">취소</button>
            </div>
        </form>
    </div>
</div>
<jsp:include page="../MAIN/footer.jsp" />
	<script type="text/javascript">
		// 비밀번호 정규식: 영문자, 숫자, 특수문자 포함 여부 체크
		const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,15}$/;

      // 비밀번호 유효성 검증 함수
       function validatePassword() {
           const pw = $("#userPw").val();
           const pwMsg = $("#pw_regex"); // 메시지 표시할 span

           if (!pwRegex.test(pw)) {
               pwMsg.html("비밀번호는 8~15자, 영문자, 숫자, 특수문자를 포함해야 합니다.").css("color", "red");
               return false;
           } else {
               pwMsg.html(""); // 조건 만족 시, 초기화
               return true;
           }
       }

       // 비밀번호 입력하는 곳에서 입력할 때마다 유효성 검증 수행
       $("#userPw").on("input", function() { 
           validatePassword();
       });


       // 비밀번호 확인 입력하는 곳에서 포커스 시 값 초기화 및 메세지 초기화
       $("#userPw2").on("focus", function() {
           $(this).val(""); // 비밀번호 확인 입력하는 곳 초기화
           $("#pw_equal").html(""); // 메세지 초기화
       });

       // 비밀번호 일치 여부
       function pwChkOk() {
           const pw1 = $("#userPw").val();
           const pw2 = $("#userPw2").val();
           const pwMsg = $("#pw_equal");

           if (pw1 && pw2) { // value가 모두 있을 때 메세지
               if (pw1 === pw2) {
                   if (validatePassword()) {
                       pwMsg.html("비밀번호가 일치합니다.").css("color", "green");
                       $("#changPW_btn").prop("disabled", false).css("background-color", "#008165"); // 버튼 활성화
                   } else{
                	   $("#changPW_btn").prop("disabled", true).css("background-color", "#88B0AB"); // 버튼 비활성화
                   }
               } else {
                   pwMsg.html("비밀번호가 일치하지 않습니다.").css("color", "red");
                   $("#changPW_btn").prop("disabled", true).css("background-color", "#88B0AB"); // 버튼 비활성화
               }
           } else {
               pwMsg.html(""); // value가 모두 없을 때 메세지 없음
               $("#changPW_btn").prop("disabled", true).css("background-color", "#88B0AB"); // 버튼 비활성화
           }
       }

       // 비밀번호 확인 입력하는 곳에 포커스 시 값 초기화
       $("#userPw2").on("focus", function() {
           $(this).val(""); // 비밀번호 확인 입력하는 곳 초기화
       });

       // 비밀번호 확인 입력하는 곳에서 블러 이벤트 시 일치 여부 확인
       $("#userPw, #userPw2").on("blur", function() {
           pwChkOk();
       });
	</script>
</body>
</html>