<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="main" />

<%@ include file="/view/sch/common/header2.jsp"%>

<section style="margin-top: 150px; margin-left: auto; margin-right: auto; width: 70%; background-color: red;">
	<div>
		<img src="/resource/images/img/111.png">
	 	<img src="/resource/images/img/111.png">
	</div>
	
	<div style="display: flex;">
		<div><a href="/sch/notice/write">글쓰기</a></div>
		<div><a href="/sch/notice/list">공지사항 </a></div>
	</div>
</section>

<%@ include file="/view/sch/common/footer.jsp"%>