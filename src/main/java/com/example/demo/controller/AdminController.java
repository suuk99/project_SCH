package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
	
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