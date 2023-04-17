<%@ page contentType="text/html;" pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/header.jsp" %>

<body>
	<main class="main-page">
		<!-- <h1 class="page-title">메인페이지(수정중)</h1> -->
		<img class="join-image" src="../front/main.jpg">
	</main>
</body>

<!DOCTYPE html>
<html>
<head>
<meta charset="euc-kr">
<title>Join success</title>
<script type="text/javascript">
	alert("회원가입 되었습니다. 로그인해주세요");
	location.href="login.jsp";
</script>
</head>
</html>

<style type="text/css">
	.join-image{
		margin-top:70px;
	}
</style>