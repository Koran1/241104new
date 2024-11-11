<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin FAQ</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="resources/css/admin.css" rel="stylesheet"/>
<style type="text/css">
	#main_container button{
		width: 100%;
		padding: 10px 20px;
		width: 150px;
	}
	
	#main_container button:hover{
		background-color: black;
		color: white;
		font-weight: bold;
	}
	#main_container .main_button{
		display: flex;
		justify-content: flex-end;
		width: 100%;
		margin: 20px 0;
	}
	.faqSubject{
    	color: blue;
    	text-decoration: underline;
    }
    .faqSubject:hover, #faqSubject:focus{
    	cursor: pointer;
    }
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

    .modal-content {
      background-color: white;
      margin: 15% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 70%;
      height: 70%;
      text-align: center;
    }
	#modalform{
		height: 100%; 
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
    #modaltable {
    	width: 100%;
    	height: 80%;
    }
    #modaltable td{
    	border: 1px solid black;
    }
    .modalvars{
    	width: 20%;
    	border: none;
    }
    .write_btn {
		margin-left: auto;
		padding: 10px 30px;
		background-color: #02B08A;
		color: white;
		border: none;
		border-radius: 5px;
		cursor: pointer;
	}
    	/* paging */
table tfoot ol.paging {
	list-style: none;
}

table tfoot ol.paging li {
	float: left;
	margin-right: 8px;
}

table tfoot ol.paging li a {
	display: block;
	padding: 3px 7px;
	border: 1px solid #00B3DC;
	color: #2f313e;
	font-weight: bold;
}

table tfoot ol.paging li a:hover {
	background: #00B3DC;
	color: white;
	font-weight: bold;
}

.disable {
	padding: 3px 7px;
	border: 1px solid silver;
	color: silver;
}

.now {
	padding: 3px 7px;
	border: 1px solid #ff4aa5;
	background: #ff4aa5;
	color: white;
	font-weight: bold;
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
			<button onclick='location.href ="/admin_members"'>회원정보관리</button>
			<button onclick='location.href ="/admin_notice"'>공지사항관리</button>
			<button style="color: red" onclick='location.href ="/admin_faq"'>FAQ관리</button>
			<button onclick='location.href ="/admin_qa"'>Q&A관리</button>
			<button onclick='location.href ="/admin_main"'>게시판관리</button>
		</div>
	
		<div id="main_container">
			<div class="main_button">
				<button class="write_btn" onclick='location.href ="/admin_faq_create"'>작성하기</button>
			</div>
			<table class="faq-table" id="table">
				<thead>
					<tr>
						<th>등록번호</th>
						<th>FAQ제목</th>
						<th>등록일</th>
						<th>게시글보이기</th>
					</tr>
				</thead>
				<tbody id="data">
					<c:choose>
						<c:when test="${empty faq_list}">
							<tr>
								<td colspan="4">자료가 존재하지 않습니다</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="k" items="${faq_list}">
								<tr>
									<td>${k.faqIdx}</td>
									
									<!-- openModal()에 공지사항 정보를 인자로 전달 -->
									<td class="faqSubject">
										<p id="faqSubject"
											onclick="openModal(
                								'${k.faqIdx}', 
                								'${k.faqQuestion}', 
                								'${k.faqAnswer}',
                								'${k.faqStatus}'
            									)">${k.faqQuestion}</p>
									</td>
									<td>${fn:substring(k.faqReg, 0, 10)}</td>
									<td class="faqStatus">${k.faqStatus}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
				<tfoot>
				<tr>
					<td colspan="4">
						<ol class="paging">
							<!-- 이전 -->
							<c:choose>
								<c:when test="${faq_paging.beginBlock <= faq_paging.pagePerBlock}">
									<li class="disable">◀ 이전</li>
								</c:when>
								<c:otherwise>
									<li><a
										href="/admin_faq?faq_cPage=${faq_paging.beginBlock-faq_paging.pagePerBlock}">◀ 이전</a></li>
								</c:otherwise>
							</c:choose>

							<!-- 블록안에 들어간 페이지번호들 -->
							<c:forEach begin="${faq_paging.beginBlock}" end="${faq_paging.endBlock}"
								step="1" var="k">
								<!-- 현재 페이지와 현재 페이지가 아닌 것을 구분하자 -->
								<c:if test="${k == faq_paging.nowPage}">
									<li class="now">${k}</li>
								</c:if>
								<c:if test="${k != faq_paging.nowPage}">
									<li><a href="/admin_faq?faq_cPage=${k}">${k}</a></li>
								</c:if>
							</c:forEach>

							<!-- 다음 -->
							<c:choose>
								<c:when test="${faq_paging.endBlock >= faq_paging.totalPage}">
									<li class="disable">다음 ▶</li>
								</c:when>
								<c:otherwise>
									<li><a href="/admin_faq?faq_cPage=${faq_paging.endBlock+1}">다음 ▶</a></li>
								</c:otherwise>
							</c:choose>
						</ol>
					</td>
				</tr>
			</tfoot>
			</table>
		</div>
	</div>
	
	<div id="popupModal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<form action="/admin_faq_update" id="modalform" method="post">
				<table id="modaltable">
					<tr class="modalinputs">
						<td class="modalvars">질문 Question</td>
						<td><textarea id="modalFAQQuestion" cols="60" rows="15"
						name="faqQuestion"> </textarea></td>
					</tr>
					<tr class="modalinputs">
						<td class="modalvars">답변 Answer</td>
						<td><textarea id="modalFAQAnswer" cols="60" rows="15"
						name="faqAnswer"> </textarea></td>
					</tr>
					<tr>
						<td class="modalvars">게시글 보이기</td>
						<td>
						<select id="modalFAQStatus" name="faqStatus" >
							<option value="on" >ON</option>
							<option value="off">OFF</option>
						</select>
						</td>
					</tr>
				</table>
				<input type="hidden" name="faqIdx" id="modalFAQIdx">
				<input type="submit" value="수정">
				<input type="reset" value="취소">
			</form>
		</div>
	</div>
	<script type="text/javascript">
		
		function styleTable(){
			const faqStatusAll = document.querySelectorAll(".faqStatus");
			faqStatusAll.forEach(items => {
				if(items.innerText === "off"){
					items.closest("tr").style.backgroundColor  = "#ddd";
				}
			})
		}
		styleTable();
		
		function openModal(faqIdx, faqQuestion, faqAnswer, faqStatus){
			document.querySelector("#popupModal").style.display = "block";
			$("#modalFAQQuestion").text(faqQuestion);
			$("#modalFAQAnswer").text(faqAnswer);
			$("#modalFAQIdx").attr('value', faqIdx);
			
			if(faqStatus === 'on'){
				$("#modalFAQStatus option[value=on]").prop("selected", true);
			}else{
				$("#modalFAQStatus option[value=off]").prop("selected", true);
			}
			
		}
		
		function closeModal() {
			document.querySelector("#popupModal").style.display = "none";
			document.querySelector("#modalform").reset();
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
	</script>
</body>
</html>