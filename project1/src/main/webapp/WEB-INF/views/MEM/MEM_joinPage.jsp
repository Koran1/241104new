<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - MyTravelList</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
	.join-container {
		width: 50%;
		margin: 50px auto;
		padding: 20px;
	}
	.logo-img {
		cursor: pointer;
	}
	.join-table, .region-table {
        width: 70%;
        margin: 50px auto;
        border-collapse: separate;
        border-spacing: 15px 15px;
    }
	.join-table td {
		padding: 5px 0px; 
	}
	table input[type="text"], input[type="password"], input[type="email"], input[type="button"], input[type="number"] {
		width: 70%;
		padding: 10px;
	}
	.span-subject{
		color: red;
	}
	.select-area {
		text-align: center;
		margin-top: 20px;
	}
	.select-area div {
		display: inline-block;
		margin: 5px;
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
	#region-title{
		text-align: left;
	}
	.region-table td {
		text-align: center;
		padding: 10px;
	}
	.region-table label {
		display: inline-block;
		width: 100%;
		padding: 10px 15px;
		background-color: #f5f5f5;
		border: 1px solid #ccc;
		border-radius: 5px;
		cursor: pointer;
		font-weight: bold;
		font-size: 0.9em;
		transition: background-color 0.3s;
	}
	.region-table label:hover {
		background-size: #B7F0B1;
	}
	.region-table input[type="checkbox"] {
		display: none;
	}
	.region-table input[type="checkbox"]:checked + label {
		background-color: #02B08A;
		color: white;
		border-color: #02B08A;
	}
	.button-container {
    	display: flex;
    	justify-content: center;
    	flex-direction: row;
    	gap: 20px;
    	margin-top: 30px;
	}
	.join_btn, .cancel_btn {
	    width: 150px;
	    padding: 10px 0;
	    font-size: 16px;
	    border-radius: 5px;
	    cursor: pointer;
	    border: none;
	    text-align: center;
	}
	.join_btn {
		background-color: #008615;
		color: white;
	}
	.join_btn:disabled {
		background-color: #88B0AB;
		cursor: pointer;
	}
	.join_btn:hover:not(:disabled) {
		background-color: #006a12;
	}
	.cancel_btn {
		background-color: #008165;
		color: white;
	}
	.cancel_btn:hover {
		background-color: #02B08A;
	}
	#emailSelection {
    	display: block !important;
    	visibility: visible !important;
    	opacity: 1 !important;
    	height: auto !important;
    	margin-top: 10px;
	}
