<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
 <!-- session과 자바 문자형 배열을 활용하여 데이터 저장 ! 단, 브라우저가 열려있는 한에서만 세션에 저장되어있음. -->
<body>
	<form action="todo.jsp">
		Add new item:<br/>
		<input type="text" name="theItem">
		<input type="submit" value="submit">
	</form>
	
	<%
		List<String> items = (List<String>) session.getAttribute("myToDoList");	/* 	session.getAttribute는 session(세션)에 
																					데이터를 저장할 myToDoList라는 이름의 변수를 가져온다. */
		
		if(items == null){														// 초기 items 변수는 null이다.
			items = new ArrayList<String>();									// 브라우저 첫 페이지에만 실행되는 if문
			out.println("ITEM이 없습니다.");
			session.setAttribute("myToDoList", items);							/*	session.setAttribute 는 세션에 저장한다라고 생각하면 된다.
																					session에 있는 myToDoList에 문자형배열(List<String> items)을 저장한다. */
		}
		
		String theItem = request.getParameter("theItem");						// html 코드의 <input>태그 안의 name이 theItem인 것의 값을 String theItem에 저장
		if(theItem!=null){
			items.add(theItem);													// .add(theItem)은 items 배열에 입력받은 값 theItem을 저장한다.
		}
	%>
	<hr>
	<b>To List Items:</b><br/>
	
	<ol>
		<%
			for(String temp : items){											//	확장 for문! 일반 for문에서 배열의 길이를 직접 적어주는 것보다 편하다
				out.println("<li>"+temp+"</li>");								// 	배열에 관련된 변수만 확장 for문 사용 가능
			}
		%>
	</ol>
</body>
</html>
