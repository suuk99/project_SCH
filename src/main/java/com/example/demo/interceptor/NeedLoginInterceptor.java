package com.example.demo.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class NeedLoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("loginUserId") == null) {
			response.setContentType("text/html;charset=UTF-8;");
			response.getWriter().append("<script>alert('로그인이 필요한 기능입니다.'); location.replace('/sch/user/login');</script>");
			return false;
		}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}