</style>
</head>
<body>
<jsp:include page="../MAIN/header.jsp" />
	<div class="main-container">
		<div class="join-container">
			<c:if test="${not empty message}">
                <p style="color: red; text-align: center;">${message}</p>
            </c:if>
			<form action="/mem_joinPage_OK" method="post" name="joinForm">
				<table id="join-table" class="join-table">
					<tbody>
						<!-- 이름 -->
						<tr>
							<td><label for="userName"><span class="span-subject">*</span> 이름</label></td>
							<td><input type="text" id="userName" name="userName" placeholder="이름 입력" required></td>
						</tr>
						
						<!-- 아이디 -->
						<tr>
							<td><label for="userId"><span class="span-subject">*</span> 아이디</label></td>
							<td>
								<input type="text" id="userId" name="userId" placeholder="아이디 입력(6~10자, 영문자, 숫자 포함)" required>
								<div class="id_chkMsg" id="id_chkMsg"></div>
							</td>
						</tr>
						
						<!-- 전화번호 -->
						<tr>
							<td><label for="userPhone"><span class="span-subject">*</span> 전화번호</label></td>
							<td>
								<input type="text" id="userPhone" name="userPhone" placeholder="전화번호 입력" required>
								<input type="button" onclick="phone_chk()" value="중복 검사" disabled style="background-color: #88B0AB;">
								<div class="phone_chkMsg" id="phone_chkMsg"></div>
								<div id="emailSelection"></div>
							</td>
						</tr>
						<!-- 비밀번호 -->
						<tr>
							<td><label for="userPw"><span class="span-subject">*</span> 비밀번호</label></td>
							<td>
								<input type="password" id="userPw" name="userPw" placeholder="비밀번호 입력" required>
								<div class="pw_regex" id="pw_regex"></div>
							</td>
						</tr>
						
						<!-- 비밀번호 확인 -->
						<tr>
							<td><label for="userPw2"><span class="span-subject">*</span> 비밀번호 확인</label></td>
							<td>
								<input type="password" id="userPw2" name="userPw2" placeholder="(8~15문자, 영문자, 숫자, 특수문자 포함)" required>
								<div class="pw_equal" id="pw_equal"></div>
							</td>
						</tr>
						
						
						<!-- 이메일 -->
						<tr>
							<td><label for="userMail"><span class="span-subject">*</span> 이메일</label></td>
							<td>
								<input type="hidden" name="userChk" value="0" id="userChk">
								<input type="email" id="userMail" name="userMail" placeholder="이메일 입력" required>
								<input type="button" onclick="send_email()" value="이메일 전송" disabled style="background-color: #88B0AB;">
								<div class="mail_chkMsg" id="mail_chkMsg"></div>
								<input type="hidden" id="selectedEmail" name="userMail">
							</td>
						</tr>
						<tr>
							<td><label><span class="span-subject">*</span> 이메일 인증 번호</label></td>
							<td>
								<input type="number" id="authNumber" name="authNumber" placeholder="인증번호" maxlength="6" required>
								<input type="button" onclick="authNum_chk()" value="확인" disabled style="background-color: #88B0AB;">
							</td>
						</tr>
						
						<!-- 주소 -->
						<tr>
							<td><label for="userAddr"><span class="span-subject">*</span> 주소</label></td>
							<td>
								<input type="text" id="userAddr" name="userAddr" placeholder="주소 입력" readonly required>
								<input type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기">
							</td>
						</tr>
					</tbody>
				</table>
				 
				<!-- 관심지 -->
				<table class="region-table">
					<tbody>
						<tr>
							<td id="region-title"><span class="span-subject">*</span> 관심지</td>
						</tr>
						<tr>
							<td>
								<input type="checkbox" name="userFavor" value="1" id="1">
								<label for="1">서울특별시</label>
							</td>
							<td>
								<input type="checkbox" name="userFavor" value="2" id="2">
								<label for="2">부산광역시</label>
							</td>
							<td>
								<input type="checkbox" name="userFavor" value="3" id="3">
								<label for="3">대구광역시</label>
							</td>
						</tr>
						<tr>
							<td>
								<input type="checkbox" name="userFavor" value="4" id="4">
								<label for="4">인천광역시</label>
							</td>
							<td>
								<input type="checkbox" name="userFavor" value="5" id="5">
								<label for="5">광주광역시</label>
							</td>
							<td>
								<input type="checkbox" name="userFavor" value="6" id="6">
								<label for="6">대전광역시</label>
							</td>
						</tr>
						<tr>
							<td>
								<input type="checkbox" name="userFavor" value="7" id="7">
								<label for="7">울산광역시</label>
							</td>
							<td>
								<input type="checkbox" name="userFavor" value="8" id="8">
								<label for="8">경기도</label>
							</td>
							<td>
								<input type="checkbox" name="userFavor" value="9" id="9">
								<label for="9">강원도</label>
							</td>
						</tr>
						<tr>
							<td>
								<input type="checkbox" name="userFavor" value="10" id="10">
								<label for="10">충청북도</label>
							</td>
							<td>
								<input type="checkbox" name="userFavor" value="11" id="11">
								<label for="11">충청남도</label>
							</td>
							<td>
								<input type="checkbox" name="userFavor" value="12" id="12">
								<label for="12">전라북도</label>
							</td>
						</tr>
						<tr>
							<td>
								<input type="checkbox" name="userFavor" value="13" id="13">
								<label for="13">전라남도</label>
							</td>
							<td>
								<input type="checkbox" name="userFavor" value="14" id="14">
								<label for="14">경상북도</label>
							</td>
							<td>
								<input type="checkbox" name="userFavor" value="15" id="15">
								<label for="15">경상남도</label>
							</td>
						</tr>
						<tr>
							<td>
								<input type="checkbox" name="userFavor" value="16" id="16">
								<label for="16">제주도</label>
							</td>
						</tr>
					</tbody>
				</table>
				
				<input type="hidden" name="userFavor01">
				<input type="hidden" name="userFavor02">
				<input type="hidden" name="userFavor03">

