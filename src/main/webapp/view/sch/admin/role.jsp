<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="권한 변경" />

<%@ include file="/view/sch/common/header2.jsp"%>

	<script>
		function setRole() {
			$.ajax({
				url: '/sch/admin/role',
				type: 'post',
				data: {
					userId: $('#userId').val(),
					role: $('#role').val()
				},
				success: function() {
					if (res == "success") {
						alert('사용자의 권한 변경이 완료되었습니다.');
					}
				}
			});
		}
	</script>
	
	<section class="area">
		<div class="table">
			<div class="table-box">
				<div>사용자 권한 변경</div>
				 <tr>
				 	<td>
						<input class="ipnut" type="text" name="userId" placeholder="사용자 아이디를 입력하세요. " />
						<div></div>				 	
				 	</td>
				 </tr>
				 <tr>
				 	<td>
				 		<select class="select" name="role" id="role">
				 			<option disabled selected value="0">권한을 선택하세요</option>
				 			<option value="user">일반 사용자</option>
				 			<option value="admin">관리자</option>
				 		</select>
				 	</td>
				 </tr>
				 <tr>
				 	<button class="btn btn-neutral">변경 완료</button>
				 </tr>
			</div>	 
		</div>
	</section>

<%@ include file="/view/sch/common/footer.jsp"%>