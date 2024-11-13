<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MyPage - 나의정보수정</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
 <style type="text/css">
	#container{display: flex; padding-top: 75px;}
	#container #flex_left{width: 15%;  background-color: Whitesmoke;}
	#container #flex_write{width: 85%;}
	#container #logo{width: 200px; height: 70px;} 
	#container #name{font-size: 50px; font-weight: bold;}
	#container #article_container{display: flex; flex-direction: column;}
	#container article{padding: 20px; margin: 10px; text-align: center;}
	#container article i {font-size: 60px; padding: 20px; margin-right: 10px;}
	#container article span{font-size: 30px; display: inline-block; margin-top: 20px;}
	#container #title{font-size: 50px; margin-left: 20px;}
	#container #msg{margin-left: 100px;  font-size: 30px;}
	#container a {text-decoration: none; color: black}
	#container #update_form{width: 1000px; min-height: 1000px; margin: 0 auto;}
	#container #modal {
      display: none; 
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5); 
    }

	#container #modal-content{
		background-color: white;
		margin: 5% auto;
		padding: 20px;
		border: 1px solid #888;
		width: 70%;
		height: 70%;
		text-align: center;
		overflow: scroll;
	}
    #container .write { padding: 10px; margin-left: 20px; margin-bottom: 20px;}
    #container input[type="text"], input[type="email"]{font-size: 20px;}
    #container input[type="submit"] {width: 100px; height: 60px; }
    #container .btn_action{
    	margin-right: 100px;
    	margin-top: 30px;
    	width: 130px; height: 60px;
    	
    }
    #container span {font-size: 20px;}
    #container i {font-size: 20px;}
    #container td{
	    margin: 100px;  
	    border: 1px solid black; 
	    background-color: white;
	    width: 300px; 
	    height: 50px;
	    text-align: center;
	    
	 }
	 #container #buttons{display: flex; justify-content: center; margin-top: 20px; align-content: center;} 
	 #container #region_table{margin: 32px auto; border-collapse: separate; border-spacing: 8px;}
	 #container .clicked{background-color: #4682B4; color: white}
	 #container td:hover{background-color: #4682B4; color: white}
	 #container input[name="userName"], input[name="userId"] {border: none;}
	 #container #u_emailCode{ margin-left: 20px; margin-bottom: 20px;}
	 #container #judgeMsg1, #judgeMsg2 {margin-left:  100px; margin-top: 0px;}
	 #prId{text-decoration: none; font-size: 50px;}
	.funcImg{width: 100px; height: 100px;}
	label{display: inline-block;}
	#emailLb{width: 550px;}
	#prId{text-decoration: none; color: black; display: inline-block; margin-left: 50px;}
	input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	  -webkit-appearance: none;
	  margin: 0;
	}
	
