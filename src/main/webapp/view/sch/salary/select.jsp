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
	
	            <form id="monthForm" method="get" action="/sch/salary/select" style="text-align: right; margin-right: 16%; margin-bottom: 50px; font-size: 16px;">
				    <label for="salaryMonth" style="margin-right: 14px; font-weight: bold;">조회 연월</label>
				    <input id="salaryMonth" name="weekStart" type="month" style="width: 160px; height: 25px;"
				           value="<c:out value='${weekStart != null ? weekStart.substring(0,7) : ""}'/>"/>
				</form>
	
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
	  // 서버에서 fixScheduleList 전달받아 JS 객체로 변환
	  const schedules = [];
	  <c:forEach var='sch' items='${fixScheduleList}'>
	    schedules.push({
	      date: "${sch.date}",           // yyyy-MM-dd
	      startTime: "${sch.startTime}", // HH:mm
	      endTime: "${sch.endTime}"      // HH:mm
	    });
	  </c:forEach>
	
	  const basePay = 10030;      // 시급 예시
	  const nightPayRate = 1.5;   // 야간수당 1.5배
	
	  // 휴식시간 계산
	  function calculateBreak(hoursWorked) {
	      if(hoursWorked >= 9) return 1;   // 9시간 이상 → 1시간
	      if(hoursWorked >= 4) return 0.5; // 4시간 이상 → 30분
	      return 0;
	  }
	
	  // 주별 근무시간 및 정상/야간 시간 계산
	  function calculateMonthlyHours(schedules, yearMonth) {
	      let normalHours = 0;
	      let nightHours = 0;
	      const weeklyWork = {}; // 주 단위 누적 { weekStart: hours }
	
	      schedules.forEach(sch => {
	          if(!sch.date.startsWith(yearMonth)) return;
	
	          const [sH, sM] = sch.startTime.split(':').map(Number);
	          const [eH, eM] = sch.endTime.split(':').map(Number);
	          let start = sH + sM/60;
	          let end = eH + eM/60;
	          if(end <= start) end += 24;
	
	          let hoursWorked = end - start;
	          hoursWorked -= calculateBreak(hoursWorked); // 휴식 차감
	
	          // 시간 단위로 정상/야간 구분
	          let t = 0;
	          while(t < hoursWorked) {
	              const hourOfDay = (start + t) % 24;
	              if(hourOfDay >= 22 || hourOfDay < 6) nightHours += 1;
	              else normalHours += 1;
	              t += 1;
	          }
	
	          // 주 계산 (월요일 기준)
	          const dateObj = new Date(sch.date);
	          const day = dateObj.getDay();
	          const monday = new Date(dateObj);
	          monday.setDate(dateObj.getDate() - ((day + 6) % 7)); // 월요일
	          const weekKey = monday.toISOString().slice(0,10);
	          if(!weeklyWork[weekKey]) weeklyWork[weekKey] = 0;
	          weeklyWork[weekKey] += hoursWorked;
	      });
	
	      return {normalHours, nightHours, weeklyWork};
	  }
	
	  // 주휴수당 계산
	  function calculateWeeklyPay(weeklyWork) {
	      let weeklyPay = 0;
	      Object.values(weeklyWork).forEach(hours => {
	          if(hours >= 15) {
	              const avgDaily = hours / 5; // 1주 5일 기준 1일 평균
	              weeklyPay += Math.floor(avgDaily * basePay);
	          }
	      });
	      return weeklyPay;
	  }
	
	  // 지급내역 및 공제 계산
	  function updatePaymentAndDeductions(normalHours, nightHours, weeklyWork) {
	      const normalAmount = Math.floor(normalHours * basePay);
	      const nightAmount = Math.floor(nightHours * basePay * nightPayRate);
	      const weeklyPay = calculateWeeklyPay(weeklyWork);
	      const totalPay = normalAmount + nightAmount + weeklyPay;
	
	      // 4대보험
	      const nationalPension = Math.floor(totalPay * 0.045);
	      const healthInsurance = Math.floor(totalPay * 0.03495);
	      const longTermCare = Math.floor(healthInsurance * 0.1227);
	      const employmentInsurance = Math.floor(totalPay * 0.008);
	      const totalInsurance = nationalPension + healthInsurance + longTermCare + employmentInsurance;
	
	      // 근로소득공제 (총 지급액 기준 단순화)
	      const earnedIncomeDeduction = Math.floor(totalPay * 0.7);
	      const taxableIncome = totalPay - totalInsurance - earnedIncomeDeduction;
	      const incomeTax = taxableIncome > 0 ? Math.floor(taxableIncome * 0.06) : 0;
	      const localIncomeTax = Math.floor(incomeTax * 0.1);
	
	      const totalDeduction = totalInsurance + incomeTax + localIncomeTax;
	
	      // DOM 업데이트
	      // 근무시간
	      const timeSpans = document.querySelectorAll('.info-2 .content span');
	      timeSpans[0].textContent = normalHours + "시간";
	      timeSpans[1].textContent = nightHours + "시간";
	
	      // 지급내역
	      const paySpans = document.querySelectorAll('.info-3 .content span');
	      paySpans[0].textContent = normalAmount.toLocaleString() + "원";
	      paySpans[1].textContent = nightAmount.toLocaleString() + "원";
	      paySpans[2].textContent = weeklyPay.toLocaleString() + "원";
	
	      // 총 지급액
	      const netPay = totalPay - totalDeduction;
	      document.querySelector('.info-1 .content span').textContent = netPay.toLocaleString() + "원";
	
	      // 공제내역
	      const deductionSpans = document.querySelectorAll('.info-4 .content span');
	      deductionSpans[0].textContent = nationalPension.toLocaleString() + "원";
	      deductionSpans[1].textContent = (healthInsurance + longTermCare).toLocaleString() + "원";
	      deductionSpans[2].textContent = employmentInsurance.toLocaleString() + "원";
	      deductionSpans[3].textContent = incomeTax.toLocaleString() + "원";
	      deductionSpans[4].textContent = localIncomeTax.toLocaleString() + "원";
	  }
	
	  document.addEventListener('DOMContentLoaded', function() {
	      const monthInput = document.getElementById('salaryMonth');
	      const weekStart = "<c:out value='${weekStart}'/>";
	      const initialDate = weekStart && weekStart !== '' ? weekStart.substring(0,7) + '-01' : new Date().toISOString().slice(0,10);
	
	      // FullCalendar 초기화
	      const calendarEl = document.getElementById('calendar');
	      const calendar = new FullCalendar.Calendar(calendarEl, {
	          initialView: 'dayGridMonth',
	          locale: 'ko',
	          headerToolbar: {left: '', center: 'title', right: ''},
	          titleFormat: {year: 'numeric', month: 'long'},
	          events: schedules.map(s => ({
	              title: s.startTime + '-' + s.endTime,
	              start: s.date,
	              display: 'block',
	              backgroundColor: '#4b9fff',
	              borderColor: '#4b9fff'
	          })),
	          displayEventTime: false,
	          initialDate: initialDate
	      });
	      calendar.render();
	
	      function updateMonthlyInfo() {
	          const yearMonth = monthInput.value;
	          const {normalHours, nightHours, weeklyWork} = calculateMonthlyHours(schedules, yearMonth);
	          updatePaymentAndDeductions(normalHours, nightHours, weeklyWork);
	      }
	
	      updateMonthlyInfo(); // 페이지 로드 시
	
	      monthInput.addEventListener('change', function() {
	          updateMonthlyInfo();
	          document.getElementById('monthForm').submit();
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