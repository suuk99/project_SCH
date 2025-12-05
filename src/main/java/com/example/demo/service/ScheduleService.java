package com.example.demo.service;

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
}
