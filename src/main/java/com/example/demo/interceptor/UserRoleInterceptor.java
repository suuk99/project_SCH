package com.example.demo.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class UserRoleInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		if (!session.getAttribute("loginUserRole").equals("ADMIN")) {
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().append("<script>alert('관리자만 이용 가능한 기능입니다.'); history.back()</script>");
			return false;
		}
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
