<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Members</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="resources/css/admin.css" rel="stylesheet"/>
<script type="text/javascript">
	<c:if test="${isOK == 'yes' }">
		alert("변경 완료");
	</c:if>
	<c:if test="${isOK == 'no' }">
		alert("변경 실패");
	</c:if>
</script>
<style type="text/css">
	.modal {
      display: none; /* 처음에 보이지 않음 */
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
    }

	.modal-content{
		background-color: white;
		margin: 15% auto;
		padding: 20px;
		border: 1px solid #888;
		width: 70%;
		height: 80%;
		text-align: center;
		overflow: scroll;
	}
    /* 닫기 버튼 */
    .close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }

    .close:hover,
    .close:focus {
      color: black;
      text-decoration: none;
      cursor: pointer;
    }
    .userId{
    	color: blue;
    	text-decoration: underline;
    }
    .userId:hover, .userId:focus{
    	cursor: pointer;
    }
    #modaltable {
    	width: 100%;
    }
    #modaltable td{
    	border: 1px solid black;
    }
    .modalvars{
    	width: 20%;
    	border: none;
    }
    #qnavars{
    	height: 100px;
    }
    ul{
    	list-style-type: none;
	}
	li{
		display: inline;
	}
	li a{
		text-decoration: none; color: black;
	}
	.page_num{
		padding: 3px 7px;
	}
	.page_btn{
		padding: 3px 7px;
	}
	#now {
		border: 1px solid black;font-weight: bold; padding: 3px 7px;
	}
	.btn_modal{
		width: 60px; height: 40px;
	}
	
	
