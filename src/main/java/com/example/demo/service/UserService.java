package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.UserDao;
import com.example.demo.dto.User;

@Service
public class UserService {
	
	private UserDao userDao;
	
	public UserService (UserDao userDao) {
		this.userDao = userDao;
	}
	
	//회원가입
	public void joinUser(String userId, String password, String name, String birthDate, String phoneNum, String sex) {
		this.userDao.joinUser(userId, password, name, birthDate, phoneNum, sex);
	}
	
	//아이디 가져오기
	public User getUserLoginId(String userId) {
		return this.userDao.getUserLoginId(userId);
	}
	
	//비밀번호 길이 확인
	public boolean getPassword(String password) {
		return password != null && password.trim().length() >= 5;
	}

	//비밀번호 일치 확인
	public boolean getCheckPw(String password, String checkPw) {
		return password.equals(checkPw);
	}

	//이름 확인
	public boolean getNameChk(String name) {
		return name != null && !name.trim().isEmpty();
	}

	//성별 확인
	public boolean getSexChk(String sex) {
		return sex != null && !sex.equals("0");
	}

	public boolean getBdChk(String birthDate) {
		return birthDate != null && !birthDate.trim().isEmpty();
	}

	public boolean getPnChk(String phoneNum) {
		return phoneNum != null && phoneNum.trim().isEmpty();
	}

	public void updatePw(String userId, String newPw) {
		this.userDao.updatePw(userId, newPw);
	}
}
