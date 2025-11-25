<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="내정보" />

<%@ include file="/view/sch/common/header2.jsp"%>
	<section class="area">
		<div class="table">
			<table> 
				<div class="profile" style="font-size: 23px; font-weight: bold; margin-bottom: 15px;">프로필</div>
				<tr>
					<th><i class="fa-solid fa-user"></i></th>
					<td>${user.name}</td>
				</tr>
				<tr>
					<th><i class="fa-solid fa-id-badge"></i></i></th>
					<td>${user.userId}</td>
				</tr>
				<tr>
					<th><i class="fa-solid fa-mobile"></i></th>
					<td>${user.phoneNum.substring(0, 3)}-${user.phoneNum.substring(3, 7)}-${user.phoneNum.substring(7, 11)} </td>
				</tr>
				<tr>
					<th><i class="fa-solid fa-cake-candles"></i></i></th>
					<td>
					${user.birthDate.substring(0, 4)}-${user.birthDate.substring(4, 6)}-${user.birthDate.substring(6, 8)}
					</td>
				</tr>
				<tr>
					<th><i class="fa-solid fa-calendar"></i></i></th>
					<td>
						${user.regDate.substring(0,10)} 
					</td>
				</tr>
				<tr>
					<th><i class="fa-solid fa-key"></i></th>
					<td  style="display: flex; justify-content: space-between; align-items: flex-start;">
						비밀번호
						<button style="width: 60px; " class="btn btn-sm" onclick="location.href='/sch/user/changePw'">변경</button>
					</td>
				</tr>
			</table>
		</div>
	</section>
<%@ include file="/view/sch/common/footer.jsp"%>