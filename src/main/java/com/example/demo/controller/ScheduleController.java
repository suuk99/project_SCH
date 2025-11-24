package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;

@Controller
public class ScheduleController {
	
	//근무 신청
	@GetMapping("/sch/schedule/apply")
	public String apply() {
		return "sch/schedule/apply";
	}
	
	//근무 확정
	@GetMapping("/sch/schedule/confirm")
	public String scheduleConfirm() {
		return "sch/schedule/confirm";
	}
	
	//근무시간 조회
	@GetMapping("/sch/schedule/list")
	public String scheduleList() {
		return "sch/schedule/list";
	}
	
	//시간변경 대타
	@GetMapping("/sch/schedule/swap")
	public String scheduleSwap() {
		return "sch/schedule/swap";
	}
	
}
