package com.example.demo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.demo.interceptor.BeforeActionInterceptor;
import com.example.demo.interceptor.NeedLoginInterceptor;
import com.example.demo.interceptor.NeedLogoutInterceptor;
import com.example.demo.interceptor.UserRoleInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	private BeforeActionInterceptor beforeActionInterceptor;
	private NeedLoginInterceptor needLoginInterceptor;
	private NeedLogoutInterceptor needLogoutInterceptor;
	private UserRoleInterceptor userRoleInterceptor;

	public WebConfig(BeforeActionInterceptor beforeActionInterceptor, NeedLoginInterceptor needLoginInterceptor,
			NeedLogoutInterceptor needLogoutInterceptor, UserRoleInterceptor userRoleInterceptor) {
		this.beforeActionInterceptor = beforeActionInterceptor;
		this.needLoginInterceptor = needLoginInterceptor;
		this.needLogoutInterceptor = needLogoutInterceptor;
		this.userRoleInterceptor =userRoleInterceptor;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {

		registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resources/**");

		registry.addInterceptor(needLoginInterceptor).addPathPatterns("/sch/user/logout")
				.addPathPatterns("/sch/user/information").addPathPatterns("/sch/user/changePw")
				.addPathPatterns("/sch/user/selectSal").addPathPatterns("/sch/home/main")
				.addPathPatterns("/sch/schedule/apply").addPathPatterns("/sch/schedule/confirm")
				.addPathPatterns("/sch/schedule/list").addPathPatterns("/sch/schedule/swap")
				.addPathPatterns("/sch/admin/uploadTimeTable").addPathPatterns("/sch/admin/approve")
				.addPathPatterns("/sch/admin/write");

		registry.addInterceptor(needLogoutInterceptor).addPathPatterns("/sch/user/login")
				.addPathPatterns("/sch/user/join");
		
		registry.addInterceptor(userRoleInterceptor).addPathPatterns("/sch/notice/write")
				.addPathPatterns("/sch/notice/doWrite").addPathPatterns("/sch/notice/modify")
				.addPathPatterns("/sch/notice/doModify").addPathPatterns("/sch/notice/delete");
	}
}
