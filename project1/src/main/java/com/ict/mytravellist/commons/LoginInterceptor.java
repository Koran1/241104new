package com.ict.mytravellist.commons;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Object obj = request.getSession(true).getAttribute("loginChk");
		if(obj == null) {
			String script = "<script> alert('로그인이 필요합니다'); location.href = '/mem_login'; </script>";
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(script);
			return false;
		}
		return true;
	}
}
