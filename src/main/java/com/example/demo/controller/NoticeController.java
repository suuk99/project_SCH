package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Notice;
import com.example.demo.service.NoticeService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpSession;

@Controller
public class NoticeController {

	private NoticeService noticeService;

	public NoticeController(NoticeService noticeService) {
		this.noticeService = noticeService;
	}

	// 공지사항 작성
	@GetMapping("/sch/notice/write")
	public String write() {
		return "sch/notice/write";
	}

	@PostMapping("sch/notice/doWrite")
	@ResponseBody
	public String doWrite(HttpSession session, String title, String content) {
		
		if (title.trim().length() == 0) {
			return Util.jsReplace("제목을 입력하세요.", "hb");
		}
		
		if (content.trim().length() == 0) {
			return Util.jsReplace("내용을 입력하세요.", "hb");
		}
		
		this.noticeService.doWrite(title, content, (int) session.getAttribute("loginUserID"));
		
		return Util.jsReplace("공지사항 작성이 완료되었습니다.", "/sch/home/main");
	}

	// 공지사항 목록
	@GetMapping("/sch/notice/list")
	public String noticeList(Model model) {
		List<Notice> noticeList = this.noticeService.showNoticeList();
		model.addAttribute("noticeList", noticeList);
		return "sch/notice/list";
	}
	
	// 공지사항 상세보기
	@GetMapping("/sch/notice/detail")
	public String detail(Model model, int id) {
		
		Notice notice = this.noticeService.getNoticeId(id);
		
		model.addAttribute("notice", notice);
		
		return "/sch/notice/detail";
	}
	
	// 공지사항 수정
	@GetMapping("/sch/notice/modify")
	public String modify() {
		return "sch/notice/modify";
	}

	// 공지사항 삭제
	@GetMapping("/sch/notice/delete")
	@ResponseBody
	public String delete() {

		return "";
	}
}
