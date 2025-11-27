package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Notice {
	private int id;
	private String title;
	private String content;
	private int writerId;
	private String regDate;
	private String updateDate;
	private int hit;
	private String writerName;
}
