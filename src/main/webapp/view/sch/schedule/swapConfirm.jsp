<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="대타요청 확인" />

<%@ include file="/view/sch/common/header2.jsp"%>
	
	<section>
		<div class="table" style="width: 1200px; margin-top: 120px; margin-left: auto; margin-right: auto;">
			<div class="pageName" style="font-size:28px; font-weight:bold; margin-bottom:25px; margin-right: 49.5%; ">대타요청 확인</div>
			<div class="area-box" style="display:flex; justify-content: space-around; margin: 0 16.7%; margin-bottom: 250px;">
				<div class="area-1" style="width: 93.6%;">
					<div class="request-list" style="border-bottom: 1px solid #dedede; font-size: 21px; font-weight: bold;"></div>
						<div style="margin-top: 50px;"></div>
						<c:forEach var="req" items="${requests}">
							<div class="request-content" style="font-size: 17px; text-align: left; margin-left: 21px;">
								<div><span style="font-weight: bold; margin-right: 19px;">요 청 자</span> ${req.requester}</div>
						        <div><span style="font-weight: bold; margin-right: 13px;">요청일자</span> ${req.swapDate}</div>
						        <div><span style="font-weight: bold; margin-right: 13px;">근무시간</span> ${req.startTimeStr} ~ ${req.endTimeStr}</div>
					        </div>
					        
							<div class="btn-area" style="text-align: right; margin-bottom: 30px; margin-right: 15px;">
								<button class="o btn btn-neutral" data-id="${req.id}" style="width: 60px; height: 30px; background-color: #4c66cf; border:0px; box-shadow: none; color: white;">수락</button>
								<button class="x btn btn-neutral" data-id="${req.id}" style="width: 60px; height: 30px; background-color: #d64f4d; border:0px; box-shadow: none; color: white;">거절</button>
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