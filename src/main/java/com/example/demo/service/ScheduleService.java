package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ScheduleDao;
import com.example.demo.dto.Schedule;

@Service
public class ScheduleService {
	
	private ScheduleDao shceduleDao;
	
	public ScheduleService(ScheduleDao shceduleDao) {
		this.shceduleDao = shceduleDao;
	}
	
	public void doApply() {
		this.shceduleDao.doApply();
	}

	public void save(Schedule schedule) {
		// TODO Auto-generated method stub
		
	}

}
