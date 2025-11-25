<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="근무 신청" />

<%@ include file="/view/sch/common/header2.jsp"%>
	
	<section class="area">
		<div class="table">
			<form id="scheduleForm">
				<div class="table-box">
					<div style="font-size: 25px; font-weight: bold; padding: 15px; margin-bottom: 15px;">근무 신청</div>
					<tr>
						<td>월요일</td>
						<td>
							<select class="select" name="workStatus1" style="width:80px; height: 30px; margin: 0 7px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td><input class="input" type="time" name="startTime1" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<td><input class="input" type="time" name="endTime1" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					
					<tr>
						<td>화요일</td>
						<td>
							<select class="select" name="workStatus2" style="width:80px; height: 30px; margin: 0 7px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td><input class="input" type="time" name="startTime2" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<td><input class="input" type="time" name="endTime2" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>수요일</td>
						<td>
							<select class="select" name="workStatus3" style="width:80px; height: 30px; margin: 0 7px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td><input class="input" type="time" name="startTime3" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<td><input class="input" type="time" name="endTime3" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>목요일</td>
						<td>
							<select class="select" name="workStatus4" style="width:80px; height: 30px; margin: 0 7px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td><input class="input" type="time" name="startTime4" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<td><input class="input" type="time" name="endTime4" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>금요일</td>
						<td>
							<select class="select" name="workStatus5" style="width:80px; height: 30px; margin: 0 7px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td><input class="input" type="time" name="startTime5" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<td><input class="input" type="time" name="endTime5" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>토요일</td>
						<td>
							<select class="select" name="workStatus6" style="width:80px; height: 30px; margin: 0 7px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td><input class="input" type="time" name="startTime6" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<td><input class="input" type="time" name="endTime6" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<td>일요일</td>
						<td>
							<select class="select" name="workStatus7" style="width:80px; height: 30px; margin: 0 7px;">
								<option class="select" disabled selected value="0">--</option>
								<option class="select" value="yes">근무</option>
								<option class="select" value="no">휴무</option>
							</select>
						</td>
						<td><input class="input" type="time" name="startTime7" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<td><input class="input" type="time" name="endTime7" style="width:120px; height: 30px; margin: 0 3px;"/></td>
						<div style="margin-bottom: 13px;"></div>
					</tr>
					<tr>
						<button class="btn btn-neutral" type="button" onclick="submitSchedule()" style="width: 188px; margin: 0 18px;">임시 저장</button>
						<button class="btn btn-neutral" style="width: 188px; margin-right: 18px;">최종 신청</button>
					</tr>
				</div>
			</form>
		</div>
	</section>
	
	<script>
		function submitSchedule() {
			var formData = $('#scheduleForm').serialize();

			$.ajax({
				url: '/sch/schedule/apply',
				type: 'post',  //내일 get post 구분 확실히
				data: formData,
				success: function(data) {
					alert(data.msg);
				},
				error: function() {
					alert('오류 발생');
				}
			});
		}
	</script>
<%@ include file="/view/sch/common/footer.jsp"%>