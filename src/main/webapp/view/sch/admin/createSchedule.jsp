<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>


<c:set var="pageTitle" value="스케줄 작성" />
<c:set var="jsWeekKey" value="${selectWeek}" />
<%@ include file="/view/sch/common/header2.jsp"%>
	<input type="hidden" id="userId" value="${loginUser != null ? loginUser.userId : ''}">

	<section>
	    <div class="table" style="width:1500px; margin-top: 120px; margin-left: auto; margin-right: auto;">
	        <div class="pageName" style="font-size:28px; font-weight:bold; margin-bottom:25px; margin-right: 53%;">스케줄 작성</div>
	
	        <div style="margin-left:61.5%; display:flex; margin-bottom:25px;">
	            <div style="padding: 2px 6px; margin-right: 5px; border-radius: 3px;font-size:15px; background-color: #f7f7f7;">주 선택</div>
	            <%-- ⭐ (1) ID 추가 및 value="${week.start}"가 비어있지 않은지 서버측에서 확인 완료된 것으로 가정 --%>
	            <select name="week" id="weekSelector" onchange="location.href='?week=' + this.value;">
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
					
					<div class="work" data-user="${userName}" style="margin-bottom: 40px;">
		                <div style="margin-left: 67px;">	
		                	<span style="font-weight: bold">근무</span>
		                	<c:forEach begin="1" end="7" var="i">
		                		<%-- ⭐ (2) off 옵션에서 selected 속성 제거 --%>
		                		<select class="select" name="work_${userName}_${i}" id="" style="width: 105px; height: 26px; margin: 3px 5px;">
		                			<option value="off">근무 여부</option>
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
		// ⭐⭐⭐ 서버 변수를 JavaScript 변수에 직접 할당하여 키 값 오류를 원천 차단 ⭐⭐⭐
		const CURRENT_WEEK_KEY = '${selectWeek}'; 

		// 1. 전역 데이터 캐시 객체 선언 (DOM과 독립된 데이터 모델)
		let scheduleCache = {}; 
		
		// 2. 키를 가져오는 함수 (변수에서 가져오므로 가장 안정적임)
		function getCurrentWeekKey() {
			if (!CURRENT_WEEK_KEY) {
				console.error("Critical Error: 서버 변수 ${selectWeek} 값이 비어있습니다. 로컬 저장소를 사용할 수 없습니다.");
				return "";
			}
			return CURRENT_WEEK_KEY;
		}

		/* -------------------------------
		   헬퍼: 캐시 객체 초기화/생성
		------------------------------- */
		function initializeScheduleCache(users) {
			const cache = {};
			users.forEach(userName => {
				cache[userName] = {
					days: Array(7).fill('off'),
					startTimes: Array(7).fill(''),
					endTimes: Array(7).fill('')
				};
			});
			return cache;
		}

		$(document).ready(function() {
			// localStorage 초기화
			//localStorage.clear();
			
			// 1. 초기 사용자 목록을 기반으로 캐시 초기화
			const userRows = $(".user-row");
			const userList = userRows.map(function() { return $(this).data("user"); }).get();
			scheduleCache = initializeScheduleCache(userList);
		
		    /* -------------------------------
		       1) 사용자 클릭 → 근무 입력 토글
		    ------------------------------- */
		    $(".work").hide();
		    $(".user-row > div:first-child").click(function () {
		        const userName = $(this).closest(".user-row").data("user");
		        $("#sub-" + userName).closest(".work").slideToggle(200);
		    });
		
		    /* -------------------------------
		       2) 근무 여부 변경 → 캐시 업데이트 및 출퇴근 활성/비활성 (핵심)
		    ------------------------------- */
		    $(document).on("change", ".work .select", function () {
		        const workSelect = $(this);
		        const userName = workSelect.closest(".work").data("user");
		        const workDiv = workSelect.closest(".work");
		        const idx = workDiv.find(".select").index(workSelect);
		        
		        const newValue = workSelect.val(); // 사용자가 선택한 정확한 값
		        const isWorking = newValue === "yes";
		        
		        // ⭐ 캐시 업데이트: DOM과 독립적으로 사용자의 선택을 저장
		        if (scheduleCache[userName]) {
		        	scheduleCache[userName].days[idx] = newValue;
		        }

		        // DOM 상태 업데이트 (비활성화)
		        const startInput = workDiv.find(".sub-row input").eq(idx);
		        const endInput = workDiv.find("div:has(span:contains('퇴근')) input").eq(idx);
		
		        startInput.prop("disabled", !isWorking);
		        endInput.prop("disabled", !isWorking);
		
		        // 캐시 및 DOM 값 정리
		        if (!isWorking) {
		            startInput.val("");
		            endInput.val("");
		            if (scheduleCache[userName]) {
		            	scheduleCache[userName].startTimes[idx] = '';
		            	scheduleCache[userName].endTimes[idx] = '';
		            }
		        }
		    });
		    
		    /* -------------------------------
		       2-1) 시간 변경 → 캐시 업데이트 
		    ------------------------------- */
		    $(document).on("change", ".work input[type='time']", function () {
		    	const input = $(this);
		    	const userName = input.closest(".work").data("user");
		    	const workDiv = input.closest(".work");
		    	
		    	// 같은 이름의 input이 start/end 두 줄에 있으므로, index 7을 기준으로 나눕니다.
		    	const inputElements = workDiv.find("input[type='time']");
		    	const inputIndex = inputElements.index(input);
		    	const idx = inputIndex % 7; 
		    	
		    	if (!scheduleCache[userName]) return;
		    	
		    	// input이 start row에 있는지, end row에 있는지 확인하여 캐시 업데이트
		    	
		    	if (inputIndex < 7) { // 0~6 인덱스는 출근(start) 라인
		    		scheduleCache[userName].startTimes[idx] = input.val();
		    	} else { // 7~13 인덱스는 퇴근(end) 라인
		    		scheduleCache[userName].endTimes[idx] = input.val();
		    	}
		    });
		
		    /* -------------------------------
		       3) 로컬스토리지 불러오기
		    ------------------------------- */
		    function loadSchedule() {
		        const weekKey = getCurrentWeekKey();
		        
		        // 키 값이 없으면 로드 시도 안함
		        if (!weekKey) return;
		        
		        const savedData = localStorage.getItem("schedule_" + weekKey);
		
		        // 1. 초기화: 모든 필드를 기본 상태로 설정 (DOM 초기화)
		        $(".work").each(function() {
		            $(this).find(".select").val("off"); 
		            $(this).find(".sub-row input").prop("disabled", true).val("");
		            $(this).find("div:has(span:contains('퇴근')) input").prop("disabled", true).val("");
		        });
		        
		        if (!savedData) return;

		        const data = JSON.parse(savedData);
		        scheduleCache = data; // ⭐ 로컬스토리지 데이터를 캐시에 직접 저장
		        
		        // 2. 캐시 데이터를 바탕으로 DOM 업데이트
		        for (const user in data) {
		            const workDiv = $(`.work[data-user="${user}"]`);
		            if (workDiv.length === 0) continue;
		
		            workDiv.find("select.select").each(function(i) {
		                const val = data[user].days[i];
		                $(this).val(val); 
		
		                const startInput = workDiv.find(".sub-row input").eq(i);
		                const endInput = workDiv.find("div:has(span:contains('퇴근')) input").eq(i);
		
		                const isWorking = (val === "yes");
		                
		                startInput.prop("disabled", !isWorking).val(data[user].startTimes[i] || "");
		                endInput.prop("disabled", !isWorking).val(data[user].endTimes[i] || "");
		            });
		        }
		    }
		
		    // ⭐ DOM 준비 완료 후 즉시 로드 (타이밍 문제 해결)
		    loadSchedule();
		
		    /* -------------------------------
		       4) 전체 근무정보 수집 (캐시에서 데이터 읽기)
		    ------------------------------- */
		    function collectScheduleData() {
		        // 최종 전송 데이터는 DOM이 아닌, 캐시에서 가져옵니다.
		        console.log("최종 수집 데이터 (scheduleCache 객체):", scheduleCache); 
		        return scheduleCache;
		    }
		
		    /* -------------------------------
		       5) 로컬 저장 버튼
		    ------------------------------- */
		    $("#saveBtn").click(function () {
		        const week = getCurrentWeekKey();
		        const data = collectScheduleData();
		        
		        if (!week) return alert("주차 키를 찾을 수 없어 저장할 수 없습니다.");
		        
		        localStorage.setItem("schedule_" + week, JSON.stringify(data));
		        
		        const checkData = localStorage.getItem("schedule_" + week);
		        console.log(`[LocalStorage SAVE] Key: schedule_${week}`);
		        console.log(`[LocalStorage SAVE] 데이터 저장 성공 여부: ${checkData ? '성공 (데이터 발견)' : '실패 (데이터 없음)'}`);
		        
		        alert("저장이 완료되었습니다.");
		    });
		
		    /* -------------------------------
		       6) 서버 등록 버튼
		    ------------------------------- */
		    $("#regisBtn").off("click").on("click", function(e) {
		        e.preventDefault();
		        const weekStart = getCurrentWeekKey();
		        
		        if (!weekStart) return alert("주차 키를 찾을 수 없어 등록할 수 없습니다.");
		        
		        const scheduleData = collectScheduleData();
		
                const finalPayload = {
                    weekStart: weekStart,
                    schedule: scheduleData
                };

                console.log("--- 서버 전송 FINAL PAYLOAD (JSON) ---");
                console.log(JSON.stringify(finalPayload));
                console.log("------------------------------------------");
		
		        $.ajax({
		            url: "/sch/admin/saveSchedule",
		            method: "POST",
		            contentType: "application/json", 
		            data: JSON.stringify(finalPayload), 
		            success: function(res) {
		                alert("스케줄 등록이 완료되었습니다.");
		                // 1. 기존 잠금 리스트를 불러오기
		                const existingListJSON = localStorage.getItem('lockedWeeksList');
		                let lockedWeeksList = existingListJSON ? JSON.parse(existingListJSON) : [];
		                
		                // 2. 현재 주차 키가 리스트에 없으면 추가
		                if (!lockedWeeksList.includes(weekStart)) {
		                    lockedWeeksList.push(weekStart);
		                }

		                // 3. 업데이트된 리스트를 저장 (모든 등록 주차를 기억)
		                localStorage.setItem("lockedWeeksList", JSON.stringify(lockedWeeksList)); 
		                
		                // 기존 스케줄 데이터 저장 및 필드 비활성화
		                localStorage.setItem("schedule_" + weekStart, JSON.stringify(scheduleData));
		                $("#saveBtn, #regisBtn, .select, input[type='time']").prop("disabled", true);
		                
		                const checkData = localStorage.getItem("schedule_" + weekStart);
		                console.log(`[LocalStorage REGIST] Key: schedule_${weekStart}`);
		                console.log(`[LocalStorage REGIST] 데이터 저장 성공 여부: ${checkData ? '성공 (데이터 발견)' : '실패 (데이터 없음)'}`);
		            },
		            error: function(xhr) {
		                console.error("등록 실패", xhr);
		            }
		        });
		    });
		    
		   // ⭐ 페이지 로드시 잠금 상태 확인 및 적용 (모든 주차에 대해 확인)
		   const lockedWeeksJSON = localStorage.getItem('lockedWeeksList');
		   const lockedWeeksList = lockedWeeksJSON ? JSON.parse(lockedWeeksJSON) : [];
		   const currentKey = CURRENT_WEEK_KEY;
		   
		   if (lockedWeeksList.includes(currentKey)) {
			   $(".select, input[type='time'], #saveBtn, #regisBtn").prop("disabled", true);
		       alert("이미 스케줄 등록이 완료된 주입니다.");
		   }
		});
	</script>
<%@ include file="/view/sch/common/footer.jsp"%>