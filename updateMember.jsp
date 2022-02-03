<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "shop", "1234");
	
	String cno = request.getParameter("custno");
	int custno = Integer.parseInt(cno);
	String custname = request.getParameter("custname");
	
	String query = "update member_tbl_02 set custname=?, phone=?, address =?, city=? where custno="+cno;
	
	PreparedStatement pstmt = conn.prepareStatement(query);
	pstmt.setString(1, custname);
	pstmt.setString(2, request.getParameter("phone"));
	pstmt.setString(3, request.getParameter("address"));
	pstmt.setString(4, request.getParameter("city"));
	
	pstmt.executeQuery();
	
%>
<script>
	alert("<%=custname%> 님의 정보가 수정되었습니다.");
	location.replace("SelectMember.jsp");
</script>
</html>