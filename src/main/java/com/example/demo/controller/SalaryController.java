package com.example.demo.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.example.demo.dto.FixSchedule;
import com.example.demo.service.ScheduleService;


@Controller
public class SalaryController {
	
	private ScheduleService scheduleService;
	
	public SalaryController(ScheduleService scheduleService) {
		this.scheduleService = scheduleService;
	}
	
	@GetMapping("/sch/salary/select") 
	public String selectSalary(Model model, @SessionAttribute("loginUserName") String userName, @RequestParam(required = false) String weekStart) {
		
		List<FixSchedule> schedules = this.scheduleService.getFixSchedule(userName);
		
		if(weekStart == null || weekStart.isEmpty()) {
			weekStart = LocalDate.now().withDayOfMonth(1).toString();
		}
		
		model.addAttribute("fixScheduleList", schedules);
		model.addAttribute("userName", userName);
		model.addAttribute("weekStart", weekStart);
		
		return("sch/salary/select");
	}

	
}
