<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MyPage - 회원탈퇴</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<style type="text/css">
	#container{display: flex; padding-top: 75px;}
	#container #flex_left{width: 15%;  background-color: Whitesmoke;}
	#container #flex_write{width: 85%;}
	#container #logo{width: 200px; height: 70px;} 
	#container #article_container{display: flex; flex-direction: column;}
	#container article{padding: 20px; margin: 10px; text-align: center;}
	#container article i {font-size: 60px; padding: 20px; margin-right: 10px;}
	#container article span{font-size: 30px; display: inline-block; margin-top: 20px;}
	#container #title{font-size: 50px; margin-left: 20px;}
	#container #msg{text-align: center;}
	#container #user_out_form{width: 1300px; min-height: 1000px; margin: 0 auto;}
	#container button {width: 130px; height: 60px; margin-right: 100px; }
	#container #buttons{display: flex; justify-content: center; margin-top: 20px; }
	#container a {text-decoration: none; color: black}
	#container pre {font-size: 20px; display: inline-block; }
	.prId{text-decoration: none; color: black; display: inline-block; margin-left: 50px; font-size: 50px; font-weight: bold;}
</style>
</head>
<body>
<jsp:include page="MEM_header.jsp" />
	<div id="container">
		<section id="flex_left">
			<p id="name"><a href="/go_my_page" id="prId">
			<c:choose>
				<c:when test="${userName.length >= 10 }">
					<span class="prId">${userId.substring(0,10)}...님</span>
				</c:when>
				<c:otherwise>
					<span class="prId">${userId }님</span>
				</c:otherwise>
			</c:choose>				
			</a></p>
			<div id="article_container">
			<article><a href="/go_my_comment">
				<i class="fa-regular fa-message" style="float: left"></i>
				<span>내 댓글 관리</span>
			</a></article>
			<article><a href="/go_update">
				<i class="fa-solid fa-user-gear" style="float: left"></i>
				<span>회원정보 수정</span>
			</a></article>
			<article ><a href="/go_pw_change">
				<i class="fa-solid fa-unlock" style="float: left"></i>	
				<span>비밀번호 변경</span>
			</a></article>
			<article style="background-color:lightgray">
				<i class="fa-solid fa-arrow-right-from-bracket" style="float: left"></i>
				<span>회원 탈퇴</span>
			</article>
			</div>

		</section>
		
		<section id="flex_write">
			 <p id="title">회원탈퇴</p>
			 <hr>
			 <form id="user_out_form" method="post">
			 	<fieldset>
			 		<legend>회원탈퇴</legend>
			 		<pre>
		My Playlist 회원 탈퇴 약관
	제1조 (목적)
	본 약관은 My Playlist(이하 "회사")의 서비스 회원 탈퇴에 관한 제반 사항을 규정함을 목적으로 합니다.
	제2조 (회원 탈퇴 신청)
	
	회원은 언제든지 회사가 제공하는 회원 탈퇴 절차를 통하여 탈퇴를 신청할 수 있습니다.
	회원 탈퇴 신청 시 본인 확인을 위한 인증 절차를 거쳐야 합니다.
	회원 탈퇴는 회원의 의사표시가 회사에 도달한 시점에 효력이 발생합니다.
	
	제3조 (회원정보 및 게시물 처리)
	
	회원 탈퇴 시 회원의 개인정보는 개인정보 처리방침에 따라 처리됩니다.
	탈퇴 후 회원의 게시물 처리
	
	여행 후기 게시물은 삭제되지 않고 유지됩니다.
	게시물 작성자명은 "탈퇴회원"으로 표시됩니다.
	작성한 게시물의 삭제를 원하는 경우 반드시 탈퇴 전 직접 삭제해야 합니다.
	

	
	제4조 (재가입 제한)
	
	회원 탈퇴 후 30일간 동일한 아이디로 재가입이 제한됩니다.
	서비스 부정 이용으로 탈퇴 처리된 경우 영구적으로 재가입이 제한될 수 있습니다.
	
	
	
	제5조 (개인정보 보관)
	
	회원 탈퇴 후에도 다음의 정보는 관련 법령에 의거하여 일정 기간 보관됩니다:
	
	계약 또는 청약철회에 관한 기록: 5년
	대금결제 및 재화 등의 공급에 관한 기록: 5년
	소비자의 불만 또는 분쟁처리에 관한 기록: 3년
	
	
	
	제6조 (책임과 의무)
	
	탈퇴 후 재가입하여 새로운 계정을 만들더라도 기존 계정의 정보, 콘텐츠 등은 복구되지 않습니다.
	
	제7조 (약관의 개정)
	
	본 약관은 관련 법령의 개정이나 회사의 정책 변경 등에 따라 개정될 수 있습니다.
	약관 개정 시 회사는 웹사이트를 통해 공지합니다.
	
			 		</pre>
			 		<br>
			 		<input type="checkbox" id="out_check" name="out_check">
			 		<span style="font-size: 20px; font-weight: bold;">나는 위의 항목들을 이해했으며, 이에 동의합니다.</span>
			 		
			 		
			 	</fieldset>
				 <div id="buttons">
					 <button type="button" onclick="cancle(this.form)">취소</button>
				 	 <button type="button" onclick="goOut(this.form)">탈퇴하기</button>
				 </div>
			 </form>
		</section>				
	</div>
	<script type="text/javascript">
	function cancle(f) {
		f.action = "/go_my_page" ;
		f.submit();
	}
	function goOut(f) {
		let chkBox = document.querySelector("#out_check");
		if (chkBox.checked) {
			if (confirm("정말 탈퇴하시겠습니까? 이후에는 되돌릴 수 없습니다.")) {
		 		f.action = "/go_user_out_ok" ;
				f.submit(); 
			}
		}else{
			alert("약관에 동의해야 탈퇴가 가능합니다.");			
		}
	}
	</script>
</body>
</html>