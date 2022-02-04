<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ include file="DBconnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/common.css" />
<title>고객 정보 수정</title>
</head>
<body>
	<div class="container">
		<div class="content">
			<hr> <b>고객 정보 수정</b>
			<%
				String grade="";
				String custname = "";
				String phone="";
				String address="";
				Date joindate=new Date();
				String city="";
				
				String custno = request.getParameter("custno");
				query = "select * from member_tbl_02 where custno ='"+custno+"'";
				ResultSet result = conn.prepareStatement(query).executeQuery();
				
				if (custno == null || custno == "") {
					response.sendRedirect("./SelectMember.jsp");
					return;
				}
				else{
					
					while(result.next()){
						custno = result.getString("CUSTNO");
						custname = result.getString("CUSTNAME");
						phone = result.getString("PHONE");
						address = result.getString("ADDRESS");
						joindate = result.getDate("JOINDATE");
						grade = result.getString("GRADE");
						city = result.getString("CITY");
					}
					switch (grade) {
					case "A":
						grade = "VIP";
						break;
					case "B":
						grade = "GOLD";
						break;
					default:
						grade = "SIVER";
						break;
					}
					%>
					<form action="action.jsp" method="post">
					<input type="hidden" name="action" value="update">
						<table>
							<tr>
								<td>고객 번호</td>
								<td><input type="text" name="custno" value="<%=custno %>" readonly></td>
							</tr>
							<tr>
								<td>고객 이름</td>
								<td><input type="text" name="custname" value="<%=custname %>" ></td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td><input type="text" name="phone" value="<%=phone%>"></td>
							</tr>
							<tr>
								<td>주소</td>
								<td><input type="text" name="address" value="<%=address%>"></td>
							</tr>
							<tr>
								<td>가입날짜</td>
								<td><input type="text" name="joindate" value="<%=joindate %>" readonly></td>
							</tr>
							<tr>
								<td>등급</td>
								<td><input type="text" name="grade" value="<%=grade %>" readonly></td>
							</tr>
							<tr>
								<td>시/도</td>
								<td><input type="text" name="city" value="<%=city %>"></td>
							</tr>			
						</table>
						<input type="submit" value="수정">
					</form>					
					<%
				}
			%>

		</div>
	</div>
</body>
</html>