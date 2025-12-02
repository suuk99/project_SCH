package com.example.demo.controller;

import java.sql.Time;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ScheduledExecutorService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

import jakarta.servlet.http.HttpServletRequest;
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
	public String apply(Model model, @RequestParam(required = false) String start, @RequestParam(required = false) String end) {
		model.addAttribute("start", start);
		model.addAttribute("end", end);
		return "sch/schedule/apply";
	}
	
	@PostMapping("/sch/schedule/doApply")
	@ResponseBody
	public String doApply(HttpSession session, HttpServletRequest request) {
	    String userId = (String) session.getAttribute("loginUserId");
	    String weekStartStr = request.getParameter("weekStart");

	    if(weekStartStr == null || weekStartStr.isEmpty()) return "주 시작일이 필요합니다.";

	    LocalDate weekStart;
	    try {
	        weekStart = LocalDate.parse(weekStartStr);
	    } catch(Exception e) {
	        return "주 시작일 형식이 잘못되었습니다.";
	    }

	    for (int i = 1; i <= 7; i++) {
	        String workStatus = request.getParameter("workStatus" + i);
	        String startTimeStr = request.getParameter("startTime" + i);
	        String endTimeStr = request.getParameter("endTime" + i);

	        // 근무 여부 강제 검증
	        if(!"yes".equals(workStatus) && !"no".equals(workStatus)) {
	            return i + "요일 근무 여부를 선택해주세요.";
	        }

	        // 근무 선택 시 출퇴근 시간 필수 검사
	        if("yes".equals(workStatus)) {
	            if(startTimeStr == null || startTimeStr.isEmpty() || endTimeStr == null || endTimeStr.isEmpty()) {
	                return i + "요일 출퇴근 시간을 모두 입력해주세요.";
	            }
	        }

	        Schedule s = new Schedule();
	        s.setUserId(userId);
	        s.setWeekStart(weekStart);
	        s.setWeekDay(i);
	        s.setWorkStatus(workStatus);
	        s.setConfirm(false);

	

	        scheduleService.saveSchedule(s);
	    }

	    return "success";
	}
	
	@GetMapping("/sch/schedule/event")
	@ResponseBody
	public List<Map<String, Object>> getScheduleEvent(@SessionAttribute("loginUserId") String userId) {
	    List<Map<String,Object>> schedules = scheduleService.getScheduleByUser(userId);

	    List<Map<String,Object>> events = new ArrayList<>();
	    DateTimeFormatter tf = DateTimeFormatter.ofPattern("HH:mm");

	    for(Map<String,Object> s : schedules) {
	    	String date = s.get("start").toString();

	        String title = "";

	        if("yes".equals(s.get("workStatus"))) {
	            String start = "";
	            String end = "";

	            Object startObj = s.get("startTime");
	            if(startObj != null) {
	                start = ((Time)startObj).toLocalTime().format(tf);
	            }

	            Object endObj = s.get("endTime");
	            if(endObj != null) {
	                end = ((Time)endObj).toLocalTime().format(tf);
	            }

	            title = start + "-" + end;
	        }
	        if (!title.isEmpty()) {
	        	Map<String,Object> event = new HashMap<>();
	        	event.put("title", title);
	        	event.put("start", date);
	        	events.add(event);
	        }
	    }
	    return events;
	}
	
	//근무 신청 여부
	@GetMapping("/sch/schedule/isSubmit")
	@ResponseBody
	public boolean isSubmit(@SessionAttribute("loginUserId") String userId, @RequestParam String weekStart) {
		LocalDate start = LocalDate.parse(weekStart);
		return scheduleService.isSubmit(userId, start);
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