</style>
</head>
<script type="text/javascript">
</script>
<body>
<jsp:include page="MEM_header.jsp" />
<div id="container">
		<section id="flex_left">
			<p id="name"><a href="/go_my_page" id="prId">
				<c:choose>
					<c:when test="${userName.length >= 8 }">
						<span style="font-size: 50px;">${userId.substring(0,8)}...님</span>
					</c:when>
					<c:otherwise>
						<span style="font-size: 50px;">${userId }님</span>
					</c:otherwise>
				</c:choose>
			</a></p>
			<div id="article_container">
			<article><a href="/go_my_comment">
			<i class="fa-regular fa-message" style="float: left"></i>
				<span>내 댓글 관리</span>
			</a></article>
			<article style="background-color: lightgray">
			<i class="fa-solid fa-user-gear" style="float: left"></i>
				<span>회원정보 수정</span>
			</article>
			<article><a href="go_pw_change">
			<i class="fa-solid fa-unlock" style="float: left"></i>	
				<span>비밀번호 변경</span>
			</a></article>
			<article><a href="/go_user_out">
			<i class="fa-solid fa-arrow-right-from-bracket" style="float: left"></i>
				<span>회원 탈퇴</span>
			</a></article>
			</div>

		</section>
			 
		<section id="flex_write">
			 <p id="title">회원정보 수정</p>
			 <hr>
			 <form  id="update_form" method="post">
				<fieldset>
						<p style="font-weight: bold;">기본 정보</p>
						<hr>
			 			<label for="userName">이름 <input type="text" name="userName" id="userName" class="write" value="${detail.userName }" readonly> </label><br>
				 		<label for="userId">아이디 <input type="text" name="userId" id="userId"  class="write" value="${detail.userId }" readonly></label><br>
				 		<label for="userPhone">전화번호 <input type="text" id="userPhone" name="userPhone" class="write" value="${detail.userPhone }" style="width: 200px;" placeholder="전화번호 입력">
				 			<input id="btn_phoneChk" type="button" value="중복확인"></label><br> 
				 		<p id="judgeMsg1"></p>
			 			<label for="userMail" id="emailLb">이메일 
			 				<input type="email" name="userMail"  id="userMail" class="write" value="${detail.userMail }" 
			 					   pattern="[a-zA-Z0-9]+[@][a-zA-Z0-9]+[.]+[a-zA-Z]+[.]*[a-zA-Z]*" title="이메일 양식" style="width: 330px;">
			 				<input  id="btn_emailChk" type="button" value="중복확인">
			 			</label><br>
			 			<p id="judgeMsg2"></p>
			 			<label for="emailCode" >이메일 인증
			 				<input type="text" id="u_emailCode" name="u_emailCode" placeholder="전송받은 번호 입력">
			 				<input type="button" value="전송" id="sendCode" style="width: 65px; height: 30px;">
			 				<input type="button" value="확인"  id="confirmCode" style="width: 65px; height: 30px;">
			 			</label><br>
	 			 		<label for="userAddr">주소(시/군/구) 
				 			<input type="text" name="userAddr"  id="userAddr" class="write" value="${detail.userAddr }" >
				 		</label>
				 		<input type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기"><br> 
			 			<label>내 관심지역:
			 				<span>1. <i id="userFavor01"></i> &nbsp; &nbsp;</span> 
			 				<span>2. <i id="userFavor02"></i> &nbsp; &nbsp;</span> 
			 				<span>3. <i id="userFavor03"></i>  &nbsp; &nbsp;</span> 
			 				<input type="button" id="change_flavor" value="변경하기" onclick="changeFlavor()">
			 			</label>
			 			<input type="hidden"  id="userFavor01" name="userFavor01" value="${detail.userFavor01}">
			 			<input type="hidden" id="userFavor02" name="userFavor02" value="${detail.userFavor02}">
			 			<input type="hidden" id="userFavor03" name="userFavor03" value="${detail.userFavor03}">
				</fieldset>
				<div id="buttons">
					<input type="button" id="btn_update" class="btn_action" value="수정" style="background-color: gray; color: white; border: none;" onclick="goUpdate(this.form)">
					<input type="button"  id="btn_cancel" class="btn_action" value="취소" style="background: white;" onclick="goMyPage()">
				</div>
			 </form>
		<div id="modal">
			<div id="modal-content">
				<table id="region_table">
					<tbody>
					<tr><td data-region="9">강원도</td> <td data-region="8">경기도</td> <td data-region="14">경상북도</td></tr>
					<tr><td data-region="15">경상남도</td> <td data-region="5">광주광역시</td> <td data-region="3">대구광역시</td></tr>
					<tr><td data-region="6">대전광역시</td> <td data-region="2">부산광역시</td> <td data-region="1">서울특별시</td></tr>
					<tr><td data-region="7">울산광역시</td> <td data-region="4">인천광역시</td> <td data-region="13">전라남도</td></tr>
					<tr><td data-region="12">전라북도</td> <td data-region="16">제주특별자치도</td> <td data-region="11">충청남도</td></tr>
					<tr><td data-region="10">충청북도</td></tr>
					</tbody>
				</table>
				<div id="buttons">
					<input type="button" id="modal_confirm" class="btn_action" value="확인" style="background-color: gray; color: white; border: none;" >
					<input type="button" id="modal_close" class="btn_action" value="닫기" style="background: white;">
				</div>
			</div>
		</div>
		</section>				
	</div>
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
           function sample6_execDaumPostcode() { // 주소 api
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

           function goMyPage() {
        	  location.href = "/go_my_page";
		   }
           
           document.querySelector("#userPhone").addEventListener("keyup", ()=>{
        	   document.querySelector("#judgeMsg1").innerText = '';
        	   isPhoneDupl = false;
           });
           document.querySelector("#userMail").addEventListener("keyup", ()=>{
        	   document.querySelector("#judgeMsg2").innerText = '';
        	   isMailDupl = false;
        	   isMailChk = false;
        	   
           });
           
           let isPhoneDupl = false;
           let isMailDupl = false;
           let isMailChk = false;
           
           function goUpdate(f) {
        	let name = f.userName.value;
        	let id = f.userId.value;
        	let phone = f.userPhone.value;
        	let mail = f.userMail.value;
        	let addr = f.userAddr.value;
        	let favor1 = f.userFavor01.value;
        	let favor2 = f.userFavor02.value;
        	let favor3 = f.userFavor03.value;
        	if(name == "" || id == "" || phone == "" || mail == "" || addr == "" || favor1 == "" || favor2 == "" || favor3 == "") {
        		alert("공란이 존재하면 수정 할 수 없습니다.");
        	}else{
        		if("${detail.userAddr}" != addr || "${detail.userFavor01}" != favor1 || "${detail.userFavor02}" != favor2 || "${detail.userFavor03}" != favor3) {
	        		if("${detail.userPhone}" != phone){
	      				if(!isPhoneDupl){
	      					alert("전화번호 수정시 중복인지 확인해야 합니다.");
	      					return;
	      				}
	      			}
	      			if("${detail.userMail}" != mail){
	      				if(!isMailDupl){
	      					alert("메일 수정시 중복인지 확인해야 합니다.");
	      					return;
	      				}
	      			}
	      			f.action = "/go_update_ok";
	        	   	f.submit();
        		}else{
        			if("${detail.userPhone}" != phone){
	      				if(!isPhoneDupl){
	      					alert("전화번호 수정시 중복인지 확인해야 합니다.");
	      					return;
	      				}
	      			}
	      			if("${detail.userMail}" != mail){
	      				if(!isMailDupl){
	      					alert("메일 수정시 중복인지 확인해야 합니다.");
	      					return;
	      				}
	      				if(!isMailChk){
	      					alert("이메일 인증을 해주십시오");
	      					return;
	      				}
	      			}
	      			f.action = "/go_update_ok";
	        	   	f.submit();
        		}
      			/* f.action = "/go_update_ok";
        	   	f.submit();  */
		  	 }
           }
           function changeFlavor() {
				let modal = document.querySelector("#modal");
				modal.style.display = "block";
		   }
           
           function changeUserFavs() {
        	  let userFavor01 = document.querySelector("#userFavor01"); 
        	  let userFavor02 = document.querySelector("#userFavor02"); 
        	  let userFavor03 = document.querySelector("#userFavor03");
        	  
        	  userFavor01.innerText = getRegionName(${detail.userFavor01});
        	  userFavor02.innerText = getRegionName(${detail.userFavor02});
        	  userFavor03.innerText = getRegionName(${detail.userFavor03});
			}
           changeUserFavs();
           function getRegionName(num_region){
        	   if(num_region === 1) return "서울광역시";
        	   else if(num_region === 2) return "부산광역시";
        	   else if(num_region === 3) return "대구광역시";
        	   else if(num_region === 4) return "인천광역시";
        	   else if(num_region === 5) return "광주광역시";
        	   else if(num_region === 6) return "대전광역시";
        	   else if(num_region === 7) return "울산광역시";
        	   else if(num_region === 8) return "경기도";
        	   else if(num_region === 9) return "강원도";
        	   else if(num_region === 10) return "충청북도";
        	   else if(num_region === 11) return "충청남도";
        	   else if(num_region === 12) return "전라북도";
        	   else if(num_region === 13) return "전라남도";
        	   else if(num_region === 14) return "경상북도";
        	   else if(num_region === 15) return "경상남도";
        	   else if(num_region === 16) return "제주특별자치도";
        	   else return null;
           }
           
          // 모달창 닫을 때 클래스 초기화
           let closeBtn = document.querySelector("#modal_close");
           closeBtn.addEventListener("click", function() {
				let modal = document.querySelector("#modal");
				modal.style.display = "none";
			    let tds = document.querySelectorAll("td");
			    Array.from(tds).map(item => item.classList.remove("clicked"));
           });
			
         
           // td 클릭할때마다 토클형식으로 clicked  클래스 추가하기
           let tds = document.querySelectorAll("td"); // td들을 tds에 모아서 
           Array.from(tds).forEach((td)=>{ // td마다 접근해서 
              td.addEventListener("click", function() { // td가 각각 클릭될때 마다
            	  if (this.classList.contains("clicked")) {
						this.classList.remove("clicked");
				  }else{
					let clicked = document.querySelectorAll(".clicked");
            		  if (clicked.length < 3) {
            			  console.log(clicked.length)
	            		  this.classList.add("clicked");	        
						}
				  }
				});
          });
           

			  
           let modal_confirm = document.querySelector("#modal_confirm"); 
           modal_confirm.addEventListener("click", function() {
        	  let clicked = document.querySelectorAll(".clicked");
        	  if (clicked.length != 3) {
				alert("관심 지역을 반드시 3곳 선택해 주세요.");
			}else {
	        	  let clicked_region = Array.from(clicked).map(item => item = item.innerText);
	        	  let num_region = Array.from(clicked).map(item => item = item.getAttribute("data-region"));
	        	  
	        	  let userFavor01 = document.querySelector("#userFavor01"); 
	        	  let userFavor02 = document.querySelector("#userFavor02"); 
	        	  let userFavor03 = document.querySelector("#userFavor03");
	        	  
	        	  userFavor01.innerText = clicked_region[0];
	        	  userFavor02.innerText = clicked_region[1];
	        	  userFavor03.innerText = clicked_region[2];
	        	  
	        	  let hidden1 = document.querySelector("input[name='userFavor01']"); 
	        	  let hidden2 = document.querySelector("input[name='userFavor02']"); 
	        	  let hidden3 = document.querySelector("input[name='userFavor03']"); 
	        	  
	        	  hidden1.value = num_region[0];
	        	  hidden2.value = num_region[1];
	        	  hidden3.value = num_region[2];
	        	  
				  let modal = document.querySelector("#modal");
				  modal.style.display = "none";
			      let tds = document.querySelectorAll("td");
			      Array.from(tds).map(item => item.classList.remove("clicked"));
			}
           });
	       	function isEmailPatternGood(userMail) {
	    		const pattern = /[a-zA-Z0-9]+[@][a-zA-Z0-9]+[.]+[a-zA-Z]+[.]*[a-zA-Z]*/;
	    		return pattern.test(userMail);
	    	}
	       	function isPhonePatternGood(userPhone) {
	    		const pattern = /^01(?:0|1|[6-9])-\d{3,4}-\d{4}$/;
	    		return pattern.test(userPhone);
	    	}
	       	
          $("#btn_phoneChk").on("click", function(){
        	  let userPhone = document.querySelector("#userPhone").value; 
        	  if (isPhonePatternGood(userPhone)) {
        		  $.ajax({
        			  url:"/judge_user_Phone", 
        			  method: "POST",
        			  data: "userPhone=" + userPhone, 
        		  	  dataType: "text", 
        		  	  success: function(data){
						let judgeMsg1 = document.querySelector("#judgeMsg1");    
        		  		 if(data == "OK" ) {
							judgeMsg1.innerText = "사용 가능한 전화번호 입니다.";
							judgeMsg1.style.color = "green";
							isPhoneDupl = true;
        		  		 }else if (data == "NO") {
							judgeMsg1.innerText = "다른 전화번호를 사용해 주세요.";
							judgeMsg1.style.color = "tomato";
        		  			 
        		  		 }else if (data == null) {
        		  			 alert("서버오류 발생");
        		  		 }
        		  	  }, 
        		  	  error: function(){
        		  		  alert("오류 발생");
        		  	  }
        		  });
      
			  }else {
				alert("올바른 전화번호 형식이 아닙니다.");
			}
          });
          
          $("#btn_emailChk").on("click", function(){
        	  let userMail = document.querySelector("#userMail").value; 
        	  if (isEmailPatternGood(userMail)) {
        		  $.ajax({
        			  url:"/judge_user_Mail", 
        			  method: "POST",
        			  data: "userMail=" + userMail, 
        		  	  dataType: "text", 
        		  	  success: function(data){
						let judgeMsg2 = document.querySelector("#judgeMsg2");    
        		  		 if(data == "OK" ) {
       						judgeMsg2.innerText = "사용 가능한 이메일 입니다.";
       						judgeMsg2.style.color = "green";
       					    isMailDupl = true;
        		  		 }else if (data == "NO") {
       						judgeMsg2.innerText = "다른 이메일을 사용해 주세요.";
       						judgeMsg2.style.color = "tomato";
        		  		 }else if (data == null) {
        		  			 alert("서버오류 발생");
        		  		 }
        		  	  }, 
        		  	  error: function(){
        		  		  alert("오류 발생");
        		  	  }
        		  });
      
			  }else {
				alert("올바른 이메일 형식이 아닙니다.");
			}
          });
			
			$("#userPhone").on("keyup", function() {
				$("#judgeMsg1").text("");
			});
        	 
			$("#userMail").on("keyup", function() {
				$("#judgeMsg2").text("");
			});
			
 			$("#sendCode").on("click", function() {
			let judgeMsg2 = document.querySelector("#judgeMsg2");    
 				if (judgeMsg2.innerText == "사용 가능한 이메일 입니다.") {
					$.ajax({
						url:"/send_email_code", 
						method:"post", 
						data: "userMail=" + $("#userMail").val(), 
						dataType: "text", 
						success: function(result) {
							if (result == "success") {
								alert("메일이 성공적으로 전송되었습니다. 메일함을 확인해주세요.");
							}else {
								alert("메일전송에 실패했습니다");
							}
						}, 
						error: function() {
							alert("에러가 발생했습니다. 이메일 형식을 확인해주세요.");
						}
					});
				}else {
					alert("중복검사를 통과한 뒤에 전송할 수 있습니다.");
				}
			});
 			
			 $("#confirmCode").on("click", function() {
				if ($("#u_emailCode").val() != "") {
					 $.ajax({
						url:"/judge_code_match", 
						method:"post", 
						data: "u_emailCode=" + $("#u_emailCode").val(), 
						dataType: "text", 
						success: function(result) {
							if (result == "success") {
								isMailChk = true;
								alert("인증이 완료되었습니다.");
							}else {
								alert("인증번호가 일치하지 않습니다.");
							}
						}, 
						error: function() {
							alert("오류가 발생하였습니다.");
						}
					});
				}
			});  
			
			 function closeModal() {
					document.querySelector("#modal").style.display = "none";
			}
			// 모달 창 바깥쪽 클릭 시 이벤트
			window.onclick = (e) => {
				const modal = document.querySelector("#modal");
				if(e.target === modal){
					closeModal();
				}
			}

           
    </script>
</body>
</html>