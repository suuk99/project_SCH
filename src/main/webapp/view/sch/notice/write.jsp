<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="공지사항 작성" />
<%@ include file="/view/sch/common/header2.jsp"%>

	<script>
		const writeForm = function(form) {
			form.title.value = form.title.value.trim();
			form.content.value = form.content.value.trim();
			
			if (form.title.value.length == 0) {
				alert('제목을 입력하세요.');
				form.title.focus();
				return false;
			}
			
			if (form.content.value.length == 0) {
				alert('내용을 입력하세요.');
				form.content.focus();
				return false;
			}
			return true;
		}
	</script>
	
	<section>
		<div style="margin-top: 120px; width: 600px; margin-right: auto; margin-left: auto;">
			<form action="/sch/notice/doWrite" method="post" onsubmit="return writeForm(this);">
				<div style="font-size: 26px; font-weight: bold; text-align: left; margin-bottom: 20px; border-bottom: 1px solid #dedede; padding: 10px 0;">
				공지사항 작성</div>
				<div class="table-box">
	                <div>
	                    <input class="input" type="text" name="title" placeholder="제목을 입력하세요." style="width: 600px;" />
	                    <div style="margin-bottom: 25px;"></div>
	                </div>
	                <div>
	                    <textarea class="textarea" name="content" placeholder="내용을 입력하세요." style="width: 600px; height: 400px;"></textarea>
	                    <div style="margin-bottom: 10px;"></div>
	                </div>
	                <div style="text-align: right;">
    					<button class="btn btn-neutral" style="width: 70px;">등록</button>
					</div>
				</div>
			</form>
		</div>
	</section>
<%@ include file="/view/sch/common/footer.jsp"%>