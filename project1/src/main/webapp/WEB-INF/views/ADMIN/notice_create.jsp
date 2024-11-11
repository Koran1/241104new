<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Notice</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/summernote-lite.css">
<link href="resources/css/admin.css" rel="stylesheet"/>
<style type="text/css">
	#table{
		width: 100%;
	}
	.vars{
		width: 30%;
	}
	#noticecontent{
		height: 100px;
	}
	.note-btn-group{width: auto;}
	.note-toolbar{width: auto;}
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
			<form action="/admin_notice_create_ok" method="post" enctype="multipart/form-data">
				<table id="table">
					<tbody>
						<tr>
							<td class="vars"><label for="noticeSubject">제목</label></td>
							<td><input type="text" name="noticeSubject" required></td>
						</tr>
						<!--
						<tr>
							<td class="vars">등록일자</td>
							<td>noticeReg</td>
						</tr>
						-->
						<tr>
							<td>첨부파일</td>
							<td><input type="file" name="fileName"></td>
						</tr>
						<tr>
							<td class="vars"><label for="noticeLevel">게시글 Level</label></td>
							<td>
								<select name="noticeLevel">
									<option value="1">1</option>
									<option value="2">2</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="vars"><label for="noticeStatus">게시글 보이기</label></td>
							<td>
								<select name="noticeStatus">
									<option value="on">on</option>
									<option value="off">off</option>
								</select>
							</td>
						</tr>
						<tr>
							<td id="noticecontent" colspan="2">
								<textarea name="noticeContent" id="noticeContent" required></textarea>
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2"><input type="button" value="저장" onclick="admin_notice_create_ok(this.form)">
								<button type="button" onclick="location.href='/admin_notice';">취소</button>
							</td>
						</tr>
					</tfoot>
				</table>
			</form>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>
	<script src="resources/js/summernote-lite.js" ></script>
	<script src="resources/js/lang/summernote-ko-KR.js" ></script>
   	<script type="text/javascript">
      $(function() {
         $("#noticeContent").summernote({
            lang : 'ko-KR',
            height : 300,
            focus : true,
            placeholder : "최대 3000자까지 쓸 수 있습니다.",
            callbacks : {
            	omImageUpload : function(files, editor) {
					for (let i = 0; i < files.length; i++) {
						sendImage(files[i], editor);
					}
				}
            }
         });
      });
      
      function sendImage(file, editer) {
    	 	// FormData 객체를 전송할 때, jQuery가 설정
		let frm  = new FormData();
        frm.append("s_file", file); // 같은 이름 있으면 위로 증가시켜야 함
        $.ajax({
        	url : "/saveImg",
        	data : frm,
        	method : "post",
        	contentType : false,
        	processData : false,
        	cache : false,
        	dataType : "json",
        	success : function(data) {
        		const path = data.path;
        		const fileName = data.fileName;
        		console(path);
        		console(fileName);
        		$("#noticeContent").summernote("editor.insertImage", path+"/"+fileName);
        	},
        	error : function() {
				alert("읽기 실패");
			}
		});
	}
      function admin_notice_create_ok(f) {
		f.submit();
	}
	</script>
</body>
</html>