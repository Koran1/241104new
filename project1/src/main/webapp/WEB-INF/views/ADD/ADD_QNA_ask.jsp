<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList - QNA</title>
<link rel="stylesheet" href="resources/css/summernote-lite.css">
<style type="text/css">
	* {
    	box-sizing: border-box;
    	margin: 0;
    	padding: 0;
	}
	.main-container {
		margin: 0;
		padding-top: 100px;
		width: 100%;
		height: 90vh;
		display: flex;
		justify-content: center;
		align-items: flex-start;
	}

	.qna-ask-container {
		width: 60%;
	}

	.qna-ask-table {
		width: 100%;
		border-collapse: collapse;
		margin: 20px 0;
	}

	.qna-ask-table th, .qna-ask-table td {
		border: 1px solid #ddd;
		padding: 10px;
	}

	.qna-ask-table th {
		text-align: left;
		font-weight: bold;
	}

	.qna-ask-table input[type="text"], 
	.qna-ask-table input[type="file"], 
	.qna-ask-table textarea {
		width: 100%;
		padding: 8px;
		box-sizing: border-box;
		border: 1px solid #ccc;
		border-radius: 4px;
	}

	.qna-ask-table textarea {
		resize: none;
		height: 100px;
	}

	.qna-ask-table tfoot td {
		text-align: center;
		padding: 15px;
	}

	.qna-ask-table .cancel_btn {
		background: none;
		border: 1px solid #ddd;
		padding: 5px 10px;
		cursor: pointer;
	}
	.qna-ask-table input[type="button"],
	.qna-ask-table .cancel_btn {
    	padding: 10px 20px;
    	font-size: 16px;
    	border-radius: 4px;
    	border: none;
    	cursor: pointer;
    	transition: background-color 0.3s, color 0.3s;
	}

	.qna-ask-table input[type="button"] {
    	background-color: #008165;
    	color: white;
	}

	.qna-ask-table input[type="button"]:hover {
    	background-color: #02B08A;
	}	

	.qna-ask-table .cancel_btn {
    	background-color: #F8F9FA;
    	color: #333;
    	border: 1px solid #ddd;
	}

	.qna-ask-table .cancel_btn:hover {
    	background-color: #E9ECEF;
    	color: #000;
	}
	/* .note-btn-group{width: auto;}
	.note-toolbar{width: auto;} */
</style>
</head>
<body>
<jsp:include page="../MAIN/header.jsp" />
	<div class="main-container">
		<div class="qna-ask-container">
			<form action="/add_qna_ask_ok" method="post" enctype="multipart/form-data">
				<table class="qna-ask-table">
					<tbody>
						<tr>
							<td><label for="qnaSubject">제목</label></td>
							<td><input type="text" name="qnaSubject" size="20"  id = "qnaSubject" required></td>
						</tr>
						
						<!-- DB에서 가져오기 -->
						<tr>
							<td><label for="userId">아이디</label></td>
							<td><input type="text" name="userId"  id="userId" size="20" value="${sessionScope.userId}" readonly></td>
						</tr>

						<tr>
							<td><label for="fileName">첨부파일</label></td>
							<td><input type="file" name="fileName" size="20"></td>
						</tr>

						<tr>
							<td colspan="2">
								<textarea name="qnaContent" id="qnaContent" required></textarea>
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr align="center">
							<td colspan="2">
								<input type="button" value="저장" onclick="add_qna_ask_ok(this.form)">
								<button type="button" class="cancel_btn" onclick="location.href='/add_qna';">취소</button>
							</td>
						</tr>
					</tfoot>
				</table>
			</form>	
		</div>
	</div>
	<jsp:include page="../MAIN/footer.jsp" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>
	<script src="resources/js/summernote-lite.js" ></script>
	<script src="resources/js/lang/summernote-ko-KR.js" ></script>
   	<script type="text/javascript">
      $(function() {
         $("#qnaContent").summernote({
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
        		$("#qnaContent").summernote("editor.insertImage", path+"/"+fileName);
        	},
        	error : function() {
				alert("읽기 실패");
			}
		});
	}
      function add_qna_ask_ok(f) {
		f.submit();
	}
	</script>
</body>
</html>