<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="pageTitle" value="${notice.title}" />

<%@ include file="/view/sch/common/header2.jsp"%>

	<section>
		<div style="margin-top: 120px; width: 800px; margin-right: auto; margin-left: auto;">
			<div style="text-align: left;">
				<div style="font-size: 33px; font-weight: bold;">${notice.title }</div>
				<div style="font-weight: bold;"><i class="fa-solid fa-user"></i> ${notice.writerName }</div>
				<div>&nbsp; &nbsp; &nbsp; &nbsp;${notice.regDate } &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  조회수 ${notice.hit }</div>
				<div style="margin: 5px 0; border-bottom: 1px solid #dedede;"></div>
			</div>
		</div>
	</section>
<%@ include file="/view/sch/common/footer.jsp"%>