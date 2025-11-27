<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="pageTitle" value="공지사항" />

<%@ include file="/view/sch/common/header2.jsp"%>
	
		<section>
			<div style="margin-top: 120px; width: 800px; margin-right: auto; margin-left: auto;">
			<div style="font-size: 26px; font-weight: bold; margin-bottom: 20px; border-bottom: 1px solid #dedede; padding: 10px 0;">공지사항</div>
				<table style="width:100%; border-collapse: collapse; text-align: center;">
				 	<tr>
		                <th style="padding: 0px 15px 20px 20px; width: 30px;"></th>
		                <th style="padding: 0px 15px 20px 20px; width: 300px;">제목</th>
		                <th style="padding: 0px 15px 20px 20px;">작성자</th>
		                <th style="padding: 0px 15px 20px 20px;">작성일</th>
		                <th style="padding: 0px 15px 20px 20px;">조회수</th>
            		</tr>
					
					<c:forEach var="notice" items="${noticeList}">
						<tr style="border-top: 1px solid #dedede;">
							<td style="padding: 5px 25px;">${notice.id }</td>
							<td style="padding: 5px 25px;"><a href="/sch/notice/detail?id=${notice.id}">${notice.title }</a></td>
							<td style="padding: 5px 25px;">${notice.writerName }</td>
							<td style="padding: 5px 25px;">${fn:substring(notice.regDate,0 ,10) }</td>
							<td style="padding: 5px 25px;">${notice.hit }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</section>
<%@ include file="/view/sch/common/footer.jsp"%>