<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyTravelList - Q&A</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link type="text/css" href="/resources/css/style.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
	body{
		margin: 0;
		padding: 0;
		background-color: #f9f9f9;
	}
	.main-container{
		margin: 0;
		padding-top: 100px;
		width: 100%;
		height: 90vh;
	}
	.qna-detail-table{
		width: 70%;
		margin: 20px auto;
		border-collapse: collapse;
		margin-bottom: 20px;
		border-top: 2px solid #708090;
	}
	.qnaSubject{
		font-size: 20px;
		text-align: left;
		padding: 10px;
		background-color: #f1f1f1;
		font-weight: bold;
		border-bottom: 1px solid #ddd;
	}
	.userId{
		font-size: 15px;
		text-align: right;
		padding: 10px;
		background-color: #f1f1f1;
		border-bottom: 1px solid #ddd;
	}
	.qnaReg{
		font-size: 15px;
		text-align: right;
		padding: 10px;
		background-color: #f1f1f1;
		border-bottom: 1px solid #ddd;
	}
	.qnaFile{
		font-size: 15px;
		text-align: left;
		padding: 10px;
		border-bottom: 1px solid #ddd;
		text-decoration: none;
		color: black;
		cursor: pointer;
	}
	.qnaFile:hover{
		text-decoration: underline;
		color: #666666;
	}
	.qnaContent{
		padding: 20px;
		font-size: 16px;
		line-height: 1.6;
		border-bottom: 1px solid #ddd;
	}
	.list_btn{
		margin: 20px auto;
		padding: 10px 30px;
		background-color: #008165;
		color: white;
		border: none;
		border-radius: 5px;
		display: block;
		cursor: pointer;
		width: fit-content;
	}
	.list-button:hover{
		background-color: #006b12;
	}
	.logo-img{
		cursor: pointer;
	}
</style>
</head>
<body>
<jsp:include page="../MAIN/header.jsp" />
	<div class="main-container">
		<div class="qna-detail-container">
			<table class="qna-detail-table">
				<thead>
					<tr>
						<th class="qnaSubject">${qnavo.qnaSubject }</th>
						<th class="userId">${qnavo.userId }</th>
						<th class="qnaReg">${qnavo.qnaReg.substring(0, 10) }</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<%-- <td colspan="3" class="qnaFile">${qnavo.qnaFile }</td> --%>
						<c:choose>
							<c:when test="${empty qnavo.qnaFile}">
								<td colspan="3" class="qnaFile">첨부 파일 없음</td>
							</c:when>
							<c:otherwise>
								<td colspan="3" class="qnaFile">
									<a href="/add_qna_ask_filedown?qnaFile=${qnavo.qnaFile }" class="qnaFile">${qnavo.qnaFile }</a>
								</td>								
							</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<td colspan="3" class="qnaContent">${qnavo.qnaContent }</td>
					</tr>
				</tbody>
			</table>
			<button class="list_btn" onclick="location.href='/add_qna';">목록</button>
		</div>
	</div>
	<jsp:include page="../MAIN/footer.jsp" />
</body>
</html>