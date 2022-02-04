<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="DBconnection.jsp" %>
<%@ page import="java.util.*" %> 
<%
	String action = request.getParameter("action");
	String move_url = "./";
	String grade="";
	PreparedStatement pstmt = null;
	String custno="";
	int cno=0;
	
	/**
	 * index.jsp와 update.jsp에서 form을 전송할 때
	 * action을 hidden값으로 전송한다. 해당 값에 맞는 명령을 수행하도록  작성 
	 */
	switch (action) {
	case "insert" :
		query =  "insert into member_tbl_02 values(member_seq.nextval,?,?,?,TO_DATE(SYSDATE,'YYYY-MM-DD'),?,?)";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1,request.getParameter("custname"));
		pstmt.setString(2,request.getParameter("phone"));
		pstmt.setString(3,request.getParameter("address"));
		if(request.getParameter("grade")!=null || request.getParameter("grade") != ""){
			grade = "C";
		}
		pstmt.setString(4,grade);
		pstmt.setString(5,request.getParameter("city"));
		move_url="SelectMember.jsp";
		break;
	case "update" :
		custno = request.getParameter("custno");
		cno = Integer.parseInt(custno);
		String custname = request.getParameter("custname");
		query = "update member_tbl_02 set custname=?, phone=?, address =?, city=? where custno="+cno;
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, custname);
		pstmt.setString(2, request.getParameter("phone"));
		pstmt.setString(3, request.getParameter("address"));
		pstmt.setString(4, request.getParameter("city"));
		move_url = "SelectMember.jsp";
		break;
	case "delete" :
		custno = request.getParameter("custno");
		query = "Delete from member_tbl_02 where custno = ?";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1,custno);
		move_url = "SelectMember.jsp";
		break;
	case "stack" :
		Stack<Integer> st = new Stack<>();
		cno=0;
		query = "select * from member_tbl_02 order by custno";
		ResultSet result = conn.prepareStatement(query).executeQuery();
		
		while (result.next()) {
			cno = result.getInt("CUSTNO");
			st.push(cno);
		}
		int st_custno = st.pop(); // LIFO 또는 FILO 
		
		String st_query = "Delete from member_tbl_02 where custno = ?";
		
		pstmt = conn.prepareStatement(st_query);
		pstmt.setInt(1,st_custno);
		
		move_url = "SelectMember.jsp";
		break;
	case "queue" :
		Queue<Integer> queue = new LinkedList<>();
		cno = 0;
		query = "select * from member_tbl_02 order by custno";
		result = conn.prepareStatement(query).executeQuery();
		
		while (result.next()) {
			cno = result.getInt("CUSTNO");
			queue.offer(cno);
		}
		int qu_custno = queue.poll(); // FIFO
		
		String qu_query = "Delete from member_tbl_02 where custno = ?";
		
		pstmt = conn.prepareStatement(qu_query);
		pstmt.setInt(1,qu_custno);
		move_url = "SelectMember.jsp";
		break;
	}
	//out.println(sql.trim());
	//if(true) return;
	pstmt.executeQuery();
%>
<script>
	alert('완료되었습니다.');
	location.replace("<%=move_url%>");
</script>