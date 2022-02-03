<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">

<%

	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");

	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "shop", "1234");
	
	String custno = request.getParameter("custno");
	String query = "Delete from member_tbl_02 where custno = ?";
	PreparedStatement pstmt = conn.prepareStatement(query);
	pstmt.setString(1,custno);
	
	pstmt.executeQuery();
	
%>
<script>
	alert("정상적으로 삭제가 되었습니다.");
	location.replace("SelectMember.jsp");
</script>
