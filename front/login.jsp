<%@ page contentType="text/html;charset=euc-kr" pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/header.jsp" %>

<body>
	<main class="login-page">
		<h1 class="page-title">�α���</h1>
		<form class="login-form" action="../back/login_check.jsp" method="post">	
			<div><span>���̵�</span><input class="input is-primary" type="text" name="id" placeholder="���̵� �Է����ּ���"></div>
			<div><span>��й�ȣ</span><input class="input is-primary" type="password" name="pw" placeholder="��й�ȣ�� �Է����ּ���"></div>
			<input type="submit" value="�α���" class="button is-primary"/ >
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
