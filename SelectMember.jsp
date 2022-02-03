<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/common.css" />
<title>고객 리스트</title>
<script>
	/* Javasciprt에서 window.history는 현재 열고 있는 페이지의 이동 상태를 확인할 수 있고 이동 및 조작도 가능한 함수.
	 history 내용을 조작하는 replaceState의 경우는 현재 주소 창을 바꾸는 것 */
	history.replaceState({}, null, location.pathname); // url parameter 값 제거.! 새로고침시 계속 파라미터값이 유지되므로 제거함
	
	function function_delete(){
		var obj_length = document.getElementsByName("custno").length;
		
		for (var i=0; i<obj_length; i++) {
            if (document.getElementsByName("custno")[i].checked == true) {
            	var returnValue = confirm('정말 삭제하시겠습니까? 삭제하실 회원이 맞는지 확인 후 다시 진행해주시길 바랍니다.');
            	if( returnValue == true){
            		location.href="DeleteMember.jsp?custno="+document.getElementsByName("custno")[i].value;	
            	}else{
            		return;	
            	}
            }
        }
	}
	
	function function_update(){
		var obj_length = document.getElementsByName("custno").length;
		for (var i=0; i<obj_length; i++) {
			if(document.getElementsByName("custno")[i].checked == true){
				var returnValue = confirm('회원 정보를 수정하시려면 확인을 눌러주세요');
				if(returnValue == true){
					location.href="updateMemberForm.jsp?custno="+document.getElementsByName("custno")[i].value;
				}else{
					return;
				}
			}
		}
	}
</script>
</head>
<body>
<!-- 	<div id="topMenu">
		<ul>
			<li><a href="NewMemberForm.jsp">신규 고객 등록</a></li>
			<li><a href="SelectMember.jsp">고객 리스트</a></li>
		</ul>
	</div> -->
	<div class="container">
		<div class="content">
			<h2>고객 리스트</h2>
			<form action="SelectMember.jsp">
				<input type="text" name="name"><input type="submit"	value="조회"> <input type="submit" value="목록"> <input type="button" onClick="location.href='NewMemberForm.jsp'" value="등록">
				<input type="button" onClick="function_delete()" value="삭제"> <input type="button" onClick="function_update()" value="수정">
				<input type="button" onClick="location.href='Stack.jsp'" value="스택"> <input type="button" style="width:25pt;" onClick="location.href='Queue.jsp'" value="큐">
			</form>
			<table align="center" border="1">
				<tr>
					<th>선택</th>
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
				Date joindate=new Date();
				String grade = "";
				String city = "";
				String query = "";
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("YY-MM-DD");

				int cnt = 0;
				/* Connection con = getConnection(); */
				//	result = con.prepareStatement(query).executeQuery();
				//	result.next();					// 쿼리문 조회 결과 첫번째 행으로 이동. next를 안하면 시작시 오류 발생.
				if (name == null || name == "") {
					query = "select * from member_tbl_02 order by custno";
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
								grade = "SILVER";
								break;
						}
						String date = simpleDateFormat.format(joindate);
				%>
				<tr>
					<td align="center"><input type="radio" name="custno" value=<%=custno%>></td>
					<td align="center"><%=custno%></td>
					<td align="center"><%= custname%></a></td>
					<td align="center"><%=phone%></td>
					<td align="center"><%=address%></td>
					<td align="center"><%=date%></td>
					<td align="center"><%=grade%></td>
					<td align="center"><%=city%></td>
				</tr>

				<%
					}
				} else if (name != null || name!= "") {
					query = "select * from member_tbl_02 where custname = '" + name + "'";
					ResultSet result = con.prepareStatement(query).executeQuery();
					if(result.next()){
						do{
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
							String date = simpleDateFormat.format(joindate);
							%>
				<tr>
					<td align="center"><input type="radio" name="custno" value=<%=custno%>></td>
					<td align="center"><%=custno%></td>
					<td align="center"><%= custname%></a></td>
					<td align="center"><%=phone%></td>
					<td align="center"><%=address%></td>
					<td align="center"><%=date%></td>
					<td align="center"><%=grade%></td>
					<td align="center"><%=city%></td>
				</tr>
						<%}while(result.next());
				%>
				<%		
					}else{
				%>
				<tr>
					<td align="center" colspan="7">조회한 회원이 없습니다.</td>
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
			총 매출 금액은 <%=total%>입니다.
		</div>
	</div>
</body>
</html>