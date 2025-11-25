package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
	private int id;
	private String regDate;
	private String userId;
	private String password;
	private String name;
	private String sex;
	private String phoneNum;
	private String birthDate;
}