package com.example.demo.controller;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
public class ScheduleNotificationController {
	
	private final SimpMessagingTemplate template;
	
	public ScheduleNotificationController(SimpMessagingTemplate template) {
		this.template = template;
	}
	
	// 특정 사용자에게 보냄
	public void sendAlertToUser(String userId, String message) {
		template.convertAndSendToUser(userId, "/queue/alert", message);
	}
	
	// 모든 사용자에게 보냄
	public void sendAlertToAll(String message) {
		template.convertAndSend("/topic/scheduleAlert", message);
	}
	
	public void sendAlertToAdmin(String message) {
		template.convertAndSendToUser("관리자", "/queue/alert", message);
	}
}
