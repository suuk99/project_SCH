package com.example.demo.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.ScheduleService;

@Controller
public class AdminController {

    private final ScheduleService scheduleService;

    public AdminController(ScheduleService scheduleService) {
        this.scheduleService = scheduleService;
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
            int day = ((Number) row.get("weekDay")).intValue();
            String startTime = row.get("startTime") != null ? row.get("startTime").toString() : "";
            String endTime = row.get("endTime") != null ? row.get("endTime").toString() : "";
            String display = (!startTime.isEmpty() && !endTime.isEmpty()) ? startTime.substring(0,5) + "-" + endTime.substring(0,5) : "off";
            
            scheduleMap.putIfAbsent(name, new String[7]);
            scheduleMap.get(name)[day - 1] = display;
        }

        model.addAttribute("scheduleList", scheduleMap);
        model.addAttribute("weekList", weekList);
        model.addAttribute("selectWeek", selectWeek);

        return "sch/admin/checkApply";
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
