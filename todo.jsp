<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>To Do List 실습</title>
<script>
/* Javasciprt에서 window.history는 현재 열고 있는 페이지의 이동 상태를 확인할 수 있고 이동 및 조작도 가능한 함수.
history 내용을 조작하는 replaceState의 경우는 현재 주소 창을 바꾸는 것 */
	history.replaceState({},null,location.pathname); // url parameter 값 제거.! 새로고침시 계속 파라미터값이 유지되므로 제거함
</script>
</head>
<body>
	<form action="todo.jsp">
		Add New Item : <input type="text" name="itemName"> <input type="submit" value="추가">
	</form>
	<%
		List<String> items = (List<String>) session.getAttribute("toDoItem");
		String itemName = request.getParameter("itemName");
		if(items == null){
			out.println("ITEM을 추가해주세요.");
			items = new ArrayList<String>();
			session.setAttribute("toDoItem", items);
		}
		if(itemName!=null && itemName !=""){
			items.add(itemName);
		}
	
	%>
	<hr>
	<b>추가한 아이템 </b><br/>
	<ol>
		<%	
			int cnt = 0;
			for(String temp : items){
				cnt++;
				out.println("<li>"+ temp +"</li><br/>");
			}
			if(cnt != 0){
				out.println("총 "+ cnt +"개 입니다.");	
			}

		%>
	</ol>
</body>
</html>
