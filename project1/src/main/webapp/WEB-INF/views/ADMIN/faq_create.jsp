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
	#table{
		width: 100%;
	}
	.vars{
		width: 30%;
	}
	#faqcontent{
		height: 100px;
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
			<form action="/admin_faq_create_ok" method="post">
				<table id="table">
					<tbody>
						<tr>
							<td class="vars"><label for="faqQuestion">FAQ제목</label></td>
							<td><textarea rows="15" cols="60" name="faqQuestion" required></textarea>
						</tr>
						<tr>
							<td class="vars"><label for="faqAnswer">Answer</label></td>
							<td><textarea rows="15" cols="60" name="faqAnswer" required></textarea>
						</tr>
						<tr>
							<td class="vars"><label for="faqStatus">게시글 보이기</label></td>
							<td>
								<select name="faqStatus">
									<option value="on">on</option>
									<option value="off">off</option>
								</select>
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2">
							<input type="button" value="저장" onclick="admin_faq_create_ok(this.form)">
							<button type="button" onclick="location.href='/admin_faq';">취소</button>
							</td>
						</tr>
					</tfoot>
				</table>
			</form>
		</div>
	</div>
	
	<script type="text/javascript">
	   function admin_faq_create_ok(f) {
			f.submit();
		}
	</script>
</body>
</html>