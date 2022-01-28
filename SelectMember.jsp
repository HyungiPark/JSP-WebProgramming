<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <!-- 회원 목록 초기화면에서 매출금액 테이블도 보여주며 회원 검색시 해당 회원 매출금액도 조회 가능한 테이블 생성 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/common.css" />
<title>JSP Oracle Test</title>
<script>
	/* Javasciprt에서 window.history는 현재 열고 있는 페이지의 이동 상태를 확인할 수 있고 이동 및 조작도 가능한 함수.
	 history 내용을 조작하는 replaceState의 경우는 현재 주소 창을 바꾸는 것 */
	history.replaceState({}, null, location.pathname); // url parameter 값 제거.! 새로고침시 계속 파라미터값이 유지되므로 제거함
</script>
</head>
<body>
	<div class="container">
		<div class="content">
			<form action="SelectMember.jsp">
				<input type="text" name="name"><input type="submit"
					value="조회"> <input type="submit" value="목록">
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
				int cnt = 0;
				/* Connection con = getConnection(); */
				//	result = con.prepareStatement(query).executeQuery();
				//	result.next();					// 쿼리문 조회 결과 첫번째 행으로 이동. next를 안하면 시작시 오류 발생.
				if (name == null || name == "") {
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
				} else if (name != null) {
					query = "select * from member_tbl_02 where custname = '" + name + "'";
					ResultSet result = con.prepareStatement(query).executeQuery();

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
			총
			<%=cnt%>개의 검색 결과입니다.
			<table align="center" border="1">
				<tr>
					<th>고객번호</th>
					<th>고객이름</th>
					<th>매출금액</th>
				</tr>
			<%
			int total = 0;
			if (name != null && name != "") {
				String query2 = "select mn.custno, mb.custname, mn.price from member_tbl_02 mb, money_tbl_02 mn	where mb.custno = mn.custno and mb.custname='"
								+ name + "'";
				
				ResultSet result2 = con.prepareStatement(query2).executeQuery();
				if (result2.next()) {

					do {
						custno = result2.getInt("CUSTNO");
						custname = result2.getString("CUSTNAME");
						int price = result2.getInt("PRICE");
						total = total + price;
				%>
				<tr>
					<td align="center"><%=custno%></td>
					<td align="center"><%=custname%></td>
					<td align="center"><%=price%></td>
				</tr>
				<%
					} while (result2.next());
				} else {
				%>
				<tr>
					<td colspan="3" align="center">매출 조회 결과가 없습니다.</td>
				</tr>
				<%
				}
			}
			else {
				String query2 ="select mn.custno, mb.custname, mn.price from member_tbl_02 mb, money_tbl_02 mn where mb.custno = mn.custno";
				ResultSet result2 = con.prepareStatement(query2).executeQuery();
				
				while(result2.next()){
					custno = result2.getInt("CUSTNO");
					custname = result2.getString("CUSTNAME");
					int price = result2.getInt("PRICE");
					total = total + price;
					%>
					<tr>
						<td align="center"><%=custno%></td>
						<td align="center"><%=custname%></td>
						<td align="center"><%=price%></td>
					</tr>
					<%
				}
			}
				%>
			</table>
			총 매출 금액은
			<%=total%>입니다.
		
		</div>
	</div>
</body>
</html>
