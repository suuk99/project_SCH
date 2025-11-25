<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="비밀번호 변경" />

<%@ include file="/view/sch/common/header2.jsp"%>
	
	<script>
		const changeForm = function(form) {
			form.nowPw.value = form.nowPw.value.trim();
			form.newPw.value = form.newPw.value.trim();
			form.checkPw.value = form.checkPw.value.trim();
			form.password.value = form.password.value.trim();
			
			if (form.nowPw.value.length == 0) {
				alert('현재 비밀번호를 입력하세요');
				form.nowPw.focus();
				return false;
			}
			
			if (form.nowPw.value != form.password.value) {
				alert('현재 비밀번호가 일치하지 않습니다.');
				form.nowPw.focus();
				return false;
			}
			
			if (form.newPw.value.length == 0) {
				alert('새 비밀번호를 입력하세요');
				form.newPw.focus();
				return false;
			}
			
			if (form.checkPw.value.length == 0) {
				alert('새 비밀번호를 입력하세요');
				form.checkPw.focus();
				return false;
			}
			
			if (form.newPw.value != form.checkPw.value) {
				alert('새 비밀번호가 일치하지 않습니다.');
				form.newPw.value = "";
				form.checkPw.value = "";
				form.newPw.focus();
				return false;
			}
			
			if (form.newPw.value.length < 5 || form.checkPw.value.length < 5) {
				alert('비밀번호는 5자 이상이어야 합니다.');
				form.newPw.value = "";
				form.checkPw.value = "";
				form.newPw.focus();
				return false;
			}
			return true;
		}

	</script>
	
	<section class="area">
		<div class="table">
			<form action="/sch/user/doChangePw" method="post" onsubmit="return changeForm(this);">
				<div class="table-box">
					<div style="font-size: 23px; font-weight: bold; margin-bottom: 27px;">비밀번호 변경</div>
					<tr>
						<td>
							<input class="input" type="password" name="nowPw" id="nowPw" placeholder="현재 비밀번호" />
							<div></div>
						</td>
					</tr>
					<tr>
						<td>
							<input class="input" type="password" name="newPw" id="newPw" placeholder="새 비밀번호 (5자이상 입력)" />
							<div></div>
						</td>
					</tr>
					<tr>
						<td>
							<input class="input" type="password" name="checkPw" id="checkPw" placeholder="새 비밀번호 확인" />
							<div></div>
						</td>
					</tr>
					<tr>
						<button class="btn btn-neutral" id="loginBtn">변경하기</button>
					</tr>
				</div>
			</form>
		</div>
	</section>

<%@ include file="/view/sch/common/footer.jsp"%>