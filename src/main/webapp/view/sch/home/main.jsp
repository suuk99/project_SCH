<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="main" />

<%@ include file="/view/sch/common/header2.jsp"%>

	<section>
		<div class="table" style="margin-top: 200px; margin-left: auto; margin-right: auto; width: 1500px;;">
			<div style="margin-left: auto; margin-right: auto;">
				<img src="${pageContext.request.contextPath}/resource/img/111.png">
			</div>
			
			<div style="display: flex;">
				<div><a href="/sch/notice/write">글쓰기</a></div>
				<div><a href="/sch/notice/list">공지사항 </a></div>
			</div>
		</div>
	</section>

<%@ include file="/view/sch/common/footer.jsp"%>