<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="대타요청 확인" />

<%@ include file="/view/sch/common/header2.jsp"%>
	
	<section style="display: flex; justify-content: center; margin-top: -50px;">
	    <div class="table" style="width: 90%; max-width: 1100px;">
	        <div class="pageName" style="font-size:28px; font-weight:bold; margin-bottom:22px; text-align: left; margin-left: 14.2%;">대타요청 확인</div>
	
	        <div class="area-box" style="display: flex; justify-content: center; flex-wrap: wrap; gap: 20px; margin-bottom: 50px;">
	            <div class="area-1" style="width: 100%; max-width: 800px;">
	                <div class="request-list" style="border-bottom: 1px solid #dedede; font-size: 21px; font-weight: bold;"></div>
	                <div style="margin-top: 30px;"></div>
					<c:if test="${empty requests}">
						<div style="font-size: 14px;">
							대타 요청이 없습니다.
						</div>
					</c:if>
	                <c:forEach var="req" items="${requests}">
	                    <div class="request-content" style="font-size: 17px; text-align: left; margin-bottom: 15px;">
	                        <div><span style="font-weight: bold; margin-right: 19px;">요 청 자</span> ${req.requester}</div>
	                        <div><span style="font-weight: bold; margin-right: 13px;">요청일자</span> ${req.swapDate}</div>
	                        <div><span style="font-weight: bold; margin-right: 13px;">근무시간</span> ${req.startTimeStr} ~ ${req.endTimeStr}</div>
	                    </div>
	
	                    <div class="btn-area" style="text-align: right; margin-bottom: 30px;">
	                        <button class="o btn btn-neutral" data-id="${req.id}" style="width: 60px; height: 30px; background-color: #4c66cf; border:0; box-shadow: none; color: white;">수락</button>
	                        <button class="x btn btn-neutral" data-id="${req.id}" style="width: 60px; height: 30px; background-color: #d64f4d; border:0; box-shadow: none; color: white;">거절</button>
	                    </div>
	                </c:forEach>
	            </div>
	        </div>
	    </div>
	</section>

	
	<script>
		$(document).ready(function() {
			//수락버튼
			$('.o').click(function() {
				const id = $(this).data('id');
				
				$.ajax({
					url:'/sch/schedule/swap/o',
					method: 'post',
					contentType: 'application/json',
					data: JSON.stringify({id: id}),
					success: function(res) {
						alert('대타요청을 수락하셨습니다.');
						location.reload();
					}
				});
			});
			
			//거절버튼
			$('.x').click(function() {
				const id = $(this).data('id');
				
				$.ajax({
					url:'/sch/schedule/swap/x',
					method: 'post',
					contentType: 'application/json',
					data: JSON.stringify({id: id}),
					success: function(res) {
						alert('대타요청을 거절하셨습니다.');
						location.reload();
					}
				});
			});
		});
	</script>
<%@ include file="/view/sch/common/footer.jsp"%>