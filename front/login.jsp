<%@ page contentType="text/html;charset=euc-kr" pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/header.jsp" %>

<body>
	<main class="login-page">
		<h1 class="page-title">로그인</h1>
		<form class="login-form" action="../back/login_check.jsp" method="post">	
			<div><span>아이디</span><input class="input is-primary" type="text" name="id" placeholder="아이디를 입력해주세요"></div>
			<div><span>비밀번호</span><input class="input is-primary" type="password" name="pw" placeholder="비밀번호를 입력해주세요"></div>
			<input type="submit" value="로그인" class="button is-primary"/ >
		</form>

	</main>

</body>

<style type="text/css">
	#nav {
		margin-top: 10px;
	}
	.login-page {
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
	.login-form {
		display:flex;
		flex-direction: column;
		width: 480px;
		gap: 10px;
	}
</style>
