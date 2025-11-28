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

	public List<Notice> showNoticeList(int limitFrom, int itemsInAPage) {
		return this.noticeDao.showNoticeList(limitFrom, itemsInAPage);
	}

	public Notice getNoticeId(int id) {
		return this.noticeDao.getNoticeId(id);
	}

	public void delete(int id) {
		this.noticeDao.delete(id);
	}

	public void modifyNotice(int id, String title, String content) {
		this.noticeDao.modifyNotice(id, title, content);
	}

	public void addHit(int id) {
		this.noticeDao.addHit(id);
	}

	public int getArticlesCnt() {
		return this.noticeDao.getArticlesCnt();
	}
}
