<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<c:set var="pageTitle" value="근무 신청" />

<%@ include file="/view/sch/common/header2.jsp"%>
	
	<section class="area">
		<div class="table" style="margin-top: 120px;">
			<form id="scheduleForm">
				<div class="table-box">
					<div style="font-size: 25px; font-weight: bold; padding: 15px; margin-bottom: 15px;">근무 신청</div>
					<div id="calendar" style="max-width: 500px; height: 500px; margin-right: auto; margin-left: auto; margin-bottom: 50px;"></div>
					<tr>
						<td>월요일</td>
						<td>
							<select class="select" name="workStatus1" style="width:90px; height: 30px; margin: 0 10px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime1" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime1" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					
					<tr>
						<td>화요일</td>
						<td>
							<select class="select" name="workStatus2" style="width:90px; height: 30px; margin: 0 10px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime2" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime2" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>수요일</td>
						<td>
							<select class="select" name="workStatus3" style="width:90px; height: 30px; margin: 0 10px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime3" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime3" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>목요일</td>
						<td>
							<select class="select" name="workStatus4" style="width:90px; height: 30px; margin: 0 10px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime4" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime4" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>금요일</td>
						<td>
							<select class="select" name="workStatus5" style="width:90px; height: 30px; margin: 0 10px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime5" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime5" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>토요일</td>
						<td>
							<select class="select" name="workStatus6" style="width:90px; height: 30px; margin: 0 10px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime6" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime6" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>일요일</td>
						<td>
							<select class="select" name="workStatus7" style="width:90px; height: 30px; margin: 0 10px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime7" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime7" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<button class="btn btn-neutral" id="saveBtn" type="button" style="width: 188px; margin-right: 18px; margin-bottom: 300px;">임시 저장</button>
						<button class="btn btn-neutral" id="applyBtn" type="button" style="width: 188px; margin-right: 18px; margin-bottom: 300px;">최종 신청</button>
					</tr>
				</div>
			</form>
		</div>
	</section>
	
	<script>
		console.log("loginUserId:", '${loginUserId}');
		$(function(){
		    var userId = '${loginUserId}';
		    var selectWeek = [];
		
		    // FullCalendar 초기화
		    var calendarEl = document.getElementById('calendar');
		    var calendar = new FullCalendar.Calendar(calendarEl, {
		        initialView: 'dayGridMonth',
		        locale: 'ko',
		        firstDay: 1,
		        dateClick: function(info) {
		            var clicked = new Date(info.dateStr);
		            var day = clicked.getDay();
		            var diffToMonday = day === 0 ? -6 : 1 - day;
		            var monday = new Date(clicked);
		            monday.setDate(clicked.getDate() + diffToMonday);
		
		            // 이번 주 날짜 배열
		            selectWeek = [];
		            for(var i=0; i<7; i++){
		                var d = new Date(monday);
		                d.setDate(d.getDate() + i);
		                selectWeek.push(d.toISOString().substring(0,10));
		            }
		
		            // weekStart
		            var yyyy = monday.getFullYear();
		            var mm = ("0" + (monday.getMonth()+1)).slice(-2);
		            var dd = ("0" + monday.getDate()).slice(-2);
		            var weekStart = yyyy + "-" + mm + "-" + dd;
		
		            // 폼 초기화 및 weekStart 설정
		            $('#scheduleForm .week-form').remove(); // 기존 폼 제거
		            var formHtml = `
		                <div class="week-form">
		                    <label>출근 시간: <input type="time" name="startTime"></label>
		                    <label>퇴근 시간: <input type="time" name="endTime"></label>
		                    <label>근무 상태: 
		                        <select name="workStatus">
		                            <option value="근무">근무</option>
		                            <option value="휴무">휴무</option>
		                        </select>
		                    </label>
		                </div>`;
		            $('#scheduleForm').append(formHtml);
		
		            if($('#scheduleForm input[name="weekStart"]').length === 0){
		                $('#scheduleForm').append('<input type="hidden" name="weekStart">');
		            }
		            $('#scheduleForm input[name="weekStart"]').val(weekStart);
		
		            // 저장된 데이터 불러오기
		            let saved = localStorage.getItem('scheduleData_' + userId + '_' + weekStart);
		            if(saved){
		                saved = JSON.parse(saved);
		                $('#scheduleForm .week-form').find('input, select').each(function(){
		                    const name = $(this).attr('name');
		                    if(saved[name] != undefined) $(this).val(saved[name]);
		                });
		            }
		
		            // 이벤트 로드
		            loadEvents(weekStart);
		
		            // 배경색 적용
		            $('.fc-daygrid-day').removeClass('select-week');
		            $('.fc-daygrid-day').each(function(){
		                var cellDate = $(this).attr('data-date');
		                if(selectWeek.includes(cellDate)) $(this).addClass('select-week');
		            });
		
		            $('html, body').animate({ scrollTop: $("#scheduleForm").offset().top }, 300);
		        }
		    });
		
		    calendar.render();
		
		    function loadEvents(weekStart){
		        $.ajax({
		            url: '/sch/schedule/event',
		            type: 'get',
		            data: {weekStart: weekStart},
		            success: function(events){
		                calendar.removeAllEvents();
		                events.forEach(function(e){
		                    if(e.start) e.start = e.start.substring(0,10);
		                    calendar.addEvent(e);
		                });
		            }
		        });
		    }
		
		    // 임시 저장
		    $('#saveBtn').click(function(){
		        var weekStart = $('#scheduleForm input[name="weekStart"]').val();
		        if(!weekStart) return alert("근무 신청할주를 선택해주세요.");
		
		        let data = {};
		        $('#scheduleForm .week-form').find('input, select').each(function(){
		            const name = $(this).attr('name');
		            if(name) data[name] = $(this).val();
		        });
		        localStorage.setItem('scheduleData_' + userId + '_' + weekStart, JSON.stringify(data));
		        alert("저장 완료되었습니다.");
		    });
		
		    // 최종 신청
		    $('#applyBtn').click(function(){
		        var weekStart = $('#scheduleForm input[name="weekStart"]').val();
		        if(!weekStart) return alert("근무 신청할 주를 선택해주세요.");
		
		        var formData = $('#scheduleForm').serialize();
		        $.ajax({
		            url: '/sch/schedule/doApply',
		            type: 'post',
		            data: formData,
		            success: function(){
		                alert("근무 신청이 완료되었습니다.");
		            },
		            error: function(){
		                alert("근무 신청에 실패했습니다.");
		            }
		        });
		    });
		});
	</script>
<%@ include file="/view/sch/common/footer.jsp"%>