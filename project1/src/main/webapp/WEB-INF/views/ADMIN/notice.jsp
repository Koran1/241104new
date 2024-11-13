<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Notice</title>
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
      margin: 5% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 70%;
      height: 70%;
      text-align: center;
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
    .noticeSubject{
    	color: blue;
    	text-decoration: none;
    }
    #noticeSubject:hover, #noticeSubject:focus{
    	cursor: pointer;
    	color: #666666;
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
    #modalnoticecontent{
    	height: 50%;
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
			<button style="color: red" onclick='location.href ="/admin_notice"'>공지사항관리</button>
			<button onclick='location.href ="/admin_faq"'>FAQ관리</button>
			<button onclick='location.href ="/admin_qa"'>Q&A관리</button>
			<button onclick='location.href ="/admin_main"'>게시판관리</button>
		</div>
	
		<div id="main_container">
			<div class="main_button">
				<button class="write_btn" onclick='location.href ="/admin_notice_create"'>작성하기</button>
			</div>
			<table class="notice-table" id="table">
				<thead>
					<tr>
						<th>등록번호</th>
						<th>제목</th>
						<th>등록일</th>
						<th>게시글 Lv.</th>
						<th>게시글보이기</th>
					</tr>
				</thead>
				<tbody id="data">
					<c:choose>
						<c:when test="${empty notice_list}">
							<tr>
								<td colspan="5">"자료가 존재하지 않습니다"</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="k" items="${notice_list}">
								<tr>
									<td>${k.noticeIdx}</td>
									<!-- openModal()에 공지사항 정보를 인자로 전달 -->
									<td class="noticeSubject">
										<p id="noticeSubject"
											onclick="openModal(
                								'${k.noticeIdx}', 
                								'${k.noticeSubject}', 
                								'${fn:substring(k.noticeReg, 0, 10)}', 
                								'${k.noticeLevel}',
                								'${k.noticeStatus}', 
                								'${k.noticeFile}',
                								'${k.noticeContent}'
            									)">${k.noticeSubject}</p>
									</td>
									<td>${fn:substring(k.noticeReg, 0, 10)}</td>
									<td class="noticeLevel">${k.noticeLevel}</td>
									<td class="noticeStatus">
									${k.noticeStatus}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
				<tfoot>
				<tr>
					<td colspan="5">
						<ol class="paging">
							<!-- 이전 -->
							<c:choose>
								<c:when test="${notice_paging.beginBlock <= notice_paging.pagePerBlock}">
									<li class="disable">◀ 이전</li>
								</c:when>
								<c:otherwise>
									<li><a
										href="/admin_notice?notice_cPage=${notice_paging.beginBlock-notice_paging.pagePerBlock}">◀ 이전</a></li>
								</c:otherwise>
							</c:choose>

							<!-- 블록안에 들어간 페이지번호들 -->
							<c:forEach begin="${notice_paging.beginBlock}" end="${notice_paging.endBlock}"
								step="1" var="k">
								<!-- 현재 페이지와 현재 페이지가 아닌 것을 구분하자 -->
								<c:if test="${k == notice_paging.nowPage}">
									<li class="now">${k}</li>
								</c:if>
								<c:if test="${k != notice_paging.nowPage}">
									<li><a href="/admin_notice?notice_cPage=${k}">${k}</a></li>
								</c:if>
							</c:forEach>

							<!-- 다음 -->
							<c:choose>
								<c:when test="${notice_paging.endBlock >= notice_paging.totalPage}">
									<li class="disable">다음 ▶</li>
								</c:when>
								<c:otherwise>
									<li><a href="/admin_notice?notice_cPage=${notice_paging.endBlock+1}">다음 ▶</a></li>
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
			<form action="/admin_notice_update" id="modalform" method="post" enctype="multipart/form-data">
				<table id="modaltable">
					<tr>
						<td class="modalvars">제목</td>
						<td><input type="text" id="modalnoticeSubject" name="noticeSubject"></td>
					</tr>
					<tr>
						<td class="modalvars">등록일자</td>
						<td><input type="text" id="modalnoticeReg" name="noticeReg"></td>
					</tr>
					<tr>
						<td class="modalvars">게시글 Level</td>
						<td><select id="modalnoticeLevel" name="noticeLevel">
							<option value="1">1</option>
							<option value="2">2</option>
						</select>
						</td>
					</tr>
					<tr>
						<td class="modalvars">게시글 보이기</td>
						<td>
						<select id="modalnoticeStatus" name="noticeStatus" >
							<option value="on" >ON</option>
							<option value="off">OFF</option>
						</select>
						</td>
					</tr>
					<!-- 첨부파일 표시용 필드 추가 -->
					<tr>
						<td class="modalvars">첨부파일</td>
						<td><span id="modalnoticeFileName"></span> <!-- 기존 파일명 표시 -->
							<input type="file" name="fileName" id="modalnoticeFile"> <!-- 새 파일 업로드 -->
							<input type="hidden" name="old_f_name" id="modalnoticeFile_origin">
						</td>
					</tr>

					<tr>
						<td id="modalnoticecontent" colspan="2"><textarea cols="60" rows="20"
						 id="modalnoticeContent" name="noticeContent" ></textarea></td>
					</tr>
				</table>
				<input type="hidden" id="modalnoticeIdx" name="noticeIdx">
				<input type="submit" value="수정">
				<input type="reset" value="취소">
			</form>
		</div>
	</div>
	<script type="text/javascript">
		
		function styleTable(){
			const noticeLevelAll = document.querySelectorAll(".noticeLevel");
			noticeLevelAll.forEach(items => {
				if(items.innerText === "1"){
					items.closest("tr").style.backgroundColor  = "#99CC66";
				}
			})
			
			const noticeStatusAll = document.querySelectorAll(".noticeStatus");
			noticeStatusAll.forEach(items => {
				if(items.innerText === "off"){
					items.closest("tr").style.backgroundColor  = "#ddd";
				}
			})
		}
		styleTable();
		
		function openModal(noticeIdx, noticeSubject, noticeReg, noticeLevel, noticeStatus, noticeFile, noticeContent){
			document.querySelector("#popupModal").style.display = "block";
			$("#modalnoticeIdx").attr('value', noticeIdx);
			$("#modalnoticeSubject").attr('value', noticeSubject);
			$("#modalnoticeReg").attr('value', noticeReg);
			
			if(noticeLevel === '1'){
				$("#modalnoticeLevel option[value=1]").prop("selected", true);
			}else{
				$("#modalnoticeLevel option[value=2]").prop("selected", true);
			}
			
			if(noticeStatus === 'on'){
				$("#modalnoticeStatus option[value=on]").prop("selected", true);
			}else{
				$("#modalnoticeStatus option[value=off]").prop("selected", true);
			}
			
			$("#modalnoticeFileName").text(noticeFile || "첨부파일 없음"); 	
			$("#modalnoticeFile_origin").attr('value', noticeFile); 	
			
			$("#modalnoticeContent").html(noticeContent);
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