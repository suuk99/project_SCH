package com.example.demo.controller;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
    public String selectSalary(Model model, @SessionAttribute("loginUserName") String userName,
                               @RequestParam(required = false) String weekStart) {

        LocalDate today = LocalDate.now();

        if (weekStart == null || weekStart.isEmpty()) {
            weekStart = today.withDayOfMonth(1).toString(); // 이번 달 1일
        }

        YearMonth requestedMonth = YearMonth.parse(weekStart.substring(0, 7));
        YearMonth currentMonth = YearMonth.from(today);

        List<FixSchedule> schedules;

        if (requestedMonth.isBefore(currentMonth)) {
            // 지난 달 → 조회 가능
            schedules = scheduleService.getFixScheduleByMonth(userName, requestedMonth);
        } else if (requestedMonth.equals(currentMonth)) {
            // 이번 달 → 월말 지나야 조회 가능
            LocalDate lastDay = requestedMonth.atEndOfMonth();
            if (today.isBefore(lastDay)) {
                schedules = Collections.emptyList();
                model.addAttribute("message", "이번 달은 아직 마감되지 않았습니다.");
            } else {
                schedules = scheduleService.getFixScheduleByMonth(userName, requestedMonth);
            }
        } else {
            // 미래 달 → 조회 불가
            schedules = Collections.emptyList();
            model.addAttribute("message", "선택한 월은 아직 마감되지 않았습니다.");
        }

        model.addAttribute("fixScheduleList", schedules);
        model.addAttribute("userName", userName);
        model.addAttribute("weekStart", weekStart);

        return "sch/salary/select";
    }
}
