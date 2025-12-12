package com.example.demo.service;

import java.net.http.WebSocket;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.demo.controller.ScheduleNotificationController;
import com.example.demo.dao.ScheduleDao;
import com.example.demo.dto.FixSchedule;
import com.example.demo.dto.Schedule;
import com.example.demo.dto.SwapRequest;

@Service
public class ScheduleService {
	
	private ScheduleNotificationController notifier;
	private ScheduleDao scheduleDao;
	
	public ScheduleService(ScheduleDao scheduleDao, ScheduleNotificationController notifier) {
	    this.scheduleDao = scheduleDao;
	    this.notifier = notifier;
	}

	public void saveSchedule(Schedule schedule) {
		this.scheduleDao.saveSchedule(schedule);
	}

	public List<Map<String, Object>> getScheduleByUser(String userId) {
		return this.scheduleDao.getScheduleByUser(userId);
	}

	public boolean isSubmit(String userId, LocalDate weekStart) {
		return this.scheduleDao.isSubmit(userId, weekStart) > 0;
	}

	public List<Map<String, Object>> getAllSchedule(LocalDate weekStart) {
		return this.scheduleDao.getAllSchedule(weekStart);
	}

	public List<Map<String, Object>> getApplyList(LocalDate weekStart) {
		return this.scheduleDao.getApplyList(weekStart);
	}

	public List<String> getAllUser() {
		return this.scheduleDao.getAllUser();
	}
	
	public void saveFixSchedule(String userName, String weekStart, int weekDay, String workStatus, String start, String end) {
			scheduleDao.saveFixSchedule(userName, weekStart, weekDay, workStatus, start, end);
	}

	public void confirmSchedule(String weekStart, String userName) {
		this.scheduleDao.confirmSchedule(weekStart, userName);
	}
	
	//확정 안 한 사용자 수 확인
	public boolean allUserConfirm(String weekStart) {
		int unconfirmed = scheduleDao.countUnconfirmUser(weekStart);
		return unconfirmed == 0;
	}
	
	public void adminConfirm(String weekStart) {
		//전 주 확정스케줄 삭제
		this.scheduleDao.deletFixSchedule(weekStart);
		//이번주 스케줄 저장
		this.scheduleDao.copyFixSchedule(weekStart);
	}

	public void insertScheduleConfirm(String userName, String weekStart, int confirm) {
		this.scheduleDao.insertScheduleConfirm(userName, weekStart, confirm);
	}

	public Integer getUserConfirm(String userName, String weekStart) {
		return this.scheduleDao.getUserConfirm(userName, weekStart);
	}

	public List<FixSchedule> getFixSchedule(String userName) {
	    List<FixSchedule> list = scheduleDao.getFixSchedule(userName);

	    for (FixSchedule fs : list) {

	        // weekStart + weekDay 로 날짜 계산
	        LocalDate base = fs.getWeekStart().plusDays(fs.getWeekDay() - 1);

	        String start = fs.getStartTime();
	        String end = fs.getEndTime();

	        // ⭐ null 방어 로직 추가 (중요)
	        if (start == null || end == null) {
	            // null이면 캘린더에 표시 못하므로 그냥 건너뜀
	            continue;
	        }

	        fs.setStart(LocalDateTime.parse(base + "T" + start));
	        fs.setEnd(LocalDateTime.parse(base + "T" + end));
	        fs.setDate(base);
	    }
	    return list;
	}

	public Map<String, String[]> getFixScheduleByWeek(String weekStartStr) {

	    Map<String, String[]> scheduleMap = new LinkedHashMap<>();

	    // DAO에서 필요한 데이터 전부 가져오기
	    List<Map<String, Object>> users = scheduleDao.getAllUserName(weekStartStr);

	    for (Map<String, Object> user : users) {

	    	String userName = (String) user.get("name");
	        Integer weekDay = user.get("weekDay") instanceof Number ? ((Number) user.get("weekDay")).intValue() : null;
	        String startTime = (String) user.get("startTime");
	        String endTime = (String) user.get("endTime");

	        scheduleMap.putIfAbsent(userName, new String[7]);
	        String[] days = scheduleMap.get(userName);

	        // 실제 근무시간이 있는 경우만 넣음
	        if (weekDay != null && startTime != null && endTime != null) {
	            days[weekDay - 1] = startTime.substring(0, 5) + "~" + endTime.substring(0, 5);
	        } else {
	            days[weekDay != null ? weekDay - 1 : 0] = null; // 비어있으면 null
	        }
	    }
	    return scheduleMap;
	}

	public void requestSwap(Map<String, Object> data) {
		this.scheduleDao.insertSwapRequest(data);
	}

	public List<SwapRequest> getPending(String userId) {
		return this.scheduleDao.getPending(userId);
	}

	public void updateSwapStatus(int id, String status) {
		this.scheduleDao.updateSwapStatus(id, status);
	}

	public void processSwapAppove(int id) {
		SwapRequest req = scheduleDao.getSwapRequestId(id);
		
		String requester = req.getRequester();
		String target = req.getTarget();
		LocalDate swapDate = req.getSwapDate();
		int weekDate = req.getWeekDate();
		LocalTime startTime = req.getStartTime();
		LocalTime endTime = req.getEndTime();
		LocalDate weekStart = req.getWeekStart();
		
		//형변환
		String start = startTime.toString();
		String end = endTime.toString();
		
		//요청 상태 수락으로 변경
		this.scheduleDao.updateSwapStatus(id, "approved");
		//요청자 기존 근무 삭제
		this.scheduleDao.deleteFixSchedule(requester, weekStart, weekDate);
		//수락자 근무 추가
		this.scheduleDao.insertFixSchedule(target, weekStart, weekDate, "대타", start, end, 1);
		
		//수락 시 웹소켓으로 요청자에게 알림
		this.notifier.sendAlertToUser(requester, "대타 요청이 수락되었습니다.");
	}
}
