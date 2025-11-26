package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ScheduleDao;
import com.example.demo.dto.Schedule;

@Service
public class ScheduleService {
	
	private ScheduleDao scheduleDao;
	
	public ScheduleService(ScheduleDao shceduleDao) {
		this.scheduleDao = shceduleDao;
	}

	public void saveSchedule(Schedule schedule) {
		this.scheduleDao.saveSchedule(schedule);
	}

}
