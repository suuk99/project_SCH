<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="로그인" />

<%@ include file="/view/sch/common/header.jsp"%>

	<script>
		const loginForm = function() {
			const form = document.forms['loginForm'];
			const userId = form.userId.value.trim();
			const password = form.password.value.trim();
			
			if (userId.length == 0) {
				$('#idMsg').text('아이디를 입력하세요.').css('color', 'red');
				form.userId.focus();
				return;
			}
			
			if (password.length == 0) {
				$('#pwMsg').text('비밀번호를 입력하세요.').css('color', 'red');
				form.password.focus();
				return;
			}
			
			$.ajax ({
				url: '/sch/user/doLogin',
				type: 'get',
				data: {userId: userId, password: password},
				dataType: 'text',
				success: function(response) {
					location.href = '/';
				}, 
				error: function(xhr) {
					alert("아이디 또는 비밀번호가 잘못되었습니다.");
				}
			});
		};
	</script>
	
	<section class="area">
		<div class="table">
			<form name="loginForm">	
				<div class="table-box">
					<tr>
						<td>
							<input class="input" type="text" name="userId" placeholder="아이디"/>
							<div id="idMsg"></div>
						</td>
					</tr>
					<tr>
						<td>
							<input class="input" type="password" name="password" placeholder="비밀번호"/>
							<div id="pwMsg"></div>
						</td>
					</tr>
					<tr>
						<td>
							<button type="button" class="btn btn-neutral" onclick="loginForm()">로그인</button>
						</td>
					</tr>
					<tr>
						<td>
							<button type="button" class="btn btn-neutral" onclick="location.href='/sch/user/join'">회원가입</button>
						</td>	
					</tr>
				</div>	
			</form>
		</div>
	</section>

<%@ include file="/view/sch/common/footer.jsp"%>