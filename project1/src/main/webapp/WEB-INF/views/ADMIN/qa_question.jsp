<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Notice</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="resources/css/admin.css" rel="stylesheet"/>
<style type="text/css">
	
</style>
</head>
<body>
	<div id="header">
		<img id="logo" alt="logo" src="../resources/images/logo.png" onclick='location.href ="/admin_index"'>
		<h2>admin index</h2>
	 </div>
	 
	<div id="container">
		<div id="button_container">
			<button onclick='location.href ="/admin_members"'>회원정보관리</button>
			<button onclick='location.href ="/admin_notice"'>공지사항관리</button>
			<button onclick='location.href ="/admin_faq"'>FAQ관리</button>
			<button style="color: red" onclick='location.href ="/admin_qa"'>Q&A관리</button>
			<button onclick='location.href ="/admin_main"'>게시판관리</button>
		</div>
	
		<div id="main_container">
			<form action="/admin_qa_answer" method="post" enctype="multipart/form-data">
				<table id="table">
					<tbody>
						<tr>
							<td class="vars"><label for="userId">사용자 ID</label></td>
							<td><input type="text" name="userId" value="${qnavo.userId}" readonly></td>
						</tr>
						<tr>
							<td class="vars"><label for="qnaReg">등록일</label></td>
							<td><input type="text" name="qnaReg" value="${qnavo.qnaReg}" readonly></td>
						</tr>
						<tr>
							<td>첨부파일</td>
							<td><img alt="첨부사진 없음" src="resources/upload/${qnavo.qnaFile}"></td>
						</tr>
						<tr>
							<td class="vars"><label for="qnaSubject">질문 제목</label></td>
							<td><input type="text" name="qnaSubject" value="${qnavo.qnaSubject}" readonly></td>
						</tr>
						<tr>
							<td class="vars"><label for="qnaContent">질문 내용</label></td>
							<td> <textarea rows="15" cols="60" readonly> ${qnavo.qnaContent}</textarea>
							</td>
						</tr>
						<tr>
							<td class="vars"><label for="qnaReSubject">답변 제목</label></td>
							<td><input type="text" name="qnaReSubject" value="Re:${qnavo.qnaSubject}"></td>
						</tr>
						<tr>
							<td class="vars"><label for="qnaReContent">답변 내용</label></td>
							<td> <textarea rows="15" cols="60" name="qnaReContent"> ${qnavo.qnaReContent}</textarea>
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2">
								<input type="button" value="저장" onclick="admin_qa_answer(this.form)">
								<button type="button" onclick="location.href='/admin_qna';">취소</button>
							</td>
						</tr>
					</tfoot>
				</table>
				<input type="hidden" name="qnaIdx" value="${qnavo.qnaIdx}">
			</form>
		</div>
	</div>
	<script type="text/javascript">
	  	function admin_qa_answer(f) {
			f.submit();
		}
	</script>
	
</body>
</html>