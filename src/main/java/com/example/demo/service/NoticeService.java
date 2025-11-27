package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.NoticeDao;
import com.example.demo.dto.Notice;

@Service
public class NoticeService {
	
	private NoticeDao noticeDao;
	
	public NoticeService(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}

	public void doWrite(String title, String content, int loingUserID) {
		this.noticeDao.doWrite(title, content, loingUserID);
	}

	public List<Notice> showNoticeList() {
		return this.noticeDao.showNoticeList();
	}

	public Notice getNoticeId(int id) {
		return this.noticeDao.getNoticeId(id);
	}
}
