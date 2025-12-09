package com.example.demo.service;

import java.net.http.WebSocket;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ScheduleDao;
import com.example.demo.dto.Schedule;

@Service
public class ScheduleService {
	
	private ScheduleDao scheduleDao;
	
	public ScheduleService(ScheduleDao scheduleDao) {
	    this.scheduleDao = scheduleDao;
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
}
