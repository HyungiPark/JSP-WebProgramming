<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/common.css" />
<title>JSP Oracle Test</title>

</head>
<body>
	<div class="container">
		<div class="content">
			<form action="SelectMember.jsp">
				<input type="text" name="name"><input type="submit"
					value="조회">
			</form>
			<table align="center" border="1">
				<tr>
					<th>고객번호</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>주소</th>
					<th>가입날짜</th>
					<th>등급</th>
					<th>시/도</th>
				</tr>
				<%
				// 오라클 데이터베이스 연결
				Class.forName("oracle.jdbc.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "shop", "1234");

				String name = request.getParameter("name");
				
				int custno = 0;
				String custname = "";
				String phone = "";
				String address = "";
				Date joindate;
				String grade = "";
				String city = "";
				String query = "";
				
				/* Connection con = getConnection(); */
				//	result = con.prepareStatement(query).executeQuery();
				//	result.next();					// 쿼리문 조회 결과 첫번째 행으로 이동. next를 안하면 시작시 오류 발생.
				if (name == null) {
					query = "select * from member_tbl_02";
					ResultSet result = con.prepareStatement(query).executeQuery();

					while (result.next()) {
						custno = result.getInt("CUSTNO");
						custname = result.getString("CUSTNAME");
						phone = result.getString("PHONE");
						address = result.getString("ADDRESS");
						joindate = result.getDate("JOINDATE");
						grade = result.getString("GRADE");
						city = result.getString("CITY");

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
				<tr>
					<td align="center"><%=custno%></td>
					<td align="center"><%=custname%></td>
					<td align="center"><%=phone%></td>
					<td align="center"><%=address%></td>
					<td align="center"><%=joindate%></td>
					<td align="center"><%=grade%></td>
					<td align="center"><%=city%></td>
				</tr>

				<%
				}
			}
				else if(name!= null){
					
					query = "select * from member_tbl_02 where custname = '"+name+"'";
					ResultSet result = con.prepareStatement(query).executeQuery();
					String query2="select * from money_tbl_02 where custno = (select custno from member_tbl_02 where custname='"+name+"')";
					ResultSet result2 = con.prepareStatement(query2).executeQuery();
					int cnt=0;
					while (result.next()) {
						cnt += 1;
						custno = result.getInt("CUSTNO");
						custname = result.getString("CUSTNAME");
						phone = result.getString("PHONE");
						address = result.getString("ADDRESS");
						joindate = result.getDate("JOINDATE");
						grade = result.getString("GRADE");
						city = result.getString("CITY");
						
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
				<tr>
					<td align="center"><%=custno%></td>
					<td align="center"><%=custname%></td>
					<td align="center"><%=phone%></td>
					<td align="center"><%=address%></td>
					<td align="center"><%=joindate%></td>
					<td align="center"><%=grade%></td>
					<td align="center"><%=city%></td>
				</tr>
				<%
					}
			
				}
				%>
			</table>
		</div>
	</div>
</body>
</html>
