package com.example.demo.controller;

import java.util.concurrent.ScheduledExecutorService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.example.demo.dto.ResultData;
import com.example.demo.dto.Schedule;
import com.example.demo.service.ScheduleService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;

@Controller
public class ScheduleController {
	
	private ScheduleService scheduleService;
	
	public ScheduleController(ScheduleService scheduleService) {
		this.scheduleService = scheduleService;
	}
	
	//근무 신청
	@GetMapping("/sch/schedule/apply")
	public String apply() {
		return "sch/schedule/apply";
	}
	
	
	@PostMapping("/sch/schedule/doApply")
	@ResponseBody
	public ResultData doApply(@RequestParam("workStatus") String[] workStatus,
							  @RequestParam("startTime") String[] startTime,
							  @RequestParam("endTime") String[] endTime,
							  @SessionAttribute("loginUserId") String userId) {
		
		for (int i = 0; i < 7; i ++) {
			Schedule schedule = new Schedule();
			schedule.setUserId(userId);
			schedule.setWeekDay(i + 1); 
	        schedule.setWorkStatus(workStatus[i]);
	        schedule.setStartTime(startTime[i]);
	        schedule.setEndTime(endTime[i]);
	        schedule.setConfirm(false);
	        
	        scheduleService.save(schedule);
		}
		
		return new ResultData<>("S-1", "근무신청이 완료되었습니다.");
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
