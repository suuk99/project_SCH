<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<c:set var="pageTitle" value="근무 신청" />

<%@ include file="/view/sch/common/header2.jsp"%>
	
	<section class="area">
		<div class="table" style="margin-top: 100px;">
			<form id="scheduleForm">
				<input type="hidden" name="weekStart" value="">
				<div class="table-box">
					<div style="font-size: 28px; font-weight: bold; padding: 15px; margin-bottom: 25px;">근무 신청</div>
					<div id="calendar" style="max-width: 520px; height: 500px; margin-right: auto; margin-left: auto; margin-bottom: 50px;"></div>
					<tr>
						<td>월요일</td>
						<td>
							<select class="select" name="workStatus1" style="width:90px; height: 30px; margin: 0 22px;">
								<option disabled selected value="">--</option>
								<option value="yes">근무</option>
								<option value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime1" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime1" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					
					<tr>
						<td>화요일</td>
						<td>
							<select class="select" name="workStatus2" style="width:90px; height: 30px; margin: 0 22px;">
								<option disabled selected value="">--</option>
								<option value="yes">근무</option>
								<option value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime2" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime2" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>수요일</td>
						<td>
							<select class="select" name="workStatus3" style="width:90px; height: 30px; margin: 0 22px;">
								<option disabled selected value="">--</option>
								<option value="yes">근무</option>
								<option value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime3" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime3" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>목요일</td>
						<td>
							<select class="select" name="workStatus4" style="width:90px; height: 30px; margin: 0 22px;">
								<option disabled selected value="">--</option>
								<option value="yes">근무</option>
								<option value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime4" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime4" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>금요일</td>
						<td>
							<select class="select" name="workStatus5" style="width:90px; height: 30px; margin: 0 22px;">
								<option disabled selected value="">--</option>
								<option value="yes">근무</option>
								<option value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime5" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime5" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>토요일</td>
						<td>
							<select class="select" name="workStatus6" style="width:90px; height: 30px; margin: 0 22px;">
								<option disabled selected value="">--</option>
								<option value="yes">근무</option>
								<option value="no">휴무</option>
							</select>
						</td>
						<td>출근<input class="input" type="time" name="startTime6" style="width:130px; height: 30px; margin: 0 10px;"/></td>
						<td>퇴근<input class="input" type="time" name="endTime6" style="width:130px; height: 30px; margin-left:10px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>일요일</td>
						<td>
							<select class="select" name="workStatus7" style="width:90px; height: 30px; margin: 0 22px;">
								<option disabled selected value="">--</option>
								<option value="yes">근무</option>
								<option value="no">휴무</option>
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
		
		// 폼 비활성화 -> 수정 불가능
		function disableForm() {
			$("#scheduleForm input, #scheduleForm select").attr("disabled", true);
		}
		// 폼 활성화
		function enableForm() {
			$("#scheduleForm input, #scheduleForm select").attr("disabled", false);
		}
	
		$(function(){
		    var userId = '${loginUserId}';
		    var selectWeek = []; // 클릭한 주 배열
		    var currentWeekStart = null; // 현재 선택한 주 시작일
	
		    // FullCalendar 초기화
		    var calendarEl = document.getElementById('calendar');
		    var calendar = new FullCalendar.Calendar(calendarEl, {
		        initialView: 'dayGridMonth',
		        locale: 'ko',
		        firstDay: 1,
		        dateClick: function(info) {
		        	handleWeekSelect(info.dateStr);
		        }
		    });		    
		    calendar.render();
	
		    function handleWeekSelect(dateStr) {
		        // 클릭한 날짜 기준 주 시작일 계산
		        var clicked = new Date(dateStr);
		        var day = clicked.getDay();
		        var diffToMonday = day === 0 ? -6 : 1 - day;
		        var monday = new Date(clicked);
		        monday.setDate(clicked.getDate() + diffToMonday);
	
		        // 이번 주 배열
		        selectWeek = [];
		        for(var i=0; i<7; i++){
		            var d = new Date(monday);
		            d.setDate(d.getDate() + i);
		            selectWeek.push(d.toISOString().substring(0,10));
		        }
	
		        // weekStart 문자열
		        var yyyy = monday.getFullYear();
		        var mm = ("0" + (monday.getMonth()+1)).slice(-2);
		        var dd = ("0" + monday.getDate()).slice(-2);
		        currentWeekStart = yyyy + "-" + mm + "-" + dd;
		        $('#scheduleForm input[name="weekStart"]').val(currentWeekStart);
	
		        // 선택한 주 배경색
		        $('.fc-daygrid-day').removeClass('select-week');
		        $('.fc-daygrid-day').each(function(){
		        	var cellDate = $(this).attr('data-date');
		        	if(selectWeek.includes(cellDate)) $(this).addClass('select-week');
		        });
		        
		        var today = new Date();
		        today.setHours(0, 0, 0, 0);
		        
				var parts = currentWeekStart.split('-');
		        var selectedMonday = new Date(parts[0], parts[1] - 1, parts[2]);
		        selectedMonday.setHours(0, 0, 0, 0);
		        
		        var deadLineDate = selectedMonday;
		        
		        if(deadLineDate <= today) {
		        	disableForm();
		        	$('#applyBtn, #saveBtn').hide();
		        	$('#scheduleForm').css('margin-bottom', '410px');
		        	alert('이미 신청이 마감된 주입니다');
		        	return;
		        }
	
		        // 선택 주 서버 체크
		        $.ajax({
		           url: '/sch/schedule/isSubmit',
		           type: 'get',
		           data: {weekStart: currentWeekStart},
		           success: function(isSubmit) {
		           	if (isSubmit) {
		           		disableForm();
		           		$('#applyBtn, #saveBtn').hide();
		           		$('#scheduleForm').css('margin-bottom', '410px');
		           		alert("이미 근무 신청이 완료된 주입니다.");
		           	} else {
		           		enableForm();
		           		$('#applyBtn, #saveBtn').show();
		           		loadSaveTime(currentWeekStart); // 임시 저장 불러오기
		           	}
		           }
		        });
		    }
	
		    function loadSaveTime(weekStart) {
		    	const data = localStorage.getItem('scheduleData_' + userId + '_' + weekStart);
		    	if(data) {
		    		const obj = JSON.parse(data);
		    		for(const key in obj) {
		    			$('#scheduleForm [name="' + key + '"]').val(obj[key]);
		    		}
		    	} else {
		    		$('#scheduleForm').find('input, select').val(function(){
		    			return $(this).prop('tagName') == 'SELECT' ? '0' : '';
		    		});
		    	}
		    }
	
		    function loadEvents(){
		        $.ajax({
		            url: '/sch/schedule/event',
		            type: 'get',
		            success: function(events){
		                calendar.removeAllEvents();
		                events.forEach(function(e){
		                    if(e.start) e.start = e.start.substring(0,10);
		                    calendar.addEvent(e);
		                });
		            }
		        });
		    }
		    loadEvents();
	
		    // 임시 저장
		    $('#saveBtn').click(function(){
		        if(!currentWeekStart) return alert("근무 신청할 주를 선택해주세요.");
	
		        let data = {};
		        $('#scheduleForm').find('input, select').not('[type="hidden"]').each(function(){
		            const name = $(this).attr('name');
		            if(name) data[name] = $(this).val();
		        });
		        localStorage.setItem('scheduleData_' + userId + '_' + currentWeekStart, JSON.stringify(data));
		        alert("저장 완료되었습니다.");
		    });
	
		    // 최종 신청
		    $('#applyBtn').click(function() {
		        if(!currentWeekStart) return alert("근무 신청할 주를 선택해주세요.");

		        var form = $('#scheduleForm');
		        form.find('.auto-generated').remove(); // 기존 hidden input 제거

		        for (let i = 1; i <= 7; i++) {
		            let sel = document.querySelector(`#scheduleForm select[name='workStatus${i}']`);
		            let startInput = document.querySelector(`#scheduleForm input[name='startTime${i}']`);
		            let endInput = document.querySelector(`#scheduleForm input[name='endTime${i}']`);

		            if (!sel || !startInput || !endInput) {
		                console.log(`i=${i} 요소 없음`);
		                continue;
		            }

		            let status = sel.value;
		            let start = startInput.value;
		            let end = endInput.value;

		            // 검증 먼저
		            if (!status || status === "") {
		                alert(`요일 ${i}의 근무여부를 선택해주세요.`);
		                sel.focus();
		                return;
		            }
		            if (!start || !end) {
		                alert(`요일 ${i}의 출퇴근 시간을 모두 입력해주세요.`);
		                startInput.focus();
		                return;
		            }

		            // hidden input 추가
		            form.append(`<input class="auto-generated" type="hidden" name="workStatus${i}" value="${status}">`);
		            form.append(`<input class="auto-generated" type="hidden" name="startTime${i}" value="${start}">`);
		            form.append(`<input class="auto-generated" type="hidden" name="endTime${i}" value="${end}">`);
		        }

		        $.ajax({
		            url: '/sch/schedule/doApply',
		            type: 'post',
		            data: form.serialize(),
		            success: function() {
		                alert("근무 신청이 완료되었습니다.");
		                loadEvents(); // 캘린더 새로고침
		            },
		            error: function() {
		                alert("근무 신청에 실패했습니다.");
		            }
		        });
		    });
		});
	</script>
<%@ include file="/view/sch/common/footer.jsp"%>