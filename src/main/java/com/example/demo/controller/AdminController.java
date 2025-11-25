package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.UserService;

@Controller
public class AdminController {
	
	private UserService userService;
	
	public AdminController (UserService userService) {
		this.userService = userService;
	}
	
	//권한 변경
	@GetMapping("/sch/admin/role")
	@ResponseBody
	public String setRole() {
		
		return "sch/admin/role";
	}
	
	@PostMapping("/sch/amdin/setRole")
	@ResponseBody
	public String updateRole(String id, String role) {
		this.userService.updateRole(id, role);
		return "success";
	}
	
	//시간표 업로드
	@GetMapping("/sch/admin/uploadTimeTable")
	public String uploadTimeTable() {
		return "sch/admin/uploadTimeTable";
	}
	
	//시간 변경 대타 승인
	@GetMapping("/sch/admin/approve")
	public String approwe() {
		return "sch/admin/approve";
	}
	
	//공지사항 게시판 글쓰기 -> 수정, 삭제도 추가 해야함
	@GetMapping("/sch/admin/write")
	public String write() {
		return "sch/admin/write";
	}
}