package com.ict.mytravellist.MEM.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.mytravellist.MEM.service.MemService;
import com.ict.mytravellist.vo.UserVO;

@Controller
public class LoginController {

	@Autowired
	private MemService memService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	// 로그인 화면
	@RequestMapping("/mem_login")
	public ModelAndView memLogin() {
		ModelAndView mv = new ModelAndView("MEM/MEM_loginPage");
		return mv;
	}
	
	// 로그인 처리
	@PostMapping("/mem_login_ok")
	public ModelAndView memLoginOK(UserVO uservo, HttpSession session) {
	    try {
	        ModelAndView mv = new ModelAndView("");
	        UserVO uservo2 = memService.userLogin(uservo.getUserId()); // uservo2: 사용자 정보 담은 객체 헷갈리지 마!!

	        // 로그인 실패 카운트 세션에 저장
	        Integer loginFailCnt = (Integer) session.getAttribute("loginFailCnt");
	        if (loginFailCnt == null) { // 처음 로그인 시도
	            loginFailCnt = 0; // 초기값 0으로 설정했음
	        }

	        // 아이디가 없을 때
	        if (uservo2 == null) { 
	            System.out.println("아이디 없음");
	            loginFailCnt++; // 실패 횟수에 증가
	            session.setAttribute("loginFailCnt", loginFailCnt); // 세션에 실패 횟수 저장

	            // 실패 횟수 확인
	            if (loginFailCnt >= 5) {
	                System.out.println("로그인 5회 이상 실패");
	                mv.setViewName("MEM/MEM_loginError2");
	                mv.addObject("loginFail", true);
	                mv.addObject("redirectToMain", true);
	                session.setAttribute("loginFailCnt", 0); // 실패 횟수 초기화
	                return mv;
	            }
	            mv.setViewName("MEM/MEM_loginError2");
	            mv.addObject("loginFail", true);
	            mv.addObject("redirectToLogin", true);
	            return mv;
	        }
	        // 아이디가 있을 때, 비밀번호 확인
	        if (!passwordEncoder.matches(uservo.getUserPw(), uservo2.getUserPw())) { // 암호화X-암호화O 불일치하면
	            System.out.println("비밀번호 틀림");
	            loginFailCnt++; // 실패 횟수에 증가
	            session.setAttribute("loginFailCnt", loginFailCnt); // 세션에 실패 횟수 저장

	            // 실패 횟수 확인
	            if (loginFailCnt >= 5) {
	                System.out.println("로그인 5회 이상 실패");
	                mv.setViewName("MEM/MEM_loginError2");
	                mv.addObject("loginFail", true);
	                mv.addObject("redirectToMain", true);
	                session.setAttribute("loginFailCnt", 0); // 실패 횟수 초기화
	                return mv;
	            }
	            mv.setViewName("MEM/MEM_loginError2");
	            mv.addObject("loginFail", true);
	            mv.addObject("redirectToLogin", true);
	            return mv;
	        }
	        // 로그인 성공
	        System.out.println("로그인 성공");	
	        session.setAttribute("loginChk", "ok"); // 로그인 상태 체크 세션 설정
	        mv.setViewName("MAIN/main"); // 메인 화면으로 이동
	        session.setAttribute("userId", uservo.getUserId()); // userId 세션에 저장
	        System.out.println(uservo2.getUserId());
	        session.setAttribute("loginFailCnt", 0); // 로그인 성공 시 실패 횟수 초기화
	        
	        // 로그인 시간 저장
	        LocalDateTime now = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String formattedDate = now.format(formatter);
	        uservo2.setUserConnReg(formattedDate);
	        memService.userLoginTime(uservo2);
	        
	        return mv;
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    return new ModelAndView("MEM/MEM_loginError2");
	}

	// 로그아웃
	@GetMapping("/mem_logout")
	public ModelAndView memLogout(HttpSession session) {
		// 세션 초기화
		session.invalidate();
		System.out.println("로그아웃 성공");
		return new ModelAndView("MAIN/main");
	}

	// 아이디 찾기 화면
	@RequestMapping("/mem_findID")
	public ModelAndView mem_findID() {
		ModelAndView mv = new ModelAndView("MEM/MEM_findID");
		return mv;
	}

	// 비밀번호 찾기 화면
	@RequestMapping("/mem_findPW")
	public ModelAndView mem_findPW() {
		ModelAndView mv = new ModelAndView("MEM/MEM_findPW");
		return mv;
	}
	
	// 아이디 찾기 관련
	@RequestMapping("/mem_findID_OK")
	public ModelAndView mem_findID_detail(@ModelAttribute UserVO uservo, HttpSession session) {
	    ModelAndView mv = new ModelAndView("");
	    try {
	        Integer infoFailCnt = (Integer) session.getAttribute("infoFailCnt");
	        if (infoFailCnt == null) {
	            infoFailCnt = 0;
	        }

	        UserVO uservo2 = memService.userIdFind(uservo);

	        if (uservo2 != null) {
	            // 일치한 정보가 있다면
	            mv.setViewName("MEM/MEM_findID_OK");
	            mv.addObject("userId", uservo2.getUserId());

	            // 실패 횟수 초기화
	            session.setAttribute("infoFailCnt", 0);
	        } else {
	            // 일치하는 정보가 없을 때 실패 횟수 증가
	            infoFailCnt++;
	            session.setAttribute("infoFailCnt", infoFailCnt);

	            if (infoFailCnt >= 5) {
	                // 5회 이상 틀렸을 경우 alert와 리다이렉트 스크립트를 포함하여 JSP로 이동
	                mv.setViewName("MEM/MEM_findID");
	                mv.addObject("script", "<script>alert('5회 이상 입력 정보가 맞지 않습니다. 메인 페이지로 이동합니다.'); location.href='/';</script>");
	                session.setAttribute("infoFailCnt", 0); // 실패 횟수 초기화
	            } else {
	                // 5회 미만일 경우 아이디 찾기 페이지로 이동
	                mv.setViewName("MEM/MEM_findID");
	                mv.addObject("message", "일치하는 아이디가 없습니다.");
	            }
	        }
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    return mv;
	}
	
	// 비밀번호 찾기 관련
	@PostMapping("/mem_findPW_OK")
	public ModelAndView memFindPwOK(@ModelAttribute UserVO uservo, HttpSession session) {
		ModelAndView mv = new ModelAndView("");
		try {
			Integer infoFailCnt = (Integer) session.getAttribute("infoFailCnt");
	        if (infoFailCnt == null) {
	            infoFailCnt = 0;
	        }

	        UserVO uservo2 = memService.userPwFind(uservo);
	        
	        if (uservo2 != null) {
	        	// 일치한 정보가 있다면
	        	mv.setViewName("MEM/MEM_findPW_Change");
	        	session.setAttribute("userId", uservo.getUserId()); // 세션에 userId 저장
	        	
	        	// 실패 횟수 초기화
	        	session.setAttribute("infoFailCnt", 0);
			} else {
				// 일치한 정보가 없을 때 실패 횟수 증가
				infoFailCnt++;
				session.setAttribute("infoFailCnt", infoFailCnt);
				
				if (infoFailCnt >= 5) {
					// 5회 이상 틀렸을 경우 alert와 리다이렉트 스크립트를 포함하여 JSP로 이동
					mv.setViewName("MEM/MEM_findPW");
					mv.addObject("script", "<script>alert('5회 이상 입력 정보가 맞지 않습니다. 메인 페이지로 이동합니다.'); location.href='/';</script>");
					session.setAttribute("infoFailCnt", 0); // 실패 횟수 초기화
					session.removeAttribute("userId");
				} else {
					// 5회 미만일 경우 비밀번호 찾기 페이지로 이동
					mv.setViewName("MEM/MEM_findPW");
					mv.addObject("message", "일치하는 정보가 없습니다.");
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return mv;
	}

	// 비밀번호 변경 관련
	@PostMapping("/mem_findPW_Change")
	public ModelAndView memFindPwChange(@RequestParam("userPw") String userPw, HttpSession session, 
			RedirectAttributes redirectAttributes) {
		ModelAndView mv = new ModelAndView("");
		
		try {
			// 세션에서 userId 가져오기
			String userId = (String) session.getAttribute("userId");
			if (userId == null) { // 세션에 userId가 없는 경우
				mv.setViewName("MEM/MEM_findPW");
				mv.addObject("message", "세션이 만료되었습니다. 다시 시도해 주세요.");
				return mv;
			}
			
			// 비밀번호 암호화
			String encodePw = passwordEncoder.encode(userPw);
			
			UserVO uservo = new UserVO();
			uservo.setUserId(userId);
			uservo.setUserPw(encodePw);
			
			int result = memService.userPwChange(uservo);
			if (result > 0) {
				mv.setViewName("redirect:/mem_login");
				redirectAttributes.addFlashAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
				System.out.println("비밀번호 변경 성공");
				session.removeAttribute("userId");
			} else {
				mv.setViewName("MEM/MEM_ChagnePW_Error");
				mv.addObject("message", "다시 시도해 주세요.");
			}
			
		} catch (Exception e) {
			System.out.println(e);
			mv.setViewName("MEM/MEM_ChagnePW_Error");
			mv.addObject("message", "다시 시도해 주세요.");
		}
		return mv;
	}
}

/*
// 로그인 처리
@PostMapping("/mem_login_ok")
public ModelAndView memLoginOK(UserVO uservo, HttpSession session) {
    try {
        ModelAndView mv = new ModelAndView("");
        UserVO uservo2 = memService.userLogin(uservo.getUserId());
        
        if (uservo2 == null) {
            // 아이디가 없어서 로그인 실패
            System.out.println("아이디가 없음");
            return new ModelAndView("MEM/MEM_loginError2");
        } else {
            // 비밀번호 검사
            if (passwordEncoder.matches(uservo.getUserPw(), uservo2.getUserPw())) {
                // 성공
                System.out.println("로그인 성공");
                session.setAttribute("loginchk", "ok");
                mv.setViewName("redirect:/");
                session.setAttribute("userId", uservo2.getUserId());
                System.out.println(uservo2.getUserId());
                return mv;
            } else {
                // 비밀번호가 안 맞아서 로그인 실패
                System.out.println("비밀번호 틀림");
                return new ModelAndView("MEM/MEM_loginError2");
            }
        }
    } catch (Exception e) {
        System.out.println(e);
    }
    return new ModelAndView("MEM/MEM_loginError2");
}
 */

//아이디 찾기 관련
	/*
	@RequestMapping("/mem_findID_OK")
	public ModelAndView mem_findID_detail(@ModelAttribute UserVO uservo, HttpSession session) {
		ModelAndView mv = new ModelAndView("MEM/MEM_findID_OK");

		UserVO uservo2 = memService.userIdFind(uservo);

		if (uservo2 != null) {
			// 일치하는 정보가 있다면
			mv.setViewName("MEM/MEM_findID_OK");
			mv.addObject("userId", uservo2.getUserId());
		} else {
			// 일치하는 정보가 없다면
			mv.setViewName("MEM/MEM_findID");
			mv.addObject("message", "일치하는 아이디가 없습니다.");
		}
		return mv;
	}
	*/