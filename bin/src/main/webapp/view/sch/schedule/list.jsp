<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<c:set var="pageTitle" value="근무시간 조회" />

<%@ include file="/view/sch/common/header2.jsp"%>

	<section>
		<div class="table" style="margin-top: 100px; width: 520px; margin-left:auto; margin-right: auto;">
			<div style="font-size: 28px; font-weight: bold; padding: 15px; margin-bottom: 25px;">근무시간 조회</div>
			<div id="calendar" style="max-width: 520px; height: 500px; margin-right: auto; margin-left: auto; margin-bottom: 50px;"></div>
			
			<div class="time-area" style="text-align: left; background-color: #f7f5f5; border-radius: 8px;">
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-top: 25px; margin-left: 35px; margin-right: 60px; margin-bottom: 20px; font-size: 20px;">월요일</div>
					<div class="time" style="margin-top: 25px; font-size:20px;">근무여부</div>
				</div>
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-left: 35px; margin-right: 60px; margin-bottom: 20px; font-size: 20px;">화요일</div>
					<div class="time" style="font-size:20px;">근무여부</div>
				</div>
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-left: 35px; margin-right: 60px; margin-bottom: 20px; font-size: 20px;">수요일</div>
					<div class="time" style="font-size:20px;">근무여부</div>
				</div>
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-left: 35px; margin-right: 60px; margin-bottom: 20px; font-size: 20px;">목요일</div>
					<div class="time" style="font-size:20px;">근무여부</div>
				</div>
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-left: 35px; margin-right: 60px; margin-bottom: 20px; font-size: 20px;">금요일</div>
					<div class="time" style="font-size:20px;">근무여부</div>
				</div>
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-left: 35px; margin-right: 60px; margin-bottom: 20px; font-size: 20px;">토요일</div>
					<div class="time" style="font-size:20px;">근무여부</div>
				</div>
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-left: 35px; margin-right: 60px; margin-bottom: 20px; font-size: 20px;">일요일</div>
					<div class="time" style="font-size:20px;">근무여부</div>
				</div>
		</div>
		
			<div class="btn-area" style="text-align: center; margin-top: 50px; margin-bottom: 300px;">
				<button class="btn btn-neutral" style="width: 188px;" ${confirm == 1 ? 'disabled' : ''}>근무 확인</button>
			</div>
	
	</section>
	
	<script>
	    var calendarEl = document.getElementById('calendar');
	    var currentWeekStart = '${weekStart}';
	    var confirmVal = ${confirm};
	    var selectedWeekEls = [];
	
	    var weekWorkMap = {};
	    <c:forEach var="fs" items="${fixed}">
	        var weekStart = '${fs.weekStart}'.replace(/"/g, '');
	        if(!weekWorkMap[weekStart]) weekWorkMap[weekStart] = [];
	        weekWorkMap[weekStart].push({
	            date: '${fs.start}'.substring(0,10),
	            time: '${fs.startTime}'.substring(0,5) + ' - ' + '${fs.endTime}'.substring(0,5)
	        });
	    </c:forEach>
	
	    var fixedEvents = [];
	    <c:forEach var="fs" items="${fixed}">
	        fixedEvents.push({
	            start: '${fs.start}',
	            end: '${fs.end}',
	            title: '${fs.startTime}'.substring(0,5) + '-' + '${fs.endTime}'.substring(0,5),
	            display: 'block',
	            backgroundColor: '#4b9fff',
	            borderColor: '#4b9fff'
	        });
	    </c:forEach>
	
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	        initialView: 'dayGridMonth',
	        locale: 'ko',
	        firstDay: 1,
	        events: fixedEvents,
	        displayEventTime: false,
	        dateClick: function(info){
	            handleWeekSelect(info.dateStr);
	        }
	    });
	
	    calendar.render();
	
	    function highlightWeek(weekStart) {
	        selectedWeekEls.forEach(el => el.style.backgroundColor = '');
	        selectedWeekEls = [];
	
	        if(!weekStart) return;
	
	        const parts = weekStart.split('-');
	        const monday = new Date(parts[0], parts[1]-1, parts[2]);
	
	        for(let i=0;i<7;i++){
	            const d = new Date(monday);
	            d.setDate(monday.getDate() + i);
	            const yyyy = d.getFullYear();
	            const mm = ('0'+(d.getMonth()+1)).slice(-2);
	            const dd = ('0'+d.getDate()).slice(-2);
	            const dateStr = yyyy+'-'+mm+'-'+dd;
	
	            const dayEl = calendarEl.querySelector('[data-date="'+dateStr+'"]');
	            if(dayEl){
	                dayEl.style.backgroundColor = '#f0f0f0';
	                selectedWeekEls.push(dayEl);
	            }
	        }
	        fillWeekTimes();
	    }
	
	    // 🔥 버튼활성화 로직 AJAX로 confirm 갱신
	    function updateButtonStateAjax(weekStartStr) {
	        $.ajax({
	            url: '/sch/schedule/confirmCheck',
	            type: 'get',
	            data: { weekStart: weekStartStr },
	            success: function(confirm){
	                confirmVal = confirm; // 서버에서 받은 값으로 갱신
	
	                if(confirmVal == 1){
	                    $('.btn.btn-neutral').attr('disabled', true);
	                } else {
	                    $('.btn.btn-neutral').attr('disabled', false);
	                }
	            }
	        });
	    }
	
	    function handleWeekSelect(dateStr){
	        const parts = dateStr.split('-');
	        const clicked = new Date(parts[0], parts[1]-1, parts[2]);
	        const day = clicked.getDay();
	
	        const monday = new Date(clicked);
	        monday.setDate(clicked.getDate() - ((day + 6) % 7));
	
	        const weekDates = [];
	        for(let i=0;i<7;i++){
	            const d = new Date(monday);
	            d.setDate(monday.getDate() + i);
	            const yyyy = d.getFullYear();
	            const mm = ('0'+(d.getMonth()+1)).slice(-2);
	            const dd = ('0'+d.getDate()).slice(-2);
	            weekDates.push(yyyy+'-'+mm+'-'+dd);
	        }
	
	        currentWeekStart = weekDates[0];
	
	        selectedWeekEls.forEach(el => el.style.backgroundColor = '');
	        selectedWeekEls = [];
	        weekDates.forEach(dStr=>{
	            const el = calendarEl.querySelector('[data-date="'+dStr+'"]');
	            if(el){
	                el.style.backgroundColor = '#f0f0f0';
	                selectedWeekEls.push(el);
	            }
	        });
	
	        // 🔥 주 클릭 시 confirm 값 서버에서 다시 불러오기
	        updateButtonStateAjax(currentWeekStart);
	
	        fillWeekTimes();
	        calendar.gotoDate(dateStr);
	    }
	
	    function fillWeekTimes() {
	        const weekDates = [];
	        const parts = currentWeekStart.split('-');
	        const monday = new Date(parts[0], parts[1]-1, parts[2]);
	
	        for(let i=0;i<7;i++){
	            const d = new Date(monday);
	            d.setDate(monday.getDate() + i);
	            const yyyy = d.getFullYear();
	            const mm = ('0'+(d.getMonth()+1)).slice(-2);
	            const dd = ('0'+d.getDate()).slice(-2);
	            weekDates.push(yyyy+'-'+mm+'-'+dd);
	        }
	
	        const weekData = weekWorkMap[currentWeekStart] || [];
	
	        document.querySelectorAll('.day-area').forEach((el, idx)=>{
	            const timeEl = el.querySelector('.time');
	            const dateStr = weekDates[idx];
	            const work = weekData.find(ev => ev.date === dateStr);
	            timeEl.textContent = work ? work.time : '휴무';
	        });
	    }
	
	    $(document).ready(function() {
	        highlightWeek(currentWeekStart);
	        updateButtonStateAjax(currentWeekStart);  // 🔥 초기 로딩도 서버값 반영
	    });
	
	    $('.btn.btn-neutral').click(function() {
	        if (!currentWeekStart) {
	            alert('근무 확정할 주를 선택해주세요.');
	            return;
	        }
	
	        $.ajax({
	            url: '/sch/schedule/confirm',
	            type: 'post',
	            data: { weekStart: currentWeekStart },
	            success: function(data) {
	                alert('근무가 확정되었습니다.');
	                $('.btn.btn-neutral').attr('disabled', true);
	
	                updateButtonStateAjax(currentWeekStart); // 🔥 서버 반영 후 즉시 다시 확인
	            },
	            error: function(err) {
	                console.error(err);
	                alert('오류가 발생했습니다.');
	            }
	        });
	    });
	</script>



<%@ include file="/view/sch/common/footer.jsp"%>