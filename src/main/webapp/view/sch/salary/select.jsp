<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<c:set var="pageTitle" value="급여조회" />

<%@ include file="/view/sch/common/header2.jsp"%>

	<section style="display: flex; justify-content: center; margin-top: -50px;">
	    <div class="table" style="width: 90%; max-width: 1100px;">
	        <div class="pageName" style="font-size: 28px; font-weight: bold; margin-bottom: 22px; margin-left: 15%; text-align:left;">급여 조회</div>
	
	        <div class="area-1" style="width: 100%;">
	            <div style="border-bottom: 1px solid #dedede; margin: 0 auto 30px; width: 70%;"></div>
	
	            <div class="selectMonth" style="text-align: right; margin-right: 16%; margin-bottom: 50px; font-size: 16px;">
	                <label for="salaryMonth" style="margin-right: 14px; font-weight: bold;">조회 연월</label>
	                <input class="input" type="month" style="width: 160px; height: 25px;"/>
	            </div>
	
	            <div id="calendar" style="width: 100%; max-width: 620px; height: 500px; margin: 0 auto 50px;"></div>
	
	            <div class="salary-info" style="text-align: left; max-width: 620px; margin: 80px auto;">
	            	<div class="info-1" style="margin-bottom: 48px;">
		                <div class="title" style="font-size: 20px; font-weight: bold; background-color: #ebebeb; border-radius: 5px; padding: 6px 15px;">총 지급액</div>
		                <div class="content" style="font-size: 17px; margin-left: 25px; margin-top: 12px;">지급액
		                	<span style="margin-left: 55px;">ddd</span>
		                </div>
	            	</div>
	            	
	            	<div class="info-2" style="margin-bottom: 48px;">
		                <div class="title" style="font-size: 20px; font-weight: bold; background-color: #ebebeb; border-radius: 5px; padding: 6px 15px;">근무 시간</div>
		                <div class="content" style="font-size: 17px; margin-left: 25px; margin-top: 12px;">정상근무
		                	<span style="margin-left: 40px;">ddd</span>
		                </div>
		                <div class="content" style="font-size: 17px; margin-left: 25px; margin-top: 7px;">야간근무
		                	<span style="margin-left: 40px;">ddd</span>
		                </div>
	            	</div>
	            	
	            	<div class="info-3" style="margin-bottom: 48px;">
		                <div class="title" style="font-size: 20px; font-weight: bold; background-color: #ebebeb; border-radius: 5px; padding: 6px 15px;">지급 내역</div>
		                <div class="content" style="font-size: 17px; margin-left: 25px; margin-top: 12px;">정상금액
		                	<span style="margin-left: 40px;">ddd</span>
		                </div>
		                <div class="content" style="font-size: 17px; margin-left: 25px; margin-top: 7px;">야간수당
		                	<span style="margin-left: 40px;">ddd</span>
		                </div>
		                <div class="content" style="font-size: 17px; margin-left: 25px; margin-top: 7px;">주휴수당
		                	<span style="margin-left: 40px;">ddd</span>
		                </div>
	            	</div>
	            	
	            	<div class="info-4" style="margin-bottom: 300px;">
		                <div class="title" style="font-size: 20px; font-weight: bold; background-color: #ebebeb; border-radius: 5px; padding: 6px 15px;">공제 내역</div>
		                <div class="content" style="font-size: 17px; margin-left: 25px; margin-top: 12px;">국민연금
		                	<span style="margin-left: 40px;">ddd</span>
		                </div>
		                <div class="content" style="font-size: 17px; margin-left: 25px; margin-top: 7px;">건강보험
		                	<span style="margin-left: 40px;">ddd</span>
		                </div>
		                <div class="content" style="font-size: 17px; margin-left: 25px; margin-top: 7px;">고용보험
		                	<span style="margin-left: 40px;">ddd</span>
		                </div>
		                <div class="content" style="font-size: 17px; margin-left: 25px; margin-top: 7px;">소득세
		                	<span style="margin-left: 55px;">ddd</span>
		                </div>
		                <div class="content" style="font-size: 17px; margin-left: 25px; margin-top: 7px;">지방소득세
		                	<span style="margin-left: 25px;">ddd</span>
		                </div>
	            	</div>
	            </div>
	        </div>
	    </div>
	</section>

	
	<script>
		  document.addEventListener('DOMContentLoaded', function() {
		      var calendarEl = document.getElementById('calendar');
	
		      var calendar = new FullCalendar.Calendar(calendarEl, {
		          initialView: 'dayGridMonth', // 월별 달력
		          locale: 'ko',                // 한국어
		          headerToolbar: {left: '', center: 'title', right: ''},	   
		          titleFormat: {year: 'numeric', month: 'long'},
		          events: []                   // 나중에 근무시간 데이터를 넣을 수 있음
		      });
		      calendar.render();
		      
		      //조회 연월
		      var monthInput = document.querySelector('input[type="month"]');
		      monthInput.addEventListener('change', function() {
		    	 if(this.value) {
		    		 var selectDate = this.value + '-01';
		    		 calendar.gotoDate(selectDate);
		    	 } 
		      });
		  });
	</script>
	
	<style>
		/*캘린더에서 오늘 날짜 강조 제거*/
		.fc-day-today {
		    background-color: transparent !important;
		}
	</style>

<%@ include file="/view/sch/common/footer.jsp"%>