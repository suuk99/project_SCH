<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="SCHM"/>

<%@ include file="/view/sch/common/header.jsp"%>

	<script>
		const loginForm = function(form) {
			form.userId.value = form.userId.value.trim();
			form.password.value = form.password.value.trim();
			
			if (form.userId.value.length == 0) {
				alert('아이디를 입력하세요.');
				form.userId.focus();
				return false;
			}
			
			if (form.password.value.length == 0) {
				alert('비밀번호를 입력하세요.');
				form.password.focus();
				return false;
			}
			
			let validLoginMsg = $('#validLoginMsg');
			
			$.ajax ({
				url: '/sch/user/validLogin',
				type: 'post',
				data: {
					userId: form.userId.value,
					password: form.password.value
				},
				dataType: 'json',
				success: function(data) {
					if (data.rsCode.startsWith("F-")) {
						validLoginMsg.addClass('text-red-500');
						validLoginMsg.html(data.rsMsg);
					} else {
						validLoginMsg.removeClass('text-red-500');
						validLoginMsg.empty();
						$(form).append(`<input type="hidden" name="loginUserId" value="${data.rsData}" />`);
						form.submit();
					}
				},
				error: function(xhr,status, error) {
					console.log(error)
				}
			})
		}
	</script>
	
	<section class="area">
		<div class="table_login">
			<form action="/sch/user/doLogin" method="post" onsubmit="loginForm(this); return false;">	
				<div class="table-box">
					<div class="logo_login">SCHM</div>
					<tr>
						<td>
							<input class="input" id="input" type="text" name="userId" placeholder="아이디"/>
						</td>
					</tr>
					<tr>
						<td>
							<input class="input" id="input" type="password" name="password" placeholder="비밀번호"/>
						</td>
					</tr>
					<tr>
						<td>
							<div class="message" id="validLoginMsg"></div>
							<button class="btn btn-neutral">로그인</button>
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