<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%
	//��������(���ǻ���)
	//�����̷�Ʈ
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
	alert("�α׾ƿ� �Ǿ����ϴ�");
	location.href="../front/main.jsp";
</script>
</head>
</html>