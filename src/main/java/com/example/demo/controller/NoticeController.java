package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

	@PostMapping("/sch/notice/doWrite")
	@ResponseBody
	public String doWrite(HttpSession session, String title, String content) {
		
		if (title.trim().length() == 0) {
			return Util.jsReplace("제목을 입력하세요.", "hb");
		}
		
		if (content.trim().length() == 0) {
			return Util.jsReplace("내용을 입력하세요.", "hb");
		}
		
		this.noticeService.doWrite(title, content, (int) session.getAttribute("loginUserID"));
		
		return Util.jsReplace("공지사항 작성이 완료되었습니다.", "/sch/notice/list");
	}

	// 공지사항 목록
	@GetMapping("/sch/notice/list")
	public String noticeList(Model model, @RequestParam(defaultValue = "1") int cPage) {
		//페이징
		int itemsInAPage = 10;
				
		int limitFrom = (cPage - 1) * itemsInAPage;
				
		int articlesCnt = this.noticeService.getArticlesCnt();
				
		int totalPagesCnt = (int) Math.ceil(articlesCnt / (double) itemsInAPage);
				
		int begin = ((cPage - 1) / 10) * 10 + 1;
		int end = (((cPage - 1) / 10) + 1) * 10;
				
		if (end > totalPagesCnt) {
			end = totalPagesCnt;
		}
		
		List<Notice> noticeList = this.noticeService.showNoticeList(limitFrom, itemsInAPage);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("totalPagesCnt", totalPagesCnt);
		model.addAttribute("articlesCnt", articlesCnt);
		model.addAttribute("begin", begin);
		model.addAttribute("end", end);
		model.addAttribute("cPage", cPage);
		
		return "sch/notice/list";
	}
	
	// 공지사항 상세보기
	@GetMapping("/sch/notice/detail")
	public String detail(HttpSession session, Model model, int id) {
		
		Notice notice = this.noticeService.getNoticeId(id);
		
		// 같은 세션에서 조회수 증가 방지
		String sessionKey = "view_" + id;
		if (session.getAttribute(sessionKey) == null) {
			this.noticeService.addHit(id);  //조회수 증가 
			session.setAttribute(sessionKey, true);
		}
		
		model.addAttribute("notice", notice);
		
		return "/sch/notice/detail";
	}
	
	// 공지사항 수정
	@GetMapping("/sch/notice/modify")
	public String modify(Model model, int id) {
		Notice notice = this.noticeService.getNoticeId(id);
		model.addAttribute("notice", notice);
		return "/sch/notice/modify";
	}
	
	@PostMapping("/sch/notice/doModify")
	@ResponseBody
	public String doModify(int id, String title, String content) {
		this.noticeService.modifyNotice(id, title, content);
		return Util.jsReplace("수정이 완료되었습니다.", "/sch/notice/detail?id=" + id);
	}

	// 공지사항 삭제
	@GetMapping("/sch/notice/delete")
	@ResponseBody
	public String delete(int id) {
		this.noticeService.delete(id);
		
		return Util.jsReplace("삭제가 완료되었습니다.", "/sch/notice/list");
	}
}
