<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%

	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "shop", "1234");
	String grade="";
	String query = "insert into member_tbl_02 values(member_seq.nextval,?,?,?,TO_DATE(SYSDATE,'YYYY-MM-DD'),?,?)";
 	PreparedStatement pstmt = conn.prepareStatement(query);
	pstmt.setString(1,request.getParameter("custname"));
	pstmt.setString(2,request.getParameter("phone"));
	pstmt.setString(3,request.getParameter("address"));
	if(request.getParameter("grade")!=null || request.getParameter("grade") != ""){
		grade = "C";
	}
	pstmt.setString(4,grade);
	pstmt.setString(5,request.getParameter("city"));
	
	pstmt.executeQuery();
	
%>
<script>
	
	alert("<%=request.getParameter("custname")%> 님의 정보가 등록되었습니다.");
	location.replace("SelectMember.jsp");
</script>
</html>