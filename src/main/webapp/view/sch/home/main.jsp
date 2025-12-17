<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="main" />

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>


<%@ include file="/view/sch/common/header2.jsp"%>

	<section>
	    <div class="table" style="margin:110px auto ; width:1500px;">
	    	<div class="img-area">
		        <div class="imgs" style="width:800px; margin:auto;">
		            <div style="margin-top: 15px;"><img src="${pageContext.request.contextPath}/resource/img/123.png"></div>
		        </div>
	    	</div>
	
	        <div class="content-area" style="display: flex; justify-content: space-around; margin-top: 60px; width: 70%; margin-left: auto; margin-right: auto;">
	            <div class="notice" style="text-align: left; width: 28%;">
	                <div>
	                    <a href="/sch/notice/list" style="font-size: 20px; font-weight: bold;">공지사항</a>
	                    <div style="border-bottom: 1px solid #dedede; margin: 4px 0 15px;"></div>
	                    <c:forEach var="notice" items="${noticeList}" begin="0" end="4">
	                        <div style="margin-bottom: 5px; margin-left: 2px; font-size: 15px;">
	                            <a href="/sch/notice/detail?id=${notice.id}">${notice.title}</a>
	                        </div>
	                    </c:forEach>
	                </div>
	            </div>
	
	            <div class="time" style="text-align: left; width: 47%;">
	                <div>
	                    <a href="/sch/schedule/list" style="font-size: 20px; font-weight: bold;">이번 주 근무시간</a>
	                    <div style="border-bottom: 1px solid #dedede; margin: 4px 0 24px;"></div>
	                    <div style="margin-bottom: 5px; margin-left: 4px; font-size: 15px;">
	                        <div id="weekCalendar" style="width: 90%;"></div>
	                        <div style="text-align: right; font-size: 14px; margin-top: 15px; color: #6b6c6e;">
	                            <a href="/sch/schedule/list">근무시간 더 보기 ></a>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	
	    <footer class="footer sm:footer-horizontal footer-center text-base-content p-4">
	        <aside style="margin:150px 0 10px;">
	            <p>© SCHM — Smart Crew & Hour Management. All rights reserved.</p>
	            <p>Designed and developed with care to streamline scheduling, track work hours, and empower team efficiency.</p>
	        </aside>
	    </footer>
	</section>
	
	<script>
		document.addEventListener('DOMContentLoaded', function() {
		    var calendarEl = document.getElementById('weekCalendar');
		    
		    const scheduleList = [
		        <c:forEach var="s" items="${scheduleList}" varStatus="loop">
		        {
		            title: "${s.startTime} -<br>${s.endTime}",
		            start: "${s.date}T${s.startTime}",
		            end: "${s.date}T${s.endTime}"
		        }<c:if test="${!loop.last}">,</c:if>
		        </c:forEach>
		    ];
		
		    var calendar = new FullCalendar.Calendar(calendarEl, {
		        initialView: 'dayGridWeek',
		        allDaySlot: false,
		        locale: 'ko',
		        headerToolbar: false,
		        firstDay: 1,
		        height: 84,
		        width: 600,
		        eventTimeFormat: {
		            hour: '2-digit',
		            minute: '2-digit',
		            hour12: false
		        },
		        eventContent: function(arg) {
		            return { html: arg.event.title };
		        },
		        events: scheduleList
		    });
		    calendar.render();
		});
	</script>
	
	<style>
		#weekCalendar .fc-event {
		    display: flex;
		    justify-content: center; 
		    align-items: center;     
		    text-align: center;      
		    font-size: 14px;         
		    padding: 11px;
		}
		
		
	</style>

<%@ include file="/view/sch/common/footer.jsp"%>
