<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="회원가입" />

<%@ include file="/view/sch/common/header.jsp"%>
	<script>
		let validLoginId = null;
		
		//회원가입 최종 검증
		const joinForm = function(form) {
			form.userId.value = form.userId.value.trim();
			form.password.value = form.password.value.trim();
			form.checkPw.value = form.checkPw.value.trim();
			form.name.value = form.name.value.trim();
			
			if (form.userId.value.length == 0) {
				alert('아이디를 입력하세요.');
				form.userId.focus();
				return false;
			}
			
			if (form.password.value.length == 0) {
				alert('비밀번호를 입력하세요');
				form.password.focus();
				return false;
			}
			
			if (form.name.value.length == 0) {
				alert('이름을 입력하세요.');
				form.name.focus();
				return false;
			}
			
			if (form.checkPw.value != form.password.value) {
				alert('비밀번호가 일치하지 않습니다.');
				form.checkPw.focus();
				return false;
			}
			
			if (form.userId.value != validLoginId) {
				alert('이미 사용중인 아이디입니다.');
				form.userId.value = "";
				form.userId.focus();
				return false
			}
			
			if (form.sex.value == "0") {
				alert('성별을 선택하세요.');
				form.sex.focus();
				return false;
			}
			return true;
		}
		
		//아이디 중복 확인
		const loginIdChk = function(el) {
			el.value = el.value.trim();
			const form = document.forms[0];
			let msg = $('#msg');
			
			if (el.value.length == 0) {
				msg.removeClass('text-green-500');
				msg.addClass('text-red-500');
				msg.html('아이디를 입력하세요.');
				return;
			}
			
			$.ajax({
				url: '/sch/user/userIdChk',
				type: 'get',
				data: {
					userId : el.value
				},
				dataType: 'json',
				success: function(data) {
					if (data.rsCode.startsWith("S-")) {
						msg.removeClass('text-red-500');
						msg.addClass('text-green-500');
						msg.html(data.rsMsg);
						validLoginId = el.value;
					} else {
						msg.removeClass('text-green-500');
						msg.addClass('text-red-500');
						msg.html(data.rsMsg);
						validLoginId = null;
					}
				},
				error: function(xhr, status, error) {
					console.log(error);
				}
			});
		}
		
		//비밀번호 확인
		const passwordChk = function(el) {
			el.value = el.value.trim();
			let msg = $('#pwMsg');
			
			$.ajax({
				url: '/sch/user/passwordChk',
				type: 'get',
				data: {password: el.value},
				dataType: 'json',
				success: function(data) {
					if(data.rsCode.startsWith("S-")) {
						msg.removeClass('text-red-500');
						msg.addClass('text-green-500');
						msg.html(data.rsMsg);
					} else {
						msg.removeClass('text-green-500');
						msg.addClass('text-red-500');
						msg.html(data.rsMsg);
					}
				}
			});
		};
			
		//비밀번호 일치 확인
		const checkPwMatch = function(el) {
			let pw = document.forms[0].password.value.trim();
			let checkPw = el.value.trim();
			let msg = $('#chekcPwMsg');
			
			$.ajax({
				url: '/sch/user/checkPw',
				type: 'get',
				data: {password: pw, checkPw: checkPw},
				dataType: 'json',
				success: function(data) {
					if(data.rsCode.startsWith("S-")) {
						msg.removeClass('text-red-500');
						msg.addClass('text-green-500');
						msg.html(data.rsMsg);
					} else {
						msg.removeClass('text-green-500');
						msg.addClass('text-red-500');
						msg.html(data.rsMsg);
					}
				}
			});
		}
		
		const nameChk = function(el) {
			let msg = $('#nameMsg');
			
			$.ajax({
				url: '/sch/user/nameChk',
				type: 'get',
				data: {name: el.value.trim()},
				dataType: 'json',
				success: function(data) {
					if(data.rsCode.startsWith("S-")) {
						msg.removeClass('text-red-500');
						msg.addClass('text-green-500');
						msg.html(data.rsMsg);
					} else {
						msg.removeClass('text-green-500');
						msg.addClass('text-red-500');
						msg.html(data.rsMsg);
					}
				}
			});
		}
		
		const sexChk = function(el) {
			let msg = $('#sexMsg');
			
			$.ajax({
				url: '/sch/user/sexChk',
				type: 'get',
				data: {sex:el.value},
				dataType: 'json',
				success: function(data) {
					if(data.rsCode.startsWith("S-")) {
						msg.removeClass('text-red-500');
						msg.addClass('text-green-500');
						msg.html(data.rsMsg);
					} else {
						msg.removeClass('text-green-500');
						msg.addClass('text-red-500');
						msg.html(data.rsMsg);
					}
				}
			});
		}
	</script>

	<section class="area">
		<div class="table">
			<form action="/sch/user/doJoin" method="post" onsubmit="return joinForm(this);">
				<div class="table-box">
					<tr>
						<td>
							<input class="input" type="text" name="userId" placeholder="아이디" onblur="loginIdChk(this);" />
							<div id="msg"></div>
						</td>
					</tr>
					<tr>
						<td>
							<input class="input" type="password" name="password" placeholder="비밀번호" onblur="passwordChk(this);"/>
							<div id="pwMsg"></div>
						</td>
					</tr>
					<tr>
						<td>
							<input class="input" type="password" name="checkPw" placeholder="비밀번호 확인"  onblur="checkPwMatch(this);"/>
							<div id="chekcPwMsg"></div>
						</td>
					</tr>
					<tr>
						<td>
							<input class="input" type="text" name="name" placeholder="이름" onblur="nameChk(this);" />
							<div id="nameMsg"></div>
						</td>
					</tr>
					<tr>
						<td>
							<select class="select" name="sex" id="sex" onblur="sexChk(this);">
								<option disabled selected value="0">성별을 선택하세요</option>
								<option value="male">남자</option>
								<option value="female">여자</option>
							</select>
							<div id="sexMsg"></div>
						</td>
					</tr>
					<tr>
						<button class="btn btn-neutral">가입 요청</button>
					</tr>
				</div>
			</form>	
		</div>
	</section>
<%@ include file="/view/sch/common/footer.jsp"%>