<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="가입요청 확인" />

<%@ include file="/view/sch/common/header2.jsp"%>
	
	<section style="display: flex; justify-content: center; margin-top: -50px;">
	    <div class="table" style="width: 90%; max-width: 1100px;">
	        <div class="pageName" style="font-size:28px; font-weight:bold; margin-bottom:22px; text-align: left; margin-left: 14.2%;">가입요청 확인</div>
	
	        <div class="area-box" style="display: flex; justify-content: center; flex-wrap: wrap; gap: 20px; margin-bottom: 50px;">
	            <div class="area-1" style="width: 100%; max-width: 800px;">
	                <div class="request-list" style="border-bottom: 1px solid #dedede; font-size: 21px; font-weight: bold;"></div>
	                <div style="margin-top: 30px;"></div>
					<c:if test="${empty requests}">
						<div style="font-size: 14px;">
							신규 회원가입 요청이 없습니다.
						</div>
					</c:if>
	                <c:forEach var="req" items="${requests}">
	                  <div class="request-content" style="font-size: 17px; text-align: left; margin-bottom: 15px;">
					     <div><span style="font-weight: bold; margin-right: 24px;">이 름</span> ${req.name}</div>
					     <div><span style="font-weight: bold; margin-right: 12px;">아이디</span> ${req.userId}</div>
					     <div><span style="font-weight: bold; margin-right: 13px;">연락처</span> ${req.phoneNum}</div>
					     <div><span style="font-weight: bold; margin-right: 13px;">가입일</span> ${req.regDate}</div>
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
		    // 승인 버튼
		    $('.o').click(function() {
		        const id = $(this).data('id');
	
		        $.ajax({
		            url:'/sch/user/approve',
		            method: 'post',
		            contentType: 'application/json',
		            data: JSON.stringify({id: id}),
		            success: function(res) {
		                alert('가입 요청을 승인했습니다.');
		                location.reload();
		            }
		        });
		    });
	
		    // 거절 버튼
		    $('.x').click(function() {
		        const id = $(this).data('id');
	
		        $.ajax({
		            url:'/sch/user/reject',
		            method: 'post',
		            contentType: 'application/json',
		            data: JSON.stringify({id: id}),
		            success: function(res) {
		                alert('가입 요청을 거절했습니다.');
		                location.reload();
		            }
		        });
		    });
		});
	</script>
<%@ include file="/view/sch/common/footer.jsp"%>