- 				<div class="button-container">
					<div class="join-ok-button" id="join-ok-button">
						<!--<input type="hidden" name="이름" value="서버로 넘길 값"/>-->
						<input type="hidden" name="join_OK" value="join_OK">
						<!--추가로 위 필드 모두 입력과 조건 만족 시에 회원가입 버튼 활성화하는 코드 추가해야함-->
						<input type="submit" class="join_btn" disabled value="회원가입">
					</div>
					<div class="cancel-button">
						<button type="button" class="cancel_btn" onclick="location.href='/';">취소</button>
					</div>
				</div>
			</form>
		</div>
		<jsp:include page="../MAIN/footer.jsp" />
		<!-- 아이디, 비밀번호 스크립트 -->
		<script type="text/javascript">
		// 아이디 정규식(6~10자, 영문자, 숫자 포함 여부 체크)
		$("#userId").on("keyup", function() {
		    const userId = $(this).val();
		    const idchkMsg = $("#id_chkMsg");

		    // 영문자와 숫자로만 구성되어 있는지 확인하는 정규 표현식
		    const isValidFormat = /^[a-zA-Z0-9]+$/.test(userId);

		    if (userId.length < 6 || userId.length > 10) {
		    	idchkMsg.html("아이디는 6자 이상 10자 이하로 입력해 주세요.").css("color", "red");
		    } else if (!isValidFormat) {
		    	idchkMsg.html("아이디는 영문자와 숫자로만 구성되어야 합니다.").css("color", "red");
		    } else {
		    	idchkMsg.html(""); // 조건 충족 시, 메세지 초기화
		    }
		});
		
		$("#userId").on("blur", function() {
		    const userId = $(this).val();
		    const id_chkMsg = $("#id_chkMsg");

		    if (/^[a-zA-Z0-9]{6,10}$/.test(userId)) {
		        $.ajax({
		            url: "/mem_id_chk",
		            data: { userId: userId },
		            method: "post",
		            dataType: "text",
		            success: function(data) {
		                console.log("서버 응답:", data);

		                if (data == '1') {
		                    id_chkMsg.html("아이디가 중복됩니다.").css("color", "red");
		                } else if (data == '0') {
		                    id_chkMsg.html("아이디 사용이 가능합니다.").css("color", "green");
		                } else {
		                    id_chkMsg.html("아이디 중복 확인 실패").css("color", "orange");
		                }
		            },
		            error: function() {
		                alert("아이디 중복 확인 실패");
		            }
		        });
		    } else {
		        id_chkMsg.html("");
		    }
		});

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
	                }
	            } else {
	                pwMsg.html("비밀번호가 일치하지 않습니다.").css("color", "red");
	            }
	        } else {
	            pwMsg.html(""); // value가 모두 없을 때 메세지 없음
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
	
	<!-- 전화번호   -->
	<script type="text/javascript">
	// 전화번호 정규식
	$("#userPhone").on("input", function () {
	    let userPhone = $(this).val();
	    const phoneChkMsg = $("#phone_chkMsg");
	    const phoneChkBtn = $("input[type='button'][onclick='phone_chk()']"); 

	    // 숫자만 남기기
	    userPhone = userPhone.replace(/[^0-9]/g, "");

	    // 올바른 앞자리인지 확인
	    const validPrefixes = ["010", "011", "016", "017", "018", "019"];
	    const prefix = userPhone.slice(0, 3);

	    if (userPhone.length >= 3 && !validPrefixes.includes(prefix)) {
	        // 유효하지 않은 앞자리 입력 시
	        phoneChkMsg.html("유효하지 않은 전화번호 앞자리입니다. 다시 입력해 주세요.").css("color", "red");
	        $(this).val(""); // 입력값 초기화
	        phoneChkBtn.prop("disabled", true).css("background-color", "#88B0AB");
	        return;
	    } else {
	        // 메시지 초기화
	        phoneChkMsg.html("");
	    }

	    // 하이픈 추가 로직
	    if (prefix === "010") {
	        // 010인 경우: 3-4-4 형식, 최대 13자
	        if (userPhone.length <= 3) {
	            userPhone = userPhone;
	        } else if (userPhone.length <= 7) {
	            userPhone = userPhone.slice(0, 3) + "-" + userPhone.slice(3);
	        } else if (userPhone.length <= 11) {
	            userPhone = userPhone.slice(0, 3) + "-" + userPhone.slice(3, 7) + "-" + userPhone.slice(7);
	        } else {
	            userPhone = userPhone.slice(0, 3) + "-" + userPhone.slice(3, 7) + "-" + userPhone.slice(7, 11);
	        }
	    } else if (["011", "016", "017", "018", "019"].includes(prefix)) {
	        // 다른 번호: 3-3-4 형식, 최대 12자
	        if (userPhone.length <= 3) {
	            userPhone = userPhone;
	        } else if (userPhone.length <= 6) {
	            userPhone = userPhone.slice(0, 3) + "-" + userPhone.slice(3);
	        } else if (userPhone.length <= 10) {
	            userPhone = userPhone.slice(0, 3) + "-" + userPhone.slice(3, 6) + "-" + userPhone.slice(6);
	        } else {
	            userPhone = userPhone.slice(0, 3) + "-" + userPhone.slice(3, 6) + "-" + userPhone.slice(6, 10);
	        }
	    }
	    // 하이픈 적용 후 커서 위치 유지
	    setTimeout(() => {
	        const position = $(this)[0].selectionStart; // 현재 커서 위치
	        $(this)[0].setSelectionRange(position, position); // 커서 위치 복원
	    }, 0);
	    
	 	// 전화번호 유효성 최종 확인 (길이 및 형식 모두 맞는 경우)
	    const phoneRegex = /^(010-\d{4}-\d{4}|01[1|6|7|8|9]-\d{3}-\d{4})$/;
	    if (phoneRegex.test(userPhone)) {
	        phoneChkMsg.html(""); // 메시지 초기화
	        phoneChkBtn.prop("disabled", false).css("background-color", "#008165"); // 버튼 활성화
	    } else {
	        phoneChkMsg.html("전화번호 형식이 맞지 않습니다.").css("color", "red");
	        phoneChkBtn.prop("disabled", true).css("background-color", "#88B0AB"); // 버튼 비활성화
	    }

	    // 포맷팅된 값 업데이트
	    $(this).val(userPhone);
	});
	</script>
	
	<script type="text/javascript">
	$(document).ready(function () {
	    // 전화번호 중복 검사 함수
	    window.phone_chk = function () {
	        const userPhone = document.getElementById("userPhone").value;

	        if (!userPhone) {
	            alert("전화번호를 먼저 입력해 주세요.");
	            return;
	        }

	        $.ajax({
	            url: "mem_phone_chk", // 서버 요청 URL
	            data: { userPhone: userPhone }, // 요청 데이터
	            method: "post",
	            dataType: "json",
	            cache: false,
	            success: function (data) {
	                const emailSelectionDiv = $("#emailSelection"); // 이메일 선택 영역
	                console.log("AJAX 응답 데이터:", data);

	                if (data.status === "duplicate") {
	                	console.log(data.email);
	                    // 중복된 전화번호의 경우
	                    let emailHTML = '<p style="color: red;">이미 사용 중인 전화번호입니다. 아래 이메일 중 선택하세요:</p>';
	                    emailHTML += '<input type="radio" name="emailOption" value="'+data.email+'" id="existingEmail" checked>'
	                    emailHTML += '<label for="existingEmail">'+data.email+'</label>'
	                    emailHTML += '<button type="button" id="selectEmailBtn">선택</button>'
	                    emailSelectionDiv.html(emailHTML);

	                    console.log("emailSelectionDiv 상태 (업데이트 후):", emailSelectionDiv.html());

	                    // 선택 버튼 클릭 이벤트 추가 (중복 방지)
	                    $(document).off("click", "#selectEmailBtn"); // 기존 이벤트 제거
	                    $(document).on("click", "#selectEmailBtn", function () {
	                        const selectedEmail = $("input[name='emailOption']:checked").val();
	                        $("#selectedEmail").val(selectedEmail).trim();
                            selectedEmail = selectedEmail.replace(/,/g, "");
	                        $("#userMail").val(selectedEmail); // 이메일 필드에 값 설정
	                        alert("선택된 이메일: "+selectedEmail);
	                        $("#userChk").val("1");
	                    });

	                    $("#userMail").prop("disabled", true); // 이메일 입력 필드 비활성화
	                    $("#authNumber").prop("disabled", true); // 이메일 입력 필드 비활성화
	                } else if (data.status === "available") {
	                    // 사용 가능한 전화번호의 경우
	                    emailSelectionDiv.html("<p>사용 가능한 전화번호입니다. 이메일을 입력하세요.</p>");
	                    $("#userMail").prop("disabled", false);
	                    $("#userMail").val(""); // 이메일 필드 초기화
	                   
	                    $("#authNumber").prop("disabled", false);
	                    $("input[type='button'][onclick='authNum_chk()']").prop("disabled", false).css("background-color", "#008165");
	                } else {
	                    alert("오류가 발생했습니다. 다시 시도해 주세요.");
	                }
	            },
	            error: function (xhr, status, error) {
	                console.error("AJAX 요청 중 오류 발생:", error);
	                alert("서버와 통신 중 오류가 발생했습니다. 다시 시도해 주세요.");
	            },
	            complete: function () {
	                console.log("AJAX 요청 완료");
	            }
	        });
	    };

	    // 이메일 선택 함수
	    window.selectEmail = function (email) {
	        const emailField = document.getElementById("userMail");
	        emailField.value = email; // 선택한 이메일을 입력 필드에 설정
	        alert("선택한 이메일이 입력 필드에 설정되었습니다.");
	    };
	});

</script>

	<!-- 이메일 스크립트 -->
	<script type="text/javascript">
		$("#userMail").on("blur", function() {
	    	const userMail = $(this).val();
	    	const mail_chkMsg = $("#mail_chkMsg");
	    	const sendEmailButton = $("input[type='button'][onclick='send_email()']");
	    	const authNumButton = $("input[type='button'][onclick='authNum_chk()']");
	    	
	        // 이메일 형식 확인 정규식
	        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	        
	        if (!emailRegex.test(userMail)) {
	            mail_chkMsg.html("올바른 이메일 형식을 입력해주세요.").css("color", "red");
	            sendEmailButton.prop("disabled", true).css("background-color", "#88B0AB");
	            authNumButton.prop("disabled", true).css("background-color", "#88B0AB");
	            return;
	        }
	   
	        $.ajax({
	            url: "/mem_email_chk",
	            data: { userMail: userMail },
	            method: "post",
	            dataType: "text",
	            success: function(data) {
	                console.log("서버 응답:", data);

	                if (data == '1') {
	                    mail_chkMsg.html("이메일이 중복됩니다.").css("color", "red");
	                    sendEmailButton.prop("disabled", true).css("background-color", "#88B0AB");
	                    authNumButton.prop("disabled", true).css("background-color", "#88B0AB");
	                    isEmailVerified = false;
	                    $(".join_btn").prop("disabled", true);
	                } else if (data == '0') {
	                    mail_chkMsg.html("이메일 사용이 가능합니다.").css("color", "green");
	                    sendEmailButton.prop("disabled", false).css("background-color", "#008165");
	                    authNumButton.prop("disabled", false).css("background-color", "#008165");
	                } else {
	                    mail_chkMsg.html("이메일 중복 확인 실패").css("color", "orange");
	                    sendEmailButton.prop("disabled", true).css("background-color", "#88B0AB");
	                    authNumButton.prop("disabled", true).css("background-color", "#88B0AB");
	                }
	            },
	            error: function() {
	                alert("이메일 중복 확인 실패");
	            }
	       	});
		});
		
		let isEmailVerified = false;
		
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
                	$(".join_btn").prop("disabled", true);
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
                        alert(response.message); // 인증 성공 시 메시지
                        isEmailVerified = true;
                        enableJoinButton();
                    } else {
                        alert(response.message); // 인증 실패 시 메시지
                        document.getElementById("authNumber").value = "";
                        document.getElementById("authNumber").focus();
                        isEmailVerified = false;
                        $(".join_btn").prop("disabled", true);
                    }
                },
                error: function() {
                    alert("다시 시도해 주세요.");
                }
            });
        }
	</script>

	
	<!-- 주소 api 스크립트 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
   		function sample6_execDaumPostcode() {
        	new daum.Postcode({
           	 oncomplete: function(data) {
                var addr = ''; // 주소 변수
                
                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 지번 주소를 선택했을 경우
                    addr = data.jibunAddress;
                }

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("userAddr").value = addr;
            	}
        	}).open();
   		 }
	</script>
	
	<!-- 관심지 스크립트 -->
	<script type="text/javascript">
		$(document).ready(function() {
			const maxSelections = 3;
			let selectedFavorites = [];

			$('input[type="checkbox"][name="userFavor"]').on('change', function() {
				if (this.checked) {
					if (selectedFavorites.length >= maxSelections) {
						alert("최대 3개까지만 선택 가능합니다.");
						this.checked = false;
						return;
					}
					selectedFavorites.push(this.value);
				} else {
					selectedFavorites = selectedFavorites.filter(item => item !== this.value);
				}
					
				setFavoriteFields(selectedFavorites);
				$('.join_btn').prop('disabled', selectedFavorites.length !== maxSelections);
			});

			function setFavoriteFields(selectedFavorites) {
				$('input[name="userFavor01"]').val(selectedFavorites[0] || "");
				$('input[name="userFavor02"]').val(selectedFavorites[1] || "");
				$('input[name="userFavor03"]').val(selectedFavorites[2] || "");
			}
		});
		
		// 회원가입 버튼
		function enableJoinButton() {
	        const selectedFavorites = $('input[type="checkbox"][name="userFavor"]:checked').length;
	        
	        // 이메일 인증 성공 && 관심지 3개 선택 시 버튼 활성화
	        if (isEmailVerified && selectedFavorites === 3) {
	            $(".join_btn").prop("disabled", false);
	        } else {
	            $(".join_btn").prop("disabled", true);
	        }
	    }
		</script>
	</div>
</body>
</html>