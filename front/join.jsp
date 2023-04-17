<%@ page contentType="text/html;" pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/header.jsp" %>

	<main class="join-page">
		<h1 class="page-title">회원가입</h1>
		<form class="register-form" action="../back/join_check.jsp" method="post">	
			<div><span>아이디</span><input class="input is-primary" type="text" name="ID" placeholder="아이디를 입력해주세요."></div>
			<div><span>비밀번호</span><input class="input is-primary" type="password" name="PW" placeholder="비밀번호를 입력해주세요."></div>
			<div><span>이름</span><input class="input is-primary" type="text" name="NAME" placeholder="이름을 입력해주세요."></div>
			
			<div>
				<span>전화번호</span>
				<div class="phone">
					<div name="PHONE1" class="select is-primary">
					  <select>
						<option>010</option>
						<option>02</option>
						<option>031</option>
						<option>051</option>
					  </select>
					</div>
					<input class="input is-primary" type="text" name="PHONE2" placeholder="0000">
					<input class="input is-primary" type="text" name="PHONE3" placeholder="0000">
					</div>
			</div>

			<div>
				성별
				<div class="control">
				  <label class="radio">
					<input type="radio" name="GENDER" value="m" checked>
					남자
				  </label>
				  <label class="radio">
					<input type="radio" name="GENDER" value="f">
					여자
				  </label>
				</div>
			</div>
			
			 <input type="submit" value="가입" class="button is-primary"/ >
		</form>
	</main>
</body>
<style type="text/css">
	.join-page {
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
		width: 480px;
		gap: 10px;
	}
	.phone {
		display: flex;
		gap: 3px;
	}
</style>