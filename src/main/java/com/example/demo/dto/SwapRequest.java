package com.example.demo.dto;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SwapRequest {
	private String requester;
	private String target;
	private LocalDate weekStart;
	private int weekDate;
	private LocalTime startTime;
	private LocalTime endTime;
	private String status;
	private String startTimeStr;
	private String endTimeStr;
	private LocalDate swapDate;
	private int id;
}