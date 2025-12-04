<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<c:set var="pageTitle" value="스케줄 작성" />
<%@ include file="/view/sch/common/header2.jsp"%>

	<section>
	    <div class="table" style="width:1500px; margin-top: 120px; margin-left: auto; margin-right: auto;">
	        <div class="pageName" style="font-size:28px; font-weight:bold; margin-bottom:25px; margin-right: 53%;">스케줄 작성</div>
	
	        <div style="margin-left:61.5%; display:flex; margin-bottom:25px;">
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
	
	                <div class="user-row" data-user="${userName}" style="display:flex; justify-content:space-between; margin:13px 19%; font-size:17px;">
	                    <div style="width:100px; cursor: pointer; font-weight: bold;">${userName}</div>
	                    <div style="width:130px;"><c:choose><c:when test="${days[0] == null}">-</c:when><c:otherwise>${days[0]}</c:otherwise></c:choose></div>
			            <div style="width:130px;"><c:choose><c:when test="${days[1] == null}">-</c:when><c:otherwise>${days[1]}</c:otherwise></c:choose></div>
			            <div style="width:130px;"><c:choose><c:when test="${days[2] == null}">-</c:when><c:otherwise>${days[2]}</c:otherwise></c:choose></div>
			            <div style="width:130px;"><c:choose><c:when test="${days[3] == null}">-</c:when><c:otherwise>${days[3]}</c:otherwise></c:choose></div>
			            <div style="width:130px;"><c:choose><c:when test="${days[4] == null}">-</c:when><c:otherwise>${days[4]}</c:otherwise></c:choose></div>
			            <div style="width:130px;"><c:choose><c:when test="${days[5] == null}">-</c:when><c:otherwise>${days[5]}</c:otherwise></c:choose></div>
			            <div style="width:130px;"><c:choose><c:when test="${days[6] == null}">-</c:when><c:otherwise>${days[6]}</c:otherwise></c:choose></div>
	                </div>
					
					<div class="work" style="margin-bottom: 40px;">
		                <div style="margin-left: 67px;"> 
		                	<span style="font-weight: bold">근무</span>
		                	<c:forEach begin="1" end="7" var="i">
		                		<select class="select" name="" id="" style="width: 105px; height: 26px; margin: 3px 5px;">
		                			<option value="0" selected>근무 여부</option>
		                			<option value="yes">근무</option>
		                			<option value="no">휴무</option>
		                		</select>
		                	</c:forEach>
		                </div>
		                <div class="sub-row" id="sub-${userName}" style="margin-left: 67px;"> 
		                	<span style="font-weight: bold">출근</span>
					        <c:forEach begin="1" end="7" var="i">
					        	<input class="input" type="time" name="start_${userName}_${i}" style="width: 105px; height: 26px; margin: 3px 5px;">
					        </c:forEach>
		                </div>
		                <div style="margin-left: 67px;"> 
		                	<span style="font-weight: bold">퇴근</span>
		                	<c:forEach begin="1" end="7" var="i">
					        	<input class="input" type="time" name="end_${userName}_${i}" style="width: 105px; height: 26px; margin: 3px 5px;">
					        </c:forEach>
		                </div>
					</div>
	            </c:forEach>
	        </div>
	
	        <div style="display: flex; justify-content: center; bottom: 220px; margin-left: auto; margin-right: auto; margin-top: 40px; margin-bottom: 100px; width: 170px;">
	        	<div>
		            <button class="btn btn-neutral" id="saveBtn" style="width:150px; margin-right: 60px;">스케줄 저장</button>
	        	</div>
	        	<div>
		            <button class="btn btn-neutral" id="regisBtn" style="width:150px;">스케줄 등록</button>
	        	</div>
	        </div>
	    </div>
	</section>

	<script>
		$(document).ready(function() {
		    // 처음에는 .work 숨기기
		    $(".work").hide();
		
		    // 사용자 이름 클릭 시 해당 .work 토글
		    $(".user-row > div:first-child").click(function() {
		        // 클릭한 사용자 이름 가져오기
		        const userName = $(this).text().trim();
		        // 해당 사용자의 work 영역 토글
		        $("#sub-" + userName).closest(".work").slideToggle(200);
		    });
		    
		  //페이지 로드 시 로컬스토리지에서 불러옴
			const week = $('select[name="week"]').val();
			const saveData = localStorage.getItem('schedule_' + week);
				
			if(saveData) {
			    const data = JSON.parse(saveData);
			    for(const user in data) {
			        const workDiv = $('#sub-' + user).closest('.work');
			        workDiv.find(".select").each((i, el) => {
			            const val = data[user].days[i];
			            $(el).val(val);

			            // 근무 여부에 따른 input 활성화/비활성화
			            const isWorking = val === 'yes';
			            const startInput = workDiv.find('.sub-row input').eq(i);
			            const endInput = workDiv.find('div:has(span:contains("퇴근")) input').eq(i);

			            startInput.prop('disabled', !isWorking);
			            endInput.prop('disabled', !isWorking);

			            if(!isWorking){
			                startInput.val('');
			                endInput.val('');
			            }
			        });

			        workDiv.find(".sub-row input").each((i, el) => $(el).val(data[user].startTimes[i]));
			        workDiv.find("div:has(span:contains('퇴근')) input").each((i, el) => $(el).val(data[user].endTimes[i]));
			    }
			}
		});
		
		function collectScheduleData() {
			let scheduleData = {};
			
			$('.user-row').each(function() {
				const userName = $(this).data('user');
				let days = [];
				
				$(this).next('.work').find('.select').each(function() {
					days.push($(this).val());
				});
				
				let startTimes = [];
				let endTimes = [];
				
				$(this).next('.work').find('.sub-row input').each(function() {
					startTimes.push($(this).val());
				});
				$(this).next('.work').find('div:has(span:contains("퇴근")) input').each(function() {
					endTimes.push($(this).val());
				});		
				
				scheduleData[userName] = {days, startTimes, endTimes};
			});
			
			return scheduleData;
		}
		
		//근무여부에 따른 시간 입력 활성화
		$('.work .select').change(function() {
			const workSelect = $(this);
			const isWorking = workSelect.val() == 'yes';
			const workDiv = workSelect.closest('.work');
			const index = workDiv.find('.select').index(workSelect);
			const startInput = workDiv.find('.sub-row input').eq(index);
			const endInput = workDiv.find('div:has(span:contains("퇴근")) input').eq(index);
			
			//근무면 활성화, 휴무이면 비활성화 + 값 초기화
			startInput.prop('disabled', !isWorking);
			endInput.prop('disabled', !isWorking);
			
			if(!isWorking) {
				startInput.val('');
				endInput.val('');
			}
		});
		
		//저장버튼 클릭 시
		$('#saveBtn').click(function() {
			const week = $('select[name="week"]').val(); //선택한 주
			const data = collectScheduleData();
			localStorage.setItem('schedule_' + week, JSON.stringify(data));
			alert('저장이 완료되었습니다.');
		});
		
		//등록버튼
		$('#regisBtn').click(function(e) {
			e.preventDefault(); //새로고침 방지
			const week = $('select[name="week"]').val();
			const data = collectScheduleData();
			
			let formData = {weekStart: week};
			
			for(const user in data) {
				for(let i = 0; i < 7; i++) {
					formData[`start_${user}_${i+1}`] = data[user].startTimes[i];
					formData[`end_${user}_${i+1}`] = data[user].endTimes[i];
				}
			}
			console.log(formData);
			$.post('/sch/admin/saveSchedule', formData, function(result){
			       alert('스케줄 등록이 완료되었습니다.');
		    });
		});
	</script>

<%@ include file="/view/sch/common/footer.jsp"%>
