package com.ict.mytravellist.MEM.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.mytravellist.MEM.service.EmailService;
import com.ict.mytravellist.MEM.service.MemService;
import com.ict.mytravellist.vo.UserVO;

@Controller
public class JoinController {
	
	@Autowired
	private MemService memService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private EmailService emailService;
	
	// 회원가입 페이지
	@PostMapping("/mem_joinPage")
	public ModelAndView mem_joinPage() {
		ModelAndView mv = new ModelAndView("MEM/MEM_joinPage");
		
		return mv;
	}
	
	// 회원가입 이용 약관 화면
	@RequestMapping("/mem_joinAgree")
	public ModelAndView mem_joinAgree() {
		ModelAndView mv = new ModelAndView("MEM/MEM_joinAgree");
		return mv;
	}
	
	// 회원가입 처리
	@PostMapping("/mem_joinPage_OK")
	public ModelAndView mem_joinPage_OK(UserVO uservo, RedirectAttributes redirectAttributes) {
		ModelAndView mv = new ModelAndView("");
		try {
			
			// 비밀번호 암호화
			String userPw = passwordEncoder.encode(uservo.getUserPw());
			uservo.setUserPw(userPw);
			
			int result = memService.userJoin(uservo);
			if (result > 0) {
				redirectAttributes.addFlashAttribute("message", "회원가입이 성공적으로 완료됐습니다.");
				mv.setViewName("redirect:/mem_login");
				mv.addObject("result", 1); // 회원가입 성공
			} else {
				redirectAttributes.addFlashAttribute("message", "회원가입에 실패했습니다. 다시 시도해 주세요.");
				mv.setViewName("redirect:/mem_joinPage");
				mv.addObject("result", 0);
			}
		} catch (Exception e) {
			System.out.println(e);
			redirectAttributes.addFlashAttribute("message", "회원가입에 실패했습니다. 다시 시도해 주세요.");
			mv.setViewName("redirect:/mem_joinPage");
			mv.addObject("result", 0);
		}
		return mv;
	}
	
	// 아이디 중복 체크
	@RequestMapping(value="/mem_id_chk", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String memIdChk(HttpServletRequest request) {
		String userId = request.getParameter("userId");
		String result = memService.userIdChk(userId);
		return result;
	}
	
	// 이메일 중복 체크
	@RequestMapping(value="/mem_email_chk", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String memEmailChk(HttpServletRequest request) {
		String userEmail = request.getParameter("userMail");
		String result = memService.userMailChk(userEmail);
		return result;
	}
}