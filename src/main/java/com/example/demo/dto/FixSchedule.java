package com.example.demo.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FixSchedule {
	private int id;
	private String userName;
	private LocalDate weekStart;
	private int weekDay;
	private String workStatus;
	private String startTime;
	private String endTime;
	private int confirm;
	
	private LocalDateTime start;
	private LocalDateTime end;
}
