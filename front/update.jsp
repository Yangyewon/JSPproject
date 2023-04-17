<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

<%
	request.setCharacterEncoding("euc-kr");

	String id = (String)request.getAttribute("ID");
	String name = (String)request.getAttribute("NAME");
	String phone1 = (String)request.getAttribute("PHONE1");
	String phone2 = (String)request.getAttribute("PHONE2");
	String phone3 = (String)request.getAttribute("PHONE3");
	String gender = (String)request.getAttribute("GENDER");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="euc-kr">
<title>Insert title here</title>
</head>
<body>

	<h2>정보 수정페이지</h2>
	
	<form action="../front/update_success.jsp" method="post">
		아이디:<input type="text" name="id" value="<%=id %>" readonly><br/>
		비밀번호:<input type="password" name="pw"><br/>
		이름:<input type="text" name="name" value="<%=name %>"><br/>
		전화번호:
		<select name="phone1">
			<option <%=phone1.equals("010") ? "selected" : "" %>>010</option>
			<option <%=phone1.equals("02") ? "selected" : "" %>>02</option>
			<option <%=phone1.equals("031") ? "selected" : "" %>>031</option>
			<option <%=phone1.equals("051") ? "selected" : "" %>>051</option>
		</select>
		- <input type="text" name="phone2" size="5" value="<%=phone2 %>">
		- <input type="text" name="phone3" size="5" value="<%=phone3 %>">
		
		<br/>
		<% if(gender.equals("m")) { %>
			<input type="radio" name="gender" value="m" checked>남자
			<input type="radio" name="gender" value="f">여자
		<% } else { %>
			<input type="radio" name="gender" value="m">남자
			<input type="radio" name="gender" value="f" checked>여자
		<% } %>
			<input type="submit" value="수정">
	</form>
	
	<hr/>

</body>
</html>