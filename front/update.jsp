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

	<h2>���� ����������</h2>
	
	<form action="../front/update_success.jsp" method="post">
		���̵�:<input type="text" name="id" value="<%=id %>" readonly><br/>
		��й�ȣ:<input type="password" name="pw"><br/>
		�̸�:<input type="text" name="name" value="<%=name %>"><br/>
		��ȭ��ȣ:
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
			<input type="radio" name="gender" value="m" checked>����
			<input type="radio" name="gender" value="f">����
		<% } else { %>
			<input type="radio" name="gender" value="m">����
			<input type="radio" name="gender" value="f" checked>����
		<% } %>
			<input type="submit" value="����">
	</form>
	
	<hr/>

</body>
</html>