</style>
</head>
<body>
	<div id="header">
		<img id="logo" alt="logo" src="../resources/images/logo.png" onclick='location.href ="/admin_index"'>
		<h2>ADMIN</h2>
	 </div>
	 
	<div id="container">
		<div id="button_container">
			<button style="color: red" onclick='location.href ="/admin_members"'>회원정보관리</button>
			<button onclick='location.href ="/admin_notice"'>공지사항관리</button>
			<button onclick='location.href ="/admin_faq"'>FAQ관리</button>
			<button onclick='location.href ="/admin_qa"'>Q&A관리</button>
			<button onclick='location.href ="/admin_main"'>게시판관리</button>
			</div>
	
	<div id="main_container">
		<form action="/admin_filter_user" id="search_form" method="post">
			<select name="filter_lev" id="filter_lev">
				<option value="0">전체</option>
				<option value="1">일반유저</option>
				<option value="2">탈퇴유저</option>
				<option value="3">악성유저</option>
			</select>
			<input type="text" name="f_keyword" placeholder="검색어를 입력하세요">
			<input type="submit" id="btn_search" value="검색">
		</form>
			<table id="table">
				<thead>
					<tr>
						<th>회원번호</th> <th>이름</th> <th colspan="3">아이디(기본/네이버/카카오)</th><th>회원상태</th><th>가입일</th> 
					</tr>
				</thead>
				<tbody id="data">
					<c:choose>
						<c:when test="${empty list}">
							<tr><td colspan="7">자료가 존재하지 않습니다</td></tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="k" items="${list}" varStatus="vs">
								<tr>
									<td>${k.userIdx}</td>
									<td>${k.userName}</td>
									<c:choose>
										<c:when test="${empty k.userId}">
											<td>없음</td>
										</c:when>
										<c:otherwise>
											<td class="userId" data-index="${vs.index}">${k.userId}</td>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${empty k.n_userId}">
											<td>없음</td>
										</c:when>
										<c:otherwise>
											<td class="userId" data-index="${vs.index}">${k.n_userId}</td>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${empty k.k_userId}">
											<td>없음</td>
										</c:when>
										<c:otherwise>
											<td class="userId" data-index="${vs.index}">${k.k_userId}</td>
										</c:otherwise>
									</c:choose>
									<td>
									<c:if test="${k.userLevel  == 1}">
										일반
									</c:if>
									<c:if test="${k.userLevel  == 2}">
										탈퇴
									</c:if>
									<c:if test="${k.userLevel  == 3}">
										악성										
									</c:if>
									</td>
									<td>${k.userReg}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="9">
							<ul>	
								<c:if test="${pg.startBlock > pg.blockPerPage }">
									<li><a href="/admin_members?nowPage=${pg.startBlock -1}" class="page_btn">이전으로</a></li>
								</c:if>
								<c:forEach begin="${pg.startBlock }" end="${pg.endBlock }" step="1" var="k">
									<c:choose>
										<c:when test="${k == pg.nowPage }">
											<li class="page_num" id="now">${k}</li>
										</c:when>
										<c:otherwise>
											<li class="page_num"><a href="/admin_members?nowPage=${k}">${k }</a></li>
										</c:otherwise>	
									</c:choose>									
								</c:forEach>
								<c:if test="${pg.totalPage > pg.endBlock}">
									<li><a href="admin_members?nowPage=${pg.endBlock  + 1}" class="page_btn">다음으로</a></li>
								</c:if>
							</ul>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		</div>
	
	
	<div id="popupModal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<form action="/admin_manage_user" id="modalform" method="post">
				<table id="modaltable">
					<tr><td class="modalvars" >이름</td><td colspan="3" id="modaluserName"> </td></tr>
					<tr><td class="modalvars">아이디</td><td colspan="3" id="modaluserId"> </td></tr>
					<tr><td class="modalvars">이메일</td><td colspan="3" id="modaluserMail"></td></tr>
					<tr><td class="modalvars">전화번호</td><td colspan="3" id="modaluserPhone"></td></tr>
					<tr><td class="modalvars">주소</td><td colspan="3" id="modaluserAddr"></td></tr>
					<tr><td class="modalvars">관심지</td>
						<td id="modaluserFavor01" style="width: 26.67%"></td>
						<td id="modaluserFavor02" style="width: 26.67%"></td>
						<td id="modaluserFavor03" style="width: 26.67%"></td></tr>
					<tr><td class="modalvars">가입일자</td><td colspan="3" id="modaluserReg"></td></tr>
					<tr><td class="modalvars">마지막 로그인</td><td colspan="3" id="modaluserConnReg"></td></tr>
					<tr><td class="modalvars">회원 상태</td><td colspan="3" id="modaluserLevel">
						<select name="userLevel">
							<option id="lev1" value="1">일반</option>
							<option id="lev2" value="2">탈퇴</option>
							<option id="lev3" value="3">악성</option>
						</select> 
					</td></tr>
					<tr><td class="modalvars" >누적 신고횟수</td><td colspan="2" id="modaluserReport"></td><td><input type='button' value='초기화' onclick="resetReport()"></td></tr>
					<tr>
						<td class="modalvars" id="qnavars"> 활동내역</td>
						<td><span id="countQNA"></span><br><br><span id="countTT">4</span></td>
						<td colspan="2"> <span style="display: inline-block;">최근 활동</span><br><br><a id="recentQNA"></a><br><a id="recentTT"></a></td>
					</tr>
				</table>
				<input type="hidden" value="" name="userEtc01" id="userEtc01">
				<input type="hidden" value="" name="userId" id="userId">
				<input type="submit" value="변경하기" class="btn_modal">
			</form>
		</div>
	</div>
	<script type="text/javascript">
		function filterChoice(filter_lev) {
			console.log(filter_lev);
			if(filter_lev === '1'){
				$("#filter_lev option[value=1]").prop("selected", true);
			}else if(filter_lev === '2'){
				$("#filter_lev option[value=2]").prop("selected", true);
			}else if(filter_lev === '3'){
				$("#filter_lev option[value=3]").prop("selected", true);
			} else{
				$("#filter_lev option[value=0]").prop("selected", true);
			}
		}
		filterChoice("${filter_lev}");
	
	const userList = [
	<c:forEach items="${list }" var="k" varStatus="vs" >
 		{
			userName: "${k.userName}", 
			userId: "${k.userId}", 
			userMail: "${k.userMail}", 
			userPhone: "${k.userPhone}", 
			userAddr: "${k.userAddr}",
			userFavor01: "${k.userFavor01}", 
			userFavor02: "${k.userFavor02}", 
			userFavor03: "${k.userFavor03}", 
			userReg: "${k.userReg}", 
			userConnReg: "${k.userConnReg}", 
			userLevel: "${k.userLevel}", 
			userReport: "${k.userEtc01}"
		} 
	 	<c:if test="${!vs.last}">, </c:if>  
	</c:forEach>
	];
		
		document.querySelectorAll(".userId").forEach(item => 
			item.addEventListener("click",  function(){
			let i = this.dataset.index;
				$.ajax({
					url: "/getUserActivityCount", 
					method: "post", 
					data: "userId="+ userList[i].userId, 
					dataType: "json", 
					success: function(data){
						if (data != null) {
							console.log("ttvo: ", data.ttvo);
							console.log("qvo: ",data.qvo);
							console.log("countQNA: ",data.countQNA);
							console.log("countTT: ",data.countTT);
							document.querySelector("#countQNA").innerText = "남긴 Q&A: " + data.countQNA; 
							document.querySelector("#countTT").innerText = "남긴 댓글: " + data.countTT; 
							document.querySelector("#recentQNA").innerText = "최신 QNA: " + data.qvo.qnaSubject; 
							document.querySelector("#recentTT").innerText = "최신 댓글: " + data.ttvo.tourTalkContent; 
						}
						
					}, 
					error: function(){
						
					}
				});
				
	 		document.querySelector("#modaluserName").innerText = userList[i].userName; 
	 		document.querySelector("#modaluserId").innerText= userList[i].userId; 
	 		document.querySelector("#modaluserMail").innerText = userList[i].userMail; 
	 		document.querySelector("#modaluserPhone").innerText = userList[i].userPhone; 
	 		document.querySelector("#modaluserAddr").innerText = userList[i].userAddr; 
	 		document.querySelector("#modaluserFavor01").innerText = "1.  " + getRegionName(userList[i].userFavor01); 
	 		document.querySelector("#modaluserFavor02").innerText = "2.  " + getRegionName(userList[i].userFavor02); 
	 		document.querySelector("#modaluserFavor03").innerText = "3.  " + getRegionName(userList[i].userFavor03); 
	 		document.querySelector("#modaluserReg").innerText = userList[i].userReg;
	 		document.querySelector("#modaluserConnReg").innerText = userList[i].userConnReg;
	 		document.querySelector("#userEtc01").value = userList[i].userReport;
	 		document.querySelector("#userId").value = userList[i].userId;
	 		document.querySelector("#modaluserReport").innerText = userList[i].userReport;
	 		console.log(userList[i].userLevel);
	 		if (userList[i].userLevel == "1"){
		 		document.querySelector("#lev1").selected = true;
	 		}else if (userList[i].userLevel == "2"){
		 		document.querySelector("#lev2").selected = true;
	 		}else if (userList[i].userLevel == "3"){
		 		document.querySelector("#lev3").selected = true;
	 		}
	 		
			document.querySelector("#popupModal").style.display = "block";
			}));

		function closeModal() {
			document.querySelector("#popupModal").style.display = "none";
			document.querySelector("#modalform").reset();
		}
		
		function getRegionName(region){
		   let num_region = Number(region);
     	   if(num_region === 1) return "서울";
     	   else if(num_region === 2) return "부산";
     	   else if(num_region === 3) return "대구";
     	   else if(num_region === 4) return "인천";
     	   else if(num_region === 5) return "광주";
     	   else if(num_region === 6) return "대전";
     	   else if(num_region === 7) return "울산";
     	   else if(num_region === 8) return "경기";
     	   else if(num_region === 9) return "강도";
     	   else if(num_region === 10) return "충북";
     	   else if(num_region === 11) return "충남";
     	   else if(num_region === 12) return "전북";
     	   else if(num_region === 13) return "전남";
     	   else if(num_region === 14) return "경북";
     	   else if(num_region === 15) return "경남";
     	   else if(num_region === 16) return "제주";
     	   else return null;
        }
		
		// X 버튼 이벤트
		document.querySelector(".close").addEventListener('click', () => {
			closeModal();
		});
		
		// 모달 창 바깥쪽 클릭 시 이벤트
		window.onclick = (e) => {
			const modal = document.querySelector("#popupModal");
			if(e.target === modal){
				closeModal();
			}
		}
		
		function resetReport(){
			document.querySelector("#modaluserReport").innerText = "0";
			document.querySelector("#userEtc01").value = "0";
			
		}

		
		
	</script>

</body>
</html>