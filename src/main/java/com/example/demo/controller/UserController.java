package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.ResultData;
import com.example.demo.dto.User;
import com.example.demo.service.UserService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	
	private UserService userService;
	
	public UserController(UserService userService) {
		this.userService = userService;
	}
	
	//회원가입
	@GetMapping("/sch/user/join")
	public String join() {
		return "sch/user/join";
	}
	
	@PostMapping("/sch/user/doJoin")
	@ResponseBody
	public String doJoin(String userId, String password, String checkPw, String name, String sex) {
		
		this.userService.joinUser(userId, password, name, sex);
		
		return Util.jsReplace("회원가입이 요청이 완료되었습니다.", "/");
	}
	
	@GetMapping("/sch/user/userIdChk")
	@ResponseBody
	public ResultData loginIdChk(String userId) {
		User user = this.userService.getUserLoginId(userId);
		
		if (user != null) {
			return new ResultData<>("F-1", "이미 사용중인 아이디입니다.");
		}
		return new ResultData<>("S-1", "사용 가능한 아이디입니다.");
	}
	
	@GetMapping("/sch/user/passwordChk")
	@ResponseBody
	public ResultData passwordChk(String password) {
	    boolean isValid = this.userService.getPassword(password);
	    
	    if (!isValid) {
	        return new ResultData<>("F-1", "비밀번호는 5자 이상이어야 합니다.");
	    }
	    return new ResultData<>("S-1", "사용 가능한 비밀번호입니다.");
	}

	@GetMapping("/sch/user/checkPw")
	@ResponseBody
	public ResultData checkPw(String password, String checkPw) {
	    boolean isMatch = this.userService.getCheckPw(password, checkPw);
	    
	    if (!isMatch) {
	        return new ResultData<>("F-1", "비밀번호가 일치하지 않습니다.");
	    }
	    return new ResultData<>("S-1", "비밀번호가 일치합니다.");
	}

	@GetMapping("/sch/user/nameChk")
	@ResponseBody
	public ResultData checkName(String name) {
	    boolean isValid = this.userService.getNameChk(name);
	    
	    if (!isValid) {
	        return new ResultData<>("F-1", "이름을 입력하세요.");
	    }
	    return new ResultData<>("S-1", "");
	}

	@GetMapping("/sch/user/sexChk")
	@ResponseBody
	public ResultData checkSex(String sex) {
	    boolean isValid = this.userService.getSexChk(sex);
	    
	    if (!isValid) {
	        return new ResultData<>("F-1", "성별을 선택하세요.");
	    }
	    return new ResultData<>("S-1", "");
	}
	
	
	
	//로그인
	@GetMapping("/sch/user/login")
	public String login() {
		return "sch/user/login";
	}
	
	@GetMapping("/sch/user/doLogin")
	@ResponseBody
	public String doLogin(HttpSession session, String userId, String password) {
		User user = userService.getUserLoginId(userId);
		
		if (user == null || !user.getPassword().equals(password)) {
			return Util.jsReplace("아이디 또는 비밀번호가 잘못되었습니다.", "/sch/user/login");
		}
		
		session.setAttribute("loginMemberId", user.getId());
		return Util.jsReplace("", "/");
	}
	
	//로그아웃
	@GetMapping("/sch/user/logout")
	@ResponseBody
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return Util.jsReplace("로그아웃이 완료되었습니다.", "/");
	}
	
	//스케줄 확인
	@GetMapping("/sch/user/schedule")
	public String schedule() {
		return "sch/user/schedule";
	}
	
	//스케줄 확정
	@GetMapping("/sch/user/confirmSchedule")
	public String confirmSchedule() {
		return "sch/user/confirmSchedule";
	}
	
	//변경 대타 요청
	@GetMapping("/sch/user/requestSwap")
	public String requestSwap() {
		return "sch/user/requestSwap";
	}
}
