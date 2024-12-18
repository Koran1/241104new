package com.ict.mytravellist.mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ict.mytravellist.mypage.service.ProjectService;
import com.ict.mytravellist.vo.UserVO;

@Controller
public class ProjectController {

	@Autowired
	private ProjectService projectService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@RequestMapping("/go_my_page")
	public ModelAndView goMyPage(@ModelAttribute("isOk") String isOk) {
		ModelAndView mav = new ModelAndView("project_view/MEM_myPage");
		return mav;
	}

	@GetMapping("/go_identify")
	public ModelAndView goIdentify(@ModelAttribute("cmd") String cmd, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			String identityChk = (String) session.getAttribute("identityChk");
			if (identityChk == null) {
				String userId = (String) session.getAttribute("userId");
				mav.addObject("userId", userId);
				mav.setViewName("project_view/MEM_myPage_identityCheck");
			} else {
				mav.setViewName("redirect:/" + cmd);
			}

		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("project_view/error");
		}
		return mav;
	}

	@PostMapping("go_pw_chk")
	public ModelAndView goPwChk(UserVO uvo, @RequestParam("cmd") String cmd, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			String pw = uvo.getUserPw();
			String userId = uvo.getUserId();

			UserVO dbUvo = projectService.getUserDetail(userId);

			String dbPw = dbUvo.getUserPw();
			if (passwordEncoder.matches(pw, dbPw)) {
				mav.setViewName("redirect:/" + cmd);
				session.setAttribute("identityChk", "ok");
			} else {
				mav.setViewName("project_view/MEM_myPage_identityCheck");
				mav.addObject("pwChk", false);
				mav.addObject("cmd", cmd);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("project_view/error");
		}
		return mav;
	}

	@GetMapping("/go_my_comment")
	public ModelAndView goMyComment() {
		ModelAndView mav = new ModelAndView("project_view/MEM_myPage_myComment");

		return mav;
	}

	@GetMapping("/go_update")
	public ModelAndView goUpdate(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String userId = (String) request.getSession().getAttribute("userId");
		// 이름, 아이디, 전화번호, 이메일, 주소, 관심지역 123
		try {
			UserVO detail = projectService.getUserDetail(userId);
			System.out.println("phone: " + detail.getUserPhone());
			mav.addObject("detail", detail);
			mav.setViewName("project_view/MEM_myPage_update");
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("project_view/error");
		}
		return mav;
	}

	@GetMapping("/go_pw_change")
	public ModelAndView goPwChange() {
		ModelAndView mav = new ModelAndView("project_view/MEM_myPage_changePw");

		return mav;
	}

	@GetMapping("/go_user_out")
	public ModelAndView goUserOut() {
		ModelAndView mav = new ModelAndView("project_view/MEM_myPage_userOut");

		return mav;
	}

	@RequestMapping("/go_update_ok")
	public ModelAndView goUpdateOK(UserVO uvo) {
		ModelAndView mav = new ModelAndView();
		try {
			String result = projectService.getUserUpdate(uvo);
			if (result != "0") {
				mav.setViewName("redirect:/go_my_page?isOk=yes");
			} else {
				mav.setViewName("project_view/error");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("project_view/error");
		}
		return mav;
	}

	@PostMapping("/go_pw_change_ok")
	public ModelAndView goPwChangeOK(String userPw, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			String userId = (String) session.getAttribute("userId");
			String encodePw = passwordEncoder.encode(userPw);

			UserVO uvo = new UserVO();
			uvo.setUserPw(encodePw);
			uvo.setUserId(userId);

			int result = projectService.getChangePw(uvo);
			if (result > 0) {
				mav.setViewName("redirect:/go_my_page?isOk=yes");
			} else {
				mav.setViewName("project_view/error");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("project_view/error");
		}
		return mav;
	}

	@PostMapping("/go_user_out_ok")
	public ModelAndView goUserOutOK(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			String userId = (String) session.getAttribute("userId");
			int result = projectService.getUserOut(userId);
			if (result > 0) {
				mav.setViewName("redirect:/main_go");
				session.invalidate();
			} else {
				mav.setViewName("project_view/error");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("project_view/error");
		}
		return mav;
	}

	@PostMapping("/judge_user_email")
	public ModelAndView judgeUserEmail(UserVO uvo) {
		ModelAndView mav = new ModelAndView();
		try {
			UserVO result = projectService.judgeUserEmail(uvo.getUserMail());
			if (result == null) {
				mav.addObject("isUsable", true);
				mav.addObject("detail", uvo);
			}else {
				mav.addObject("isUsable", false);
				mav.addObject("detail", uvo);
			}
			mav.setViewName("project_view/MEM_myPage_update");
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("project_view/error");
		}
		return mav;
	}

}
