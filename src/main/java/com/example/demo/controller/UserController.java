package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String doJoin(String userId, String password, String checkPw, String name, String birthDate, String phoneNum, String sex) {
		
		this.userService.joinUser(userId, password, name, birthDate, phoneNum, sex);
		
		return Util.jsReplace("회원가입이 요청이 완료되었습니다.", "/sch/user/login");
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
		
		if (password.trim().length() == 0 || checkPw.trim().length() == 0) {
			return new ResultData<>("F-2", "비밀번호를 입력해 주세요.");
		}
		
		if (checkPw.trim().length() < 5) {
			return new ResultData<>("F-3", "비밀번호를 확인해 주세요.");
		}
	    boolean isMatch = this.userService.getCheckPw(password, checkPw);
	    
	    if (!isMatch && checkPw.trim().length() >= 5) {
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
	    return new ResultData<>("S-1", " ");
	}
	
	@GetMapping("/sch/user/bdChk")
	@ResponseBody
	public ResultData checkBd(String birthDate) {
	    boolean isValid = this.userService.getBdChk(birthDate);
	    
	    if (!isValid) {
	        return new ResultData<>("F-1", "생년월일을 입력하세요.");
	    }
	    return new ResultData<>("S-1", " ");
	}

	@GetMapping("/sch/user/pnChk")
	@ResponseBody
	public ResultData checkPn(String phoneNum) {
	    boolean isValid = this.userService.getPnChk(phoneNum);
	    
	    if (!isValid) {
	        return new ResultData<>("F-1", "전화번호를 입력하세요.");
	    }
	    return new ResultData<>("S-1", " ");
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
	
	@PostMapping("/sch/user/validLogin")
	@ResponseBody
	public ResultData<Integer> validLogin(String userId, String password) {
		User user = this.userService.getUserLoginId(userId);
		
		if (userId == null || userId.trim().isEmpty() || password == null || password.trim().isEmpty()) {
			return new ResultData<>("F-0", "아이디 또는 비밀번호를 입력해 주세요.");
		}
		
		if (user == null || !user.getPassword().equals(password)) {
			return new ResultData<>("F-1", "아이디 또는 비밀번호를 확인해 주세요.");
		}
		
		return new ResultData<>("S-1", "");
	}
	
	@PostMapping("/sch/user/doLogin")
	@ResponseBody
	public String doLogin(HttpSession session, Integer loginUserId, String userId) {
		User user = this.userService.getUserLoginId(userId);

		session.setAttribute("loginUserId", user.getUserId());
		session.setAttribute("loginUserID", user.getId());
		session.setAttribute("loginUserName", user.getName());
		return Util.jsReplace("", "/sch/home/main");
	}
	
	//로그아웃
	@GetMapping("/sch/user/logout")
	@ResponseBody
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return Util.jsReplace("로그아웃이 완료되었습니다.", "/sch/user/login");
	}
	
	//내정보
	@GetMapping("/sch/user/information")
	public String selectInfo(HttpSession session, Model model) {
		
		Object obj = session.getAttribute("loginUserId");
		
		String userId = String.valueOf(obj);
		
		User user = userService.getUserLoginId(userId);
		
		model.addAttribute("user", user);
		
		return "sch/user/information";
	}
	
	//비밀번호 변경
	@GetMapping("/sch/user/changePw")
	public String changePw() {
		return "sch/user/changePw";
	}
	
	@PostMapping("/sch/user/doChangePw")
	@ResponseBody
	public String doChangePw(HttpSession session, String password, String nowPw, String checkPw, String newPw) {
		String userId = (String) session.getAttribute("loginUserId");
		
		User user = userService.getUserLoginId(userId);
		
		if (nowPw.length() == 0) {
			return Util.jsReplace("현재 비밀번호를 입력해 주세요.", "/sch/user/changePw");
		}
		
		if (!user.getPassword().equals(nowPw)) {
			return Util.jsReplace("현재 비밀번호가 일치하지 않습니다.", "/sch/user/changePw");
		}
		
		if (!newPw.equals(checkPw)) {
			return Util.jsReplace("새 비밀번호가 일치하지 않습니다.", "/sch/user/changePw");
		}
		
		if (newPw.length() < 5 || checkPw.length() < 5) {
			return Util.jsReplace("비밀번호는 5자 이상이어야 합니다.", "/sch/user/changePw");
		}
		
		this.userService.updatePw(userId, newPw);
		
		return Util.jsReplace("비밀번호 변경이 완료되었습니다", "/sch/home/main");
	}
	
	//급여조회
	@GetMapping("/sch/user/selectSal")
	public String selectSal() {
		return "sch/user/selectSal";
	}
}
