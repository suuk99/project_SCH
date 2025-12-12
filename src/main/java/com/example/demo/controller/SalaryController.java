package com.example.demo.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.FixSchedule;
import com.example.demo.service.ScheduleService;

@Controller
public class SalaryController {
	
	private ScheduleService scheduleService;
	
	public SalaryController(ScheduleService scheduleService) {
		this.scheduleService = scheduleService;
	}
	
	@GetMapping("/sch/salary/select") 
	public String selectSalary() {
		return("sch/salary/select");
	}
	
	@GetMapping("/sch/salary/calendar")
	@ResponseBody
	public List<Map<String, Object>> getFixSchedule(@RequestParam String userName, @RequestParam String month) {
		LocalDate start = LocalDate.parse(month + "-01");
		LocalDate end = start.withDayOfMonth(start.lengthOfMonth());
		
		//확정 스케줄 조회
		List<FixSchedule> schedules = this.scheduleService.getFixSchedule(userName);
		
		List<Map<String, Object>> events = new ArrayList<>();
		for(FixSchedule s : schedules) {
			Map<String, Object> event = new HashMap<>();
			event.put("title", s.getWorkStatus());
			LocalDate eventDate = s.getWeekStart().plusDays(s.getWeekDay() - 1);
			event.put("start", eventDate.toString());
			event.put("startTime", s.getStartTime());
			event.put("endTime", s.getEndTime());
			events.add(event);
		}
		return events;
	}
	
}
