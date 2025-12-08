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
					<div class="day" style="margin-top: 25px; margin-left: 20px; margin-right: 90px; margin-bottom: 20px; font-size: 20px;">월요일</div>
					<div class="time" style="margin-top: 25px; font-size:20px;">근무여부</div>
				</div>
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-left: 20px; margin-right: 90px; margin-bottom: 20px; font-size: 20px;">화요일</div>
					<div class="time" style="font-size:20px;">근무여부</div>
				</div>
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-left: 20px; margin-right: 90px; margin-bottom: 20px; font-size: 20px;">수요일</div>
					<div class="time" style="font-size:20px;">근무여부</div>
				</div>
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-left: 20px; margin-right: 90px; margin-bottom: 20px; font-size: 20px;">목요일</div>
					<div class="time" style="font-size:20px;">근무여부</div>
				</div>
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-left: 20px; margin-right: 90px; margin-bottom: 20px; font-size: 20px;">금요일</div>
					<div class="time" style="font-size:20px;">근무여부</div>
				</div>
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-left: 20px; margin-right: 90px; margin-bottom: 20px; font-size: 20px;">토요일</div>
					<div class="time" style="font-size:20px;">근무여부</div>
				</div>
				<div class="day-area" style="display: flex;">
					<div class="day" style="margin-left: 20px; margin-right: 90px; margin-bottom: 20px; font-size: 20px;">일요일</div>
					<div class="time" style="font-size:20px;">근무여부</div>
				</div>
		</div>
			<div class="btn-area" style="text-align: center; margin-top: 50px; margin-bottom: 300px;">
				<button class="btn btn-neutral" style="width: 188px;">근무 확정</button>
			</div>
	
	</section>
	
	<script>
		// 캘린더에서 주 선택 시 배경색 변경
		var selectWeek = [];
		var currentWeekStart = null;
		
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView: 'dayGridMonth',
			locale: 'ko',
			firstDay: 1,
			dateClick: function(info) {
				handleWeekSelect(info.dateStr);
			}
		});
		
		function handleWeekSelect(dateStr) {
			var clicked = new Date(dateStr);
			var day = clicked.getDay();
			var diffToMonday = day == 0? -6 : 1 - day;
			var monday = new Date(clicked);
			monday.setDate(clicked.getDate() + diffToMonday);
			
			selectWeek = [];
			for(var i = 0; i < 7; i ++) {
				var d = new Date(monday);
				d.setDate(d.getDate() + i);
				selectWeek.push(d.toISOString().substring(0,10));
			}
			
			var yyyy = monday.getFullYear();
			var mm = ('0' + (monday.getMonth() + 1)).slice(-2);
			var dd = ('0' + monday.getDate()).slice(-2);
			currentWeekStart = yyyy + '-' + mm + '-' + dd;
			$('#scheduleForm input[name="weekStart"]').val(currentWeekStart);
			
			$('.fc-daygrid-day').removeClass('select-week');
			$('.fc-daygrid-day').each(function() {
				var cellDate = $(this).attr('data-date');
				if(selectWeek.includes(cellDate)) $(this).addClass('select-week');
			});
		}
		calendar.render();
		
		$('.btn.btn-neutral').click(function() {
			if(!currentWeekStart) {
				alert('근무 확정할 주를 선택해주세요.');
				return;
			}			
			
			$.ajax({
				url: '/sch/schedule/confirm',
				type: 'post',
				data: {weekStart: currentWeekStart},
				success: function(data) {
					alert('근무가 확정되었습니다.');
				},
				error: function(err) {
					console.error(err);
					alert('오류가 발생했습니다.');
				}
			});
		});
	</script>
<%@ include file="/view/sch/common/footer.jsp"%>