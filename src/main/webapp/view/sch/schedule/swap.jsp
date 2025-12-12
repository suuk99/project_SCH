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
	                    <c:forEach var="i" begin="0" end="6">
	                        <div style="width:130px;">
	                            <c:choose>
	                                <c:when test="${days[i] == null}">-</c:when>
	                                <c:otherwise>${days[i]}</c:otherwise>
	                            </c:choose>
	                        </div>
	                    </c:forEach>
	                </div>
	            </c:forEach>
	        </div>
	
	        <div class="function-area" style="margin-top: 90px;">
	            <div class="functi" style="display: flex; justify-content: space-between; margin: 13px 19%;">
	                <div id="swap-time" class="tap-item" style="font-size: 23px; background-color: #282929; color: white; width: 100%; border-radius: 6px 6px 0 0; padding: 5px 0;">대타 요청</div>
	            </div>
	        </div>
	
	        <div class="info-input" style="background-color: #fafbfc; margin: 0 19%; height: 230px; border-radius: 0 0 6px 6px;">
	            <div id="swap-form" class="tab-content-item">
	
	                <div class="desired-date" style="font-size: 18px; font-weight: bold; padding-top: 40px;">
	                    대타 희망일 선택
	                    <select class="select" name="swapDate" style="width: 177px; height: 36px;">
	                        <option value="">선택</option>
	                        <c:forEach var="d" items="${weekDates}">
	                            <option value="${d}">${d}</option>
	                        </c:forEach>
	                    </select>
	                </div>
	
	                <div class="user" style="font-size: 18px; font-weight: bold; margin-top: 45px;">
	                    대타 요청자 선택
	                    <select class="select" name="swapUser" id="user" style="width: 177px; height: 36px;">
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
		    // ======================
		    // 1. JSP에서 scheduleMap 생성 (사용자별 근무시간)
		    // ======================
		    const scheduleMap = {};
		    <c:forEach var="part" items="${scheduleList}">
		        scheduleMap["${part.key}"] = [];
		        <c:forEach var="day" items="${part.value}">
		            scheduleMap["${part.key}"].push("${day != null ? day : ''}");
		        </c:forEach>
		    </c:forEach>
		
		    // ======================
		    // 2. 버튼 클릭 이벤트
		    // ======================
		    $('#swapBtn').click(function() {
		        const weekStart = '${selectWeek}'; // 선택된 주
		        const swapDate = $('select[name="swapDate"]').val(); // 실제 날짜
		        const targetName = $('#user option:selected').text(); // 선택한 사용자
		        const requester = '${loginUserName}'; // 요청자
		
		        // 선택 검증
		        if(!swapDate || !targetName){
		            alert('날짜와 사용자를 선택해주세요.');
		            return;
		        }
		
		        // 선택한 날짜의 요일 계산 (0:일요일, 1:월요일,...)
		        const dayIndex = new Date(swapDate).getDay();
		        const weekDay = dayIndex === 0 ? 7 : dayIndex;
		
		        // 선택한 사용자의 근무 확인
		        const targetTime = scheduleMap[targetName][weekDay - 1];
		        if(targetTime){
		            alert('해당 사용자는 선택한 날에 이미 근무가 존재해 대타 요청이 불가합니다.');
		            return;
		        }
		
		        // 요청자의 근무시간 확인
		        const defaultTime = scheduleMap[requester][weekDay - 1];
		        if(!defaultTime || !defaultTime.includes('~')){
		            alert('요청자의 근무시간을 불러올 수 없습니다.');
		            return;
		        }
		
		        const [startTime, endTime] = defaultTime.split('~');
		
		        // ======================
		        // 3. AJAX 요청
		        // ======================
		        $.ajax({
		            url: '/sch/schedule/swap/request',
		            method: 'post',
		            contentType: 'application/json',
		            data: JSON.stringify({
		                requester: requester,
		                target: targetName,
		                weekStart: weekStart,  // 기존 weekStart
		                weekDate: weekDay,     // 요일 (1~7)
		                startTime: startTime,
		                endTime: endTime,
		                swapDate: swapDate      // 실제 날짜 전달
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
