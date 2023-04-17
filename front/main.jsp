<%@ page contentType="text/html;" pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/header.jsp" %>

<body>
	<main class="main-page">
<!-- 		<h1 class="page-title">메인페이지(수정중)</h1> -->
		<img class="main-image" src="../front/main.jpg">
	</main>
</body>
<style type="text/css">
	#nav {
		margin-top: 10px;
	}
	.main-page {
		display:flex;
		flex-direction: column;
		align-items: center;
		min-height: 100vh;
	}
	.page-title {
		margin-top: 100px;
		font-size: 36px;
		font-weight: bold;
		
	}
	.register-form {
		display:flex;
		flex-direction: column;
		gap: 10px;
	}
	.phone {
		display: flex;
		gap: 3px;
	}
	.main-image{
		margin-top:70px;
	}
</style>