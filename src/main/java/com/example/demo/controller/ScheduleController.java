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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.example.demo.dao.ScheduleDao;
import com.example.demo.dto.FixSchedule;
import com.example.demo.dto.ResultData;
import com.example.demo.dto.Schedule;
import com.example.demo.dto.SwapRequest;
import com.example.demo.service.ScheduleService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;

@Controller
public class ScheduleController {
	
	private ScheduleService scheduleService;
	private ScheduleDao scheduleDao;
	private ScheduleNotificationController notifier;
	
	public ScheduleController(ScheduleService scheduleService, ScheduleDao scheduleDao, ScheduleNotificationController notifier) {
		this.scheduleService = scheduleService;
		this.scheduleDao = scheduleDao;
		this.notifier = notifier;
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
	    
	    if (weekStartStr == null || weekStartStr.isEmpty()) {
	    	return "weekStart값 없음";
	    }
	    
	    LocalDate weekStart = LocalDate.parse(weekStartStr);
	    
	    for (int i=1; i<=7; i++) {
	        String workStatus = request.getParameter("workStatus"+i);
	        if(workStatus == null || workStatus.equals("0")) {
	        	continue;
	        }

	        Schedule s = new Schedule();
	        s.setUserId(userId);
	        s.setWeekStart(weekStart);
	        s.setWeekDay(i);
	        s.setWorkStatus(workStatus);
	        s.setStartTime(request.getParameter("startTime"+i));
	        s.setEndTime(request.getParameter("endTime"+i));
	        s.setConfirm(0);

	        if(s.getStartTime() != null && s.getStartTime().isEmpty()) {
	            s.setStartTime(null);
	        }
	        if(s.getEndTime() != null && s.getEndTime().isEmpty()) {
	            s.setEndTime(null);
	        }
	        
	        if(s.getWorkStatus() == null || s.getWorkStatus().trim().equals("")) {
	        	return Util.jsReplace("근무여부를 모두 선택해주세요.", "");
	        }

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
	
	//근무시간 조회
	@GetMapping("/sch/schedule/list")
	public String scheduleList(Model model, @SessionAttribute("loginUserName") String userName, @RequestParam(required = false) String weekStart) {
		// 월요일을 기본값으로 세팅
		if(weekStart == null) {
			weekStart = LocalDate.now().with(DayOfWeek.MONDAY).toString();
		}
		// 확인버튼 활성화 여부
		Integer confirm = scheduleService.getUserConfirm(userName, weekStart);
		if(confirm == null) confirm = 0;
		
		model.addAttribute("confirm", confirm);
		model.addAttribute("weekStart", weekStart);
		
		List<FixSchedule> fixed = scheduleService.getFixSchedule(userName);
		model.addAttribute("fixed", fixed);
		
		return "sch/schedule/list";
	}
	
	//근무확정 클릭
	@PostMapping("/sch/schedule/confirm")
	@ResponseBody
	public String scheduleConfirm(@RequestParam String weekStart, HttpSession session) {
		//로그인 사용자 이름
		String userName = (String) session.getAttribute("loginUserName");
		//사용자 확정 저장
		this.scheduleService.confirmSchedule(weekStart, userName);
		//모든 사용자 확정 여부 확인
		boolean allConfirm = scheduleService.allUserConfirm(weekStart);
		
		if(allConfirm) {
			//최종 확정 처리
			scheduleService.adminConfirm(weekStart);
		}
		return "success";
	}
	
	//대타요청 기능
	@GetMapping("/sch/schedule/swap")
	public String scheduleSwap(Model model, @RequestParam(value = "week", required = false) String weekStart,
							   @SessionAttribute("loginUserName") String loginUserName) {
		
		//월요일 계산
		LocalDate now = LocalDate.now();
		LocalDate monday = now.with(DayOfWeek.MONDAY);
		
		//화면에서 선택할 수 있는 주 생성
		List<Map<String, String>> weekList = new ArrayList<>();
		for(int i = 0; i < 3; i ++) {
			LocalDate start = monday.plusWeeks(i);
			LocalDate end = start.plusDays(6);
			Map<String, String> weekMap = new HashMap<>();
			weekMap.put("start", start.toString());
			weekMap.put("display", start.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))
						+ " ~ " + end.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
			weekList.add(weekMap);
		}
		//기본 주 설정(이번 주)
		if(weekStart == null) weekStart = monday.toString();
		
		//선택된 주의 날짜(월~일)
		LocalDate startDate = LocalDate.parse(weekStart);
		List<String> weekDates = new ArrayList<>();
		for(int i = 0; i < 7; i ++) {
			weekDates.add(startDate.plusDays(i).toString());
		}
		
		// 모든 사용자 목록
		List<Map<String, Object>> allUsers = this.scheduleDao.getUserInfo();
		
		//관리자, 본인 제외 사용자
		List<Map<String, Object>> filterUsers = new ArrayList<>();
		for(Map<String, Object> u : allUsers) {
			String name = (String) u.get("name");
			if(!"관리자".equals(name) && !loginUserName.equals(name)) {
				filterUsers.add(u);
			}
		}
		
		//확정 시간 가져오기
		Map<String, String[]> scheduleMap = scheduleService.getFixScheduleByWeek(weekStart);
		
		model.addAttribute("weekList", weekList);
		model.addAttribute("selectWeek", weekStart);
		model.addAttribute("weekDates", weekDates);
		model.addAttribute("userList", filterUsers);
		model.addAttribute("scheduleList", scheduleMap.entrySet());
		return "sch/schedule/swap";
	}
	
	@PostMapping("/sch/schedule/swap/request")
	@ResponseBody
	public String requestSwap(@RequestBody Map<String, Object> data) {
		this.scheduleService.requestSwap(data);
		
		//웹소켓으로 알림 전송
		String targetUser = (String) data.get("target"); //요청받는 사용자
		String requester = (String) data.get("requester"); //요청한 사용자
		String message = requester + "님이 대타를 요청했습니다. 바로 확인해주세요!";
		notifier.sendAlertToUser(targetUser, message);
		
		return "SUCCESS";
	}
	
	@GetMapping("/sch/schedule/swapConfirm")
	public String swapConfirm(Model model, @SessionAttribute("loginUserName") String userId) {
		List<SwapRequest> requests = scheduleService.getPending(userId);
		model.addAttribute("requests", requests);
		return "sch/schedule/swapConfirm";
	}
	
	
}
