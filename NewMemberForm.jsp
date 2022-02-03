<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/common.css" />
<title>신규 고객 등록</title>
<script>
	/* alert("테스트");
	document.getElementById('currentDate').value =new Date().toISOString().substring(0, 10); */
	
</script>
</head>
<body>
	<div class="container">
		<div class="content">
			<hr>
			<b>신규 고객 등록</b>

			<form action="NewMember.jsp" method="post">
				<table>
					<tr>
						<td>고객 이름</td>
						<td><input type="text" name="custname"></td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td><input type="text" name="phone"></td>
					</tr>
					<tr>
						<td>주소</td>
						<td><input type="text" name="address"></td>
					</tr>
					<!-- <tr>
						<td>가입날짜</td>
						<td><input type="date" name="joindate" id="currentDate"></td>
					</tr> -->
					<tr>
						<td>등급</td>
						<td><input type="text" name="grade" value="Silver" readonly></td>
					</tr>
					<tr>
						<td>시/도</td>
						<td><input type="text" name="city" value="01"></td>
					</tr>
				</table>
				<input type="submit" value="등록">
			</form>
		</div>
	</div>
</body>
</html>