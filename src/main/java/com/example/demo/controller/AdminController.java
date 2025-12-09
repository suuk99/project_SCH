package com.example.demo.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ScheduleService;
import com.example.demo.service.UserService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AdminController {
	
	private final ScheduleNotificationController notifier;
    private final ScheduleService scheduleService;
    private UserService userService;

    public AdminController(ScheduleService scheduleService, ScheduleNotificationController notifier, UserService userService) {
        this.scheduleService = scheduleService;
        this.notifier = notifier;
        this.userService = userService;
    }

    @GetMapping("/sch/admin/checkApply")
    public String checkApply(@RequestParam(value="week", required=false) String weekParam, Model model) {

        LocalDate today = LocalDate.now();
        int dayOfWeek = today.getDayOfWeek().getValue();
        LocalDate thisMonday = today.minusDays(dayOfWeek - 1);
        LocalDate start = thisMonday.plusWeeks(2);

        List<Map<String, String>> weekList = new ArrayList<>();
        for (int i = 0; i <= 4; i++) {
            LocalDate weekStart = start.plusWeeks(i);
            LocalDate weekEnd = weekStart.plusDays(6);
            Map<String, String> weekInfo = new HashMap<>();
            weekInfo.put("start", weekStart.toString());       // value용
            weekInfo.put("display", weekStart + " ~ " + weekEnd); // 화면용
            weekList.add(weekInfo);
        }

        String selectWeek = weekParam != null ? weekParam.substring(0, 10) : weekList.get(0).get("start");
        LocalDate selectedWeekStart = LocalDate.parse(selectWeek);

        List<Map<String, Object>> list = scheduleService.getAllSchedule(selectedWeekStart);

        Map<String, String[]> scheduleMap = new LinkedHashMap<>();
        for (Map<String, Object> row : list) {
            String name = (String) row.get("name");
            Integer day = (Integer) row.get("weekDay");
            scheduleMap.putIfAbsent(name, new String[7]);
            
            if (day == null) {
                continue;
            }
            String startTime = row.get("startTime") != null ? row.get("startTime").toString() : "";
            String endTime = row.get("endTime") != null ? row.get("endTime").toString() : "";
            String display = (!startTime.isEmpty() && !endTime.isEmpty()) ? startTime.substring(0,5) + "-" + endTime.substring(0,5) : "off";
            
            scheduleMap.get(name)[day - 1] = display;
        }

        model.addAttribute("scheduleList", scheduleMap);
        model.addAttribute("weekList", weekList);
        model.addAttribute("selectWeek", selectWeek);

        return "sch/admin/checkApply";
    }
    
    //스케줄 작성 등록
    @GetMapping("/sch/admin/createSchedule")
    public String createSchedule(@RequestParam(required = false) String week, Model model) {
    	
        // 1) 주 선택(selectWeek) 처리
        LocalDate today = LocalDate.now();
        int dayOfWeek = today.getDayOfWeek().getValue();
        LocalDate thisMonday = today.minusDays(dayOfWeek - 1);
        LocalDate baseStart = thisMonday.plusWeeks(2);

        List<Map<String, String>> weekList = new ArrayList<>();

        for (int i = 0; i <= 4; i++) {
            LocalDate ws = baseStart.plusWeeks(i);
            LocalDate we = ws.plusDays(6);

            Map<String, String> map = new HashMap<>();
            map.put("start", ws.toString());
            map.put("display", ws + " ~ " + we);
            weekList.add(map);
        }

        String selectWeek = (week != null) ? week.substring(0, 10) : weekList.get(0).get("start");
        LocalDate selectedWeekStart = LocalDate.parse(selectWeek);

        // 2) 신청 / 스케줄 데이터 조회
        List<Map<String, Object>> list = scheduleService.getAllSchedule(selectedWeekStart);

        Map<String, String[]> scheduleMap = new LinkedHashMap<>();

        for (Map<String, Object> row : list) {
            String name = (String) row.get("name");
            Integer day = (Integer) row.get("weekDay");

            scheduleMap.putIfAbsent(name, new String[7]);

            if (day == null) continue;

            String startTime = row.get("startTime") != null ? row.get("startTime").toString() : "";
            String endTime   = row.get("endTime") != null ? row.get("endTime").toString() : "";

            String display = (!startTime.isEmpty() && !endTime.isEmpty())
                    ? startTime.substring(0,5) + "-" + endTime.substring(0,5)
                    : "off";

            scheduleMap.get(name)[day - 1] = display;
        }
        // 3) JSP로 전달
        model.addAttribute("weekList", weekList);
        model.addAttribute("selectWeek", selectWeek);
        model.addAttribute("scheduleList", scheduleMap);

        return "sch/admin/createSchedule";
    }
    
    @PostMapping("/sch/admin/saveSchedule")
    @ResponseBody
    public String saveSchedule(@RequestBody Map<String, Object> payload) {
        String weekStart = (String) payload.get("weekStart");
        Map<String, Object> schedule = (Map<String, Object>) payload.get("schedule");


        // schedule 전체 순회 → 서비스 호출
        for (String user : schedule.keySet()) {
            Map<String, Object> data = (Map<String, Object>) schedule.get(user);
            List<String> days = (List<String>) data.get("days");
            List<String> startTimes = (List<String>) data.get("startTimes");
            List<String> endTimes = (List<String>) data.get("endTimes");

            for (int i = 0; i < 7; i++) {
            	scheduleService.saveFixSchedule(user, weekStart, i + 1, days.get(i), startTimes.get(i), endTimes.get(i));
            }
            this.scheduleService.insertScheduleConfirm(user, weekStart, 0);
        }
        notifier.sendAlertToAll("새로운 스케줄이 등록되었습니다. 지금 확인해 주세요!");
        return "SUCCESS";
    }


    // 시간표 업로드
    @GetMapping("/sch/admin/uploadTimeTable")
    public String uploadTimeTable() {
        return "sch/admin/uploadTimeTable";
    }

    // 시간 변경 대타 승인
    @GetMapping("/sch/admin/approve")
    public String approve() {
        return "sch/admin/approve";
    }
}
