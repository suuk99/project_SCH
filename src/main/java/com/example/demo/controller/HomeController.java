package com.example.demo.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.example.demo.dto.FixSchedule;
import com.example.demo.dto.Notice;
import com.example.demo.service.NoticeService;
import com.example.demo.service.ScheduleService;

@Controller
public class HomeController {
	
	private NoticeService noticeService;
	private ScheduleService scheduleService;
	
	public HomeController(NoticeService noticeService, ScheduleService scheduleService) {
		this.noticeService = noticeService;
		this.scheduleService = scheduleService;
	}
	
	@GetMapping("/sch/home/main")
	public String main(Model model, @SessionAttribute("loginUserName") String userName) {
		List<Notice> noticeList = this.noticeService.showNoticeList(0, 5);
		
		LocalDate weekStart = LocalDate.now().with(DayOfWeek.MONDAY);
		List<FixSchedule> scheduleList = this.scheduleService.getFixSchedule(userName);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("scheduleList", scheduleList);
		model.addAttribute("weekStart", weekStart);
		return "sch/home/main";
	}
}
