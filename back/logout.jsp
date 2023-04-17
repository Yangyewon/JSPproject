<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%
	//인증정보(세션삭제)
	//리다이렉트
	session.invalidate();
	//session.removeAttribute("user_id");
	//session.removeAttribute("user_name");
	//session.setMaxInactiveInterval(120);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="euc-kr">
<title>Join success</title>
<script type="text/javascript">
	alert("로그아웃 되었습니다");
	location.href="../front/main.jsp";
</script>
</head>
</html>