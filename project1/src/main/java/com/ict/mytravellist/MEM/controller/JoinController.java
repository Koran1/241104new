package com.ict.mytravellist.MEM.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	@RequestMapping("/mem_joinPage")
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
	
	/*
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
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("message", "회원가입에 실패했습니다. 다시 시도해 주세요.");
			mv.setViewName("redirect:/mem_joinPage");
			mv.addObject("result", 0);
		}
		return mv;
	}
	*/
	
	// 회원가입 처리
	@PostMapping("/mem_joinPage_OK")
	public ModelAndView mem_joinPage_OK(UserVO uservo, RedirectAttributes redirectAttributes, String userChk) {
		ModelAndView mv = new ModelAndView("");
		try {
			if (userChk.equals("0")) {
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
			} else {
				// 비밀번호 암호화
				String userPw = passwordEncoder.encode(uservo.getUserPw());
				uservo.setUserPw(userPw);
				int result2 = memService.userUpdate(uservo);
				if (result2 > 0) {
					redirectAttributes.addFlashAttribute("message", "회원가입 정보가 성공적으로 완료됐습니다.");
					mv.setViewName("redirect:/mem_login");
					mv.addObject("result", 1); // 회원가입 성공
				} else {
					redirectAttributes.addFlashAttribute("message", "회원가입에 실패했습니다. 다시 시도해 주세요.");
					mv.setViewName("redirect:/mem_joinPage");
					mv.addObject("result", 0);
				}
			}
		} catch (Exception e) {
			System.out.println(e);
			redirectAttributes.addFlashAttribute("message", "회원가입 중 오류가 발생했습니다. 다시 시도해 주세요.");
			mv.setViewName("redirect:/mem_joinPage");
		}
		return mv;
	}

	// 아이디 중복 체크
	@PostMapping(value="/mem_id_chk", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String memIdChk(HttpServletRequest request) {
		String userId = request.getParameter("userId");
		String result = memService.userIdChk(userId);
		return result;
	}
	
	// 이메일 중복 체크
	@PostMapping(value="/mem_email_chk", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String memEmailChk(HttpServletRequest request) {
		String userEmail = request.getParameter("userMail");
		String result = memService.userMailChk(userEmail);
		return result;
	}
	
	// 전화번호 중복 체크
	/*
	@RequestMapping(value="/mem_phone_chk", produces = "text/plain; chartset=utf-8")
	@ResponseBody
	public String memPhoneChk(HttpServletRequest request) {
		String userPhone = request.getParameter("userPhone");
		String result = memService.userPhoneChk(userPhone);
		return result;
	}
	*/
	
	@PostMapping(value="/mem_phone_chk", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memPhoneChk(HttpServletRequest request) {
	    String userPhone = request.getParameter("userPhone");
	    Map<String, Object> result = new HashMap<>();
	    
	    String email = memService.userPhoneChk(userPhone); // 이메일 가져오기
	    System.out.println("Controller에서 가져온 이메일: " + email);
	    if (email != null) {
	        result.put("status", "duplicate");
	        result.put("email", email); // 중복된 경우 이메일 정보 포함
	    } else {
	        result.put("status", "available");
	    }
	    System.out.println("Controller에서 반환할 JSON: " + result);
	    return result;
	}
	@PostMapping(value="/mem_phone_chk2", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memPhoneChk2(HttpServletRequest request) {
		String userPhone = request.getParameter("userPhone");
		Map<String, Object> map = new HashMap<>();
		
		List<UserVO> result2 = memService.userPhoneChk2(userPhone); // 이메일 가져오기
		if (result2 != null) {
			map.put("status", "duplicate");
			map.put("result2", result2); // 중복된 경우 이메일 정보 포함
			
		} else {
			map.put("status", "available");
		}
		System.out.println("Controller에서 반환할 JSON: " + map);
		return map;
	}
}