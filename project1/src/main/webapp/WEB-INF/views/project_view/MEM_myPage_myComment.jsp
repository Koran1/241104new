<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MyPage - 내댓글보기</title>
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
	#container table{border: 1px solid gray; border-collapse: collapse; width: 80%; height: 300px; margin-top: 20px; }
	#container th, #container td{border: 1px solid gray; text-align: center; padding: 10px; }
	#container button{width: 100px; height: 50px;}
	#container #del_all_btn{float: right; margin-right: 490px; margin-top: 20px;}
	#container a {text-decoration: none; color: black}
	#container #now {border: 1px solid black;font-weight: bold; padding: 3px 7px;}
	#container ul{list-style-type: none;}
	#container li{display: inline;}
	#container tfoot{margin: 50px;}
	#container .page_num{padding: 3px 7px;}
	#container .page_btn{padding: 3px 7px;}
	#prId{text-decoration: none; color: black; display: inline-block; margin-left: 50px;}

</style>
</head>
<body>
<jsp:include page="MEM_header.jsp" />
	<div id="container">
		<section id="flex_left">
			<p id="name"><a href="/go_my_page" id="prId">
			<c:choose>
				<c:when test="${userName.length >= 10 }">
					<span>${userId.substring(0,10)}...님</span>
				</c:when>
				<c:otherwise>
					<span>${userId }님</span>
				</c:otherwise>
			</c:choose>
			</a></p>
			<div id="article_container">
			<article style="background-color: lightgray">
			<i class="fa-regular fa-message" style="float: left"></i>
				<span>내 댓글 관리</span>
			</article>
			<article>
				<a href="/go_update">
				<i class="fa-solid fa-user-gear" style="float: left"></i>
				<span>회원정보 수정</span>
				</a>
			</article>
			<article>
				<a href="/go_pw_change">
				<i class="fa-solid fa-unlock" style="float: left"></i>	
				<span>비밀번호 변경</span>
				</a>
			</article>
			<article>
				<a href="/go_user_out">
				<i class="fa-solid fa-arrow-right-from-bracket" style="float: left"></i>
				<span>회원 탈퇴</span>
				</a>
			</article>
			</div>
		</section>	
		<section id="flex_write">
			 <p id="title">내 댓글 보기 /  삭제하기</p>
			 <hr>
			 <form>
			 <table id="comment_table">
			 	<thead>
			 		<tr>           <!-- 데이터 받을 때 글 번호/관광지명/내용/작성일자 받기  -->
			 			<th>전체선택<input type="checkbox" id="all_chk"/></th><th>관광지명</th><th>내용</th><th>작성일자</th><th></th>
			 		</tr>
			 	</thead>
			 	<tbody id="tbody"></tbody>
			 	<tfoot id="tfoot"></tfoot>
			 </table>
			 <button  type="button" id="btn_del_chked" name="btn_del_chked" style="background-color: gray; color: white; border: none;">일괄삭제</button>
			 
			 </form>
		</section>				
	</div>
	<script type="text/javascript">
		 
		 $("#comment_table").on("click", ".page_num", function() { // 페이지 번호 클릭시 이동이벤트
			 let nowPage = $(this).text();
			getComment(nowPage);
		});
		 
		 $("#comment_table").on("click", ".page_btn", function() {  // 페이지 이전/다음으로 클릭 시 이동이벤트
			 	
				 let nowPage = $(this).attr("name");
			 	console.log("nowPage: ", nowPage);
				getComment(nowPage);
		   });
		    
		function getComment(nowPage) { // 내 댓글 리스트 가져오기
			$.ajax({
				url: "/get_comment_data", 
				method: "post", 
				data: "nowPage=" + nowPage, 
				dataType: "json", 
				success: function(data) {
						if (data.list == null || (data.list).length === 0) {
							$("#tbody").empty();
							tbody = "";
							tbody += "<tr><td colspan='5'>등록된 댓글이 없습니다.</td></tr>";
							$("#tbody").append(tbody);
						}else {
							makeTBody(data.list);						
						}
						makeTfoot(data.paging);
				}, // success 괄호 
				error: function() {
					alert("서버 에러 발생");
				}
				}); // ajax 괄호
		}
		    
		function makeTBody(data) {
				$("#tbody").empty();
					tbody = "";
					$(data).each(function(index, obj) {
						tbody += "<tr>";
						tbody += "<td width='5%'><input type='checkbox' class='checkboxes' name='" + obj.tourTalkIdx + "'></td>"; 
						tbody += "<td width='13'>" + obj.trrsrtNm + "</td>";
						tbody += "<td width='55%'>" + obj.tourTalkContent + "</td>";
						tbody += "<td width='14%'>" + obj.tourTalkReg + "</td>";
						tbody += "<td width='13%'><button type='button' style='background-color: gray; color: white; border: none;' class='btn_del_one' name='" + obj.tourTalkIdx + "'>삭제</button></td>";
						tbody += "</tr>";
					}); // each 괄호
					$("#tbody").append(tbody);
				}
				
		
		function makeTfoot(paging) {
			$("#tfoot").empty();
				tfoot = "";
				tfoot += "<tr>";
				tfoot += "<td colspan='5'><ul>";
				if (paging.startBlock > paging.blockPerPage) {
					let previous = paging.startBlock -1;
					tfoot += "<li class='page_btn' id='previous' name='" + previous + "'>이전으로</li>";
				}
				
				for (let i = paging.startBlock; i <= paging.endBlock; i++) {
					if (i == paging.nowPage) {
						tfoot += "<li id='now' class='page_num'>"+ i +"</li>";
					}else {
						tfoot += "<li class='page_num'>"+ i + "</li>";
					}
				}
				if (paging.totalPage > paging.endBlock) {
					let next = paging.endBlock + 1;
					tfoot += "<li class='page_btn' id='next' name='"+ next +"'>다음으로</li>";
				}
				tfoot += "</ul></td>";
				tfoot += "</tr>";
				$("#tfoot").append(tfoot);
		}
		getComment();

		$("#comment_table").on("click", ".btn_del_one", function() { // 삭제버튼 클릭 이벤트
		    if (confirm("정말 삭제할까요?")) {
		        let nowPage = $("#now").text();
		        $.ajax({
		            url: "/get_del_one", 
		            method: "post", 
		            data: "tourTalkIdx=" + $(this).attr("name"), 
		            dataType: "text", 
		            success: function(result) {
		                if (result == "0") {
		                    alert("삭제 실패");
		                } else if (result == "1") {
		                	let tbody = document.querySelector("#tbody");
		                	let rows = tbody.rows.length;
		                	if (rows === 1) {
			                	$("#tbody").empty();
			                    getComment(nowPage-1);
							}else { 
			                	$("#tbody").empty();
			                    getComment(nowPage);
						}
		                }
		            }, 
		            error: function() {
		                alert("실패");
		            }
		        });
		    }
		});
		
 		 $("#btn_del_chked").on("click", function() { // 일괄 삭제 버튼 클릭 이벤트
 			let nowPage = $("#now").text();
 			let chkBoxes = document.querySelectorAll(".checkboxes");
 	 		let anyChked = Array.from(chkBoxes).some(item => item.checked);
			let chkedBoxes =  Array.from(chkBoxes).filter(item => item.checked);
			let tourTalkIdxes = chkedBoxes.map(item => item.getAttribute("name"));
			if (anyChked) { // 체크된게 없으면 반응 안하게
				if (confirm("정말 삭제하시겠습니까? ")) {
		 			$.ajax({
						url: "/get_del_chked", 
						method: "post", 
						data: { chkedIdx :  tourTalkIdxes}, 
						dataType: "text", 
						success: function(data) {
							if (data == 0 ) {
								alert("삭제 실패");
							}else if (data > 0) {
								$("#tbody").empty();
								getComment(nowPage-1);
							}
						}, 
						error: function() {
							alert("댓글이 없습니다!");
						}
						}); 
				}
			}
			
		});  
 		 
		// 전체선택 체크박스
		$("#comment_table").on("change", "#all_chk", function() { 
			let chkBoxes = document.querySelectorAll(".checkboxes");
			chkBoxes.forEach(item => item.checked = this.checked);		
		});
		
		
	
	</script>

</body>
</html>