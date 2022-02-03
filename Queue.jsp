<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %> 
<!-- page import="java.util.Queue" -->
<!-- page import="java.util.LinkedList" -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<% 
	Queue<Integer> queue = new LinkedList<>();
	
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "shop", "1234");
	int custno=0;
	
	String query = "select * from member_tbl_02 order by custno";
	ResultSet result = con.prepareStatement(query).executeQuery();
	
	while (result.next()) {
		custno = result.getInt("CUSTNO");
		queue.offer(custno);
	}
	int qu_custno = queue.poll();
	
	
	String qu_query = "Delete from member_tbl_02 where custno = ?";
	
	PreparedStatement pstmt = con.prepareStatement(qu_query);
	pstmt.setInt(1,qu_custno);
	
	pstmt.executeQuery();
	
%>
<script>
	alert("FIFO구조");
	location.replace("SelectMember.jsp");
</script>
</html>