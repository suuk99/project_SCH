<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="대타 신청" />

<%@ include file="/view/sch/common/header2.jsp"%>

	<section>
	    <div class="table" style="width:1500px; margin-top: 120px; margin-left: auto; margin-right: auto;">
	        <div class="pageName" style="font-size:28px; font-weight:bold; margin-bottom:25px; margin-right: 54%;">대타 신청</div>
	
	        <div style="margin-left:64%; display:flex; margin-bottom:25px;">
	            <div style="padding: 2px 6px; margin-right: 5px; border-radius: 3px;font-size:15px; background-color: #f7f7f7;">주 선택</div>
	            <select name="week" onchange="location.href='?week=' + this.value;">
	                <c:forEach var="week" items="${weekList}">
	                    <option value="${week.start}" <c:if test="${selectWeek == week.start}">selected</c:if>>
	                        ${week.display}
	                    </option>
	                </c:forEach>
	            </select>
	        </div>
	
	        <div class="top-name" style="display:flex; justify-content:space-between; font-size:17px; font-weight:600; margin:9px 19%; border-bottom:1px solid #dedede;">
	            <div style="width:100px;"></div>
	            <div style="width:130px;">월요일</div>
	            <div style="width:130px;">화요일</div>
	            <div style="width:130px;">수요일</div>
	            <div style="width:130px;">목요일</div>
	            <div style="width:130px;">금요일</div>
	            <div style="width:130px;">토요일</div>
	            <div style="width:130px;">일요일</div>
	        </div>
	
	        <div class="content">
	            <c:forEach var="part" items="${scheduleList}">
	                <c:set var="userName" value="${part.key}" />
	                <c:set var="days" value="${part.value}" />
	
	                <div style="display:flex; justify-content:space-between; margin:13px 19%; font-size:17px;">
	                    <div style="width:100px; font-weight: bold;">${userName}</div>
	                    <div style="width:130px;"><c:choose><c:when test="${days[0] == null}">-</c:when><c:otherwise>${days[0]}</c:otherwise></c:choose></div>
			            <div style="width:130px;"><c:choose><c:when test="${days[1] == null}">-</c:when><c:otherwise>${days[1]}</c:otherwise></c:choose></div>
			            <div style="width:130px;"><c:choose><c:when test="${days[2] == null}">-</c:when><c:otherwise>${days[2]}</c:otherwise></c:choose></div>
			            <div style="width:130px;"><c:choose><c:when test="${days[3] == null}">-</c:when><c:otherwise>${days[3]}</c:otherwise></c:choose></div>
			            <div style="width:130px;"><c:choose><c:when test="${days[4] == null}">-</c:when><c:otherwise>${days[4]}</c:otherwise></c:choose></div>
			            <div style="width:130px;"><c:choose><c:when test="${days[5] == null}">-</c:when><c:otherwise>${days[5]}</c:otherwise></c:choose></div>
			            <div style="width:130px;"><c:choose><c:when test="${days[6] == null}">-</c:when><c:otherwise>${days[6]}</c:otherwise></c:choose></div>
	                </div>
	            </c:forEach>
	        </div>
	
	        <div class="function-area" style="margin-top: 90px;">
	        	<div class="functi" style="display: flex; justify-content: space-between; margin: 13px 19%;">
	        		<div id="swap-time" class="tap-item" style="font-size: 23px; background-color: #282929; color: white; width: 100%; border-radius: 6px 6px 0 0; padding: 5px 0;">대타  요청</div>
	        	</div>
	        </div>
	        
	        <div class="info-input" style="background-color: #fafbfc; margin: 0 19%; height: 230px; border-radius: 0 0 6px 6px;">
                <div id="swap-form" class="tab-content-item">
                
                	<div class="desired-date" style="font-size: 18px; font-weight: bold; padding-top: 40px;">대타 희망일 선택<span style="margin-right: 60px;"></span>
	               		<select class="select" name="swapDate" style="width: 177px; height: 36px;">
	               			<option value="">선택</option>
		                	<c:forEach var="d" items="${weekDates}">
	                			<option value="${d}">${d}</option>
		                	</c:forEach>
	               		</select>
                	</div>
                	
                	<div class="user" style="font-size: 18px; font-weight: bold; margin-top: 45px;">대타 요청자 선택<span style="margin-right: 60px;"></span>
	                		<select class ="select" name="swapUser" id="user" style="width: 177px; height: 36px;">
	                			<option value="">선택</option>
	                			<c:forEach var="u" items="${userList}">
		                			<option value="${u.userId}">${u.name}</option>
	                			</c:forEach>
	                		</select>
                	</div>
                	
                </div>
	        </div>
	        
	        <div class="btn-area" style="margin-top: 40px; margin-bottom: 200px;">
			    <button class="btn btn-neutral" id="swapBtn" style="width:170px;">요청하기</button>
			</div>
	        
	    </div>
	</section>
	
	<script>
		$(document).ready(function() {
		    // JSP에서 scheduleMap을 JS 객체로 생성
		 const scheduleMap = {};
		<c:forEach var="part" items="${scheduleList}">
		    scheduleMap["${part.key}"] = [];
		    <c:forEach var="day" items="${part.value}">
		        scheduleMap["${part.key}"].push("${day}");
		    </c:forEach>
		</c:forEach>
	
		    $('#swapBtn').click(function() {
		        const weekStart = '${selectWeek}';
		        const swapDate = $('select[name="swapDate"]').val();
		        const targetName = $('#user option:selected').text();
		        const requester = '${loginUserName}';
	
		        if(!swapDate || !targetName){
		            alert('날짜와 사용자를 선택해주세요.');
		            return;
		        }
	
		        const dayIndex = new Date(swapDate).getDay();
		        const weekDay = dayIndex === 0 ? 7 : dayIndex;
		        const timeStr = scheduleMap[targetName][weekDay - 1];
	
		        if(timeStr){
		            alert('해당 사용자는 선택한 날에 이미 근무가 존재해 대타 요청이 불가합니다.');
		            return;
		        }
	
		        const startTime = '00:00';
		        const endTime = '00:00';
	
		        $.ajax({
		            url: '/sch/schedule/swap/request',
		            method: 'post',
		            contentType: 'application/json',
		            data: JSON.stringify({
		                requester: requester,
		                target: targetName,
		                weekStart: weekStart,
		                weekDate: weekDay,
		                startTime: startTime,
		                endTime: endTime
		            }),
		            success: function(result) {
		                alert('대타 요청이 완료되었습니다');
		                location.reload();
		            },
		            error: function() {
		                alert('오류가 발생했습니다.');
		            }
		        });
		    });
		});
	</script>
	
<%@ include file="/view/sch/common/footer.jsp"%>