<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<c:set var="pageTitle" value="신청 현황" />
<%@ include file="/view/sch/common/header2.jsp"%>

<section>
    <div class="table" style="width:1300px; margin-top: 120px; margin-left: auto; margin-right: auto;">
        <div class="pageName" style="font-size:28px; font-weight:bold; margin-bottom:25px; margin-right: 50%;">근무신청 현황</div>

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

                <div style="display:flex; justify-content:space-between; margin:13px 19%; font-size:17px;">
                    <div style="width:100px;">${userName}</div>
                    <div style="width:130px;"><c:choose><c:when test="${days[0] == null}">-</c:when><c:otherwise>${days[0]}</c:otherwise></c:choose></div>
		            <div style="width:130px;"><c:choose><c:when test="${days[1] == null}">-</c:when><c:otherwise>${days[1]}</c:otherwise></c:choose></div>
		            <div style="width:130px;"><c:choose><c:when test="${days[2] == null}">-</c:when><c:otherwise>${days[2]}</c:otherwise></c:choose></div>
		            <div style="width:130px;"><c:choose><c:when test="${days[3] == null}">-</c:when><c:otherwise>${days[3]}</c:otherwise></c:choose></div>
		            <div style="width:130px;"><c:choose><c:when test="${days[4] == null}">-</c:when><c:otherwise>${days[4]}</c:otherwise></c:choose></div>
		            <div style="width:130px;"><c:choose><c:when test="${days[5] == null}">-</c:when><c:otherwise>${days[5]}</c:otherwise></c:choose></div>
		            <div style="width:130px;"><c:choose><c:when test="${days[6] == null}">-</c:when><c:otherwise>${days[6]}</c:otherwise></c:choose></div>
                </div>
            </c:forEach>
        </div>

        <div style="position: fixed; bottom: 220px; left: 50%; transform: translateX(-50%); width: 170px;">
            <button class="btn btn-neutral" onclick="location.href='/sch/admin/createSchedule'" style="width:170px;">AI 근무표 생성</button>
        </div>
    </div>
</section>

<%@ include file="/view/sch/common/footer.jsp"%>
