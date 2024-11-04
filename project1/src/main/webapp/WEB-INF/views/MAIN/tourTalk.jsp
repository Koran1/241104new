<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/summernote-lite.css">
<style type="text/css">
.content_box{
	width: 100%;
	height: 100px;
	border: 0.5px solid gray;
	background-color: lightgray;
	margin: 0 auto;
	justify-content: center;
	align-items: center;
}
#content{
	margin: 0 auto;
	justify-content: center;
	align-items: center;
	width: 90%;
	height: 100px;
}


</style>
<script type="text/javascript">
	function tourTalk_write() {
		location.href = "/tourTalk_write";
	}
</script>
</head>
<body>
    <form method="post" encType="multipart/form-data">
        <textarea name="content" id="content"></textarea>
        <input type="button" value="보내기" onclick="bbs_write_ok(this.form)">
    </form>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>
	<script src="resources/js/summernote-lite.js" ></script>
	<script src="resources/js/lang/summernote-ko-KR.js" ></script>
	<script type="text/javascript">
		$(function() {
			$("#content").summernote({
				lang : 'ko-KR',
				height : 300,
				focus : true,
				placeholder : "최대 3000자까지 쓸 수 있습니다.",
				callbacks : {
					onImageUpload : function(files, editor) {
						for (let i = 0; i < files.length; i++) {
							sendImage(files[i], editor);
						}
					}
				}
			});
		});
		
		function sendImage(file, editor) {
		// FormData 객체를 전송할 때 , jQuery가 설정
		  let frm = new FormData();
		  frm.append("s_file", file);
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
				 const fname = data.fname ;
				 console.log(path, fname);
				 $("#content").summernote("editor.insertImage", path+"/"+fname);
			  },
			  error : function() {
				alert("읽기실패");
			}
		  });
		}
	</script>
	<script type="text/javascript">
		function bbs_write_ok(f) {
			f.action = "/bbs_write_ok";
			f.submit();
		}
	</script>
</body>
</html>