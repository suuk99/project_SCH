package com.example.demo.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Schedule {
	private int id;
	private String userId;
	private String weekStart;	// 그 주의 월요일 날짜
	private int weekDay;			// 1=월, 2=화 ..
	private String startTime;		// HH:mm
	private String endTime;			// HH:mm
	private boolean confirm;		// 승인 여부
	private String workStatus;
	private LocalDate start;
}