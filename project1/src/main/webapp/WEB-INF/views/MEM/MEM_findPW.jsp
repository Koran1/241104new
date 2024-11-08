<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList - 비밀번호 찾기</title>
<link type="text/css" href="/resources/css/style.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
    }
   	.main-container{
		margin: 0;
		padding-top: 100px;
		width: 100%;
		height: 90vh;
	}
    .logo-img {
        cursor: pointer;
    }
    .findpw-container {
        width: 50%;
        max-width: 400px;
        background-color: #ffffff;
        padding: 20px;
        margin: 50px auto;
    }
	
	.span-subject{
		color: red;
	}
	
    label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #333;
    }

    input[type="text"],
    input[type="email"],
    input[type="number"] {
        width: 100%;
        padding: 15px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    input[type="text"]:focus,
    input[type="email"]:focus {
        border-color: #008165;
        outline: none;
    }

    .button-container {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-top: 20px;
    }

    .findpw_btn, .cancel_btn {
        width: 150px;
        padding: 10px 0;
        font-size: 16px;
        border-radius: 5px;
        cursor: pointer;
        border: none;
        text-align: center;
    }

    .findpw_btn {
        background-color: #008615;
        color: white;
    }

    .findpw_btn:disabled {
        background-color: #88B0AB;
        cursor: not-allowed;
    }

    .findpw_btn:hover:not(:disabled) {
        background-color: #006a12;
    }

    .cancel_btn {
        background-color: #008165;
        color: white;
    }

    .cancel_btn:hover {
        background-color: #02B08A;
    }
    input[type="button"] {
		width: 100px;
		padding: 8px 0;
		font-size: 15px;
		border-radius: 5px;
		background-color: #008165;
		color: white;
		cursor: pointer;
		border: none;
		text-align: center;
	}
	input[type="button"]:hover {
		background-color: #02B08A;
	}
</style>
</head>
<body>
<jsp:include page="../MAIN/header.jsp" />
	<div class="main-container">

		<!-- 비밀번호 찾기 영역 -->
		<div class="findpw-container">
			<form action="/mem_findPW_OK" method="post" name="findPwForm">
				<div class="userid" id="userid">
					<label for="userId"><span class="span-subject">*</span> 아이디</label>
					<input type="text" id="userId" name="userId" placeholder="아이디 입력" required>
					<div class="id_chkMsg" id="id_chkMsg"></div>
				</div>

				<div class="email" id="email">
					<label for="userMail"><span class="span-subject">*</span> 이메일</label>
					<input type="email" id="userMail" name="userMail" placeholder="이메일 입력" required disabled>
					<input type="button" onclick="send_email()" value="이메일 전송" disabled style="background-color: #88B0AB;">
				</div>

				<div class="emailChk" id="emailChk">
					<label for="authNum"><span class="span-subject">*</span> 이메일 인증 번호</label>
					<input type="number"id="authNumber" name="authNumber" placeholder="인증번호(숫자만 입력)" maxlength="6" required disabled>
					<input type="button" onclick="authNum_chk()" value="확인" disabled style="background-color: #88B0AB;">
				</div>

				<!-- 버튼 영역 -->
				<div class="button-container">
					<input type="hidden" value="findPW">
					<input type="submit" class="findpw_btn" disabled value="비밀번호 찾기">
					<button type="button" class="cancel_btn" onclick="location.href='/mem_login';">취소</button>
				</div>
			</form>

			<c:if test="${not empty message}">
				<script type="text/javascript">
        			alert("${message}");
    			</script>
			</c:if>

			<!-- 5회 이상 실패 시 alert 및 리다이렉트 처리 -->
			<c:if test="${not empty script}">
				<c:out value="${script}" escapeXml="false" />
			</c:if>


			<script type="text/javascript">
				// 아이디 DB내에 있는 지 없는 지 유무 판단
				$("#userId").on("blur", function() {
					const userId = $(this).val();
					const id_chkMsg = $("#id_chkMsg");
					const sendEmailButton = $("input[type='button'][onclick='send_email()']");
					const emailField = $("#userMail");
					const authNumButton = $("input[type='button'][onclick='authNum_chk()']");
					const authNumberField = $("#authNumber");
					
					if (/^[a-zA-Z0-9]{6,10}$/.test(userId)) {
						$.ajax({
							url : "/mem_id_chk",
							data : {userId : userId},
							method : "post",
							dataType : "text",
							success : function(data) {
								console.log("서버 응답:", data);
								
								if (data == '1') {
									id_chkMsg.html("이메일 인증을 진행해 주세요.").css("color", "green");
									emailField.prop("disabled", false);
									sendEmailButton.prop("disabled", false).css("background-color", "#008165");
									authNumberField.prop("disabled", false);
									authNumButton.prop("disabled", false).css("background-color", "#008165");
								} else if (data == '0') {
									id_chkMsg.html("등록된 아이디가 없습니다.").css("color", "red");
									$("#userId").val('').focus();
									emailField.prop("disabled", true);
									sendEmailButton.prop("disabled", true).css("background-color", "#88B0AB");
									authNumberField.prop("disabled", true);
									authNumButton.prop("disabled", true).css("background-color", "#88B0AB");
								} else {
									id_chkMsg.html("아이디 존재 유무 확인 실패").css("color", "orange");
								}
							},
							error : function() {
								alert("아이디 존재 유무 확인 실패");
							}
						});
					} else {
						id_chkMsg.html("");
						emailField.prop("disabled", true);
						sendEmailButton.prop("disabled", true).css("background-color", "#88B0AB");
						authNumberField.prop("disabled", true);
						authNumButton.prop("disabled", true).css("background-color", "#88B0AB");
					}
				});
			
    			// 이메일 정규식 설정
    			const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    			let isEmailVerified = false;

    			$(document).ready(function() {
        			const sendEmailButton = $("input[type='button'][onclick='send_email()']");
        			const authNumButton = $("input[type='button'][onclick='authNum_chk()']");
        			const findPwButton = $(".findpw_btn");

        			$("#userMail").on("input", function() {
            			const userMail = $(this).val();

            			// 이메일 유효성 검사
            			if (emailRegex.test(userMail)) {
                			sendEmailButton.prop("disabled", false).css("background-color", "#008165");
            			} else {
                			sendEmailButton.prop("disabled", true).css("background-color", "#88B0AB");
                			authNumButton.prop("disabled", true).css("background-color", "#88B0AB");
            			}
            			enableFindPwButton();
        				});

        				// 아이디 인증번호 입력 시 아이디 찾기 버튼 활성화 여부 확인
        				$("#userId, #authNumber").on("input", enableFindPwButton);
    			});

    			function enableFindPwButton() {
        			const userId = $("#userId").val();
        			const userMail = $("#userMail").val();
        			const authNumber = $("#authNumber").val();
        			const findPwButton = $(".findpw_btn");

        			if (userId && userMail && authNumber && isEmailVerified) {
            			findPwButton.prop("disabled", false).css("background-color", "#008615");
        			} else {
            			findPwButton.prop("disabled", true).css("background-color", "#88B0AB");
        			}
    			}

    		function send_email() {
        		const userMail = document.getElementById("userMail").value;

        		if (!userMail) {
            		alert("이메일을 입력해주세요.");
            		return;
        		}

        		$.ajax({
            		url: "/send_email_code",
            		type: "POST",
            		data: { userMail: userMail },
            		success: function(response) {
                		alert("인증 이메일이 전송되었습니다. 이메일을 확인해 주세요.");
                		isEmailVerified = false;
                
                		$("input[type='button'][onclick='authNum_chk()']").prop("disabled", false).css("background-color", "#008165");
            		},
            		error: function() {
                		alert("이메일 전송에 실패했습니다. 다시 시도해 주세요.");
            		}
        		});
    		}

    		function authNum_chk() {
        		const authNumber = document.getElementById("authNumber").value;

        		if (!authNumber) {
            		alert("인증번호를 입력해 주세요.");
            		return;
        		}

        		$.ajax({
            		url: "/judge_code_match",
            		type: "POST",
            		data: { authNumber: authNumber },
            		success: function(response) {
                		if (response.status === "success") {
                    		alert(response.message);
                    		isEmailVerified = true;
                    		enableFindPwButton();
                		} else {
                    		alert(response.message);
                    		document.getElementById("authNumber").value = "";
                    		document.getElementById("authNumber").focus();
                    		isEmailVerified = false;
                    		$(".findpw_btn").prop("disabled", true).css("background-color", "#88B0AB");
                		}
            		},
            		error: function() {
                		alert("다시 시도해 주세요.");
            		}
        		});
    		}
		</script>
		</div>
	</div>
	<jsp:include page="../MAIN/footer.jsp" />
</body>
</html>