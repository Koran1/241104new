package com.ict.mytravellist.MEM.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ict.mytravellist.MEM.service.EmailService;

@RestController
public class EmailController {
    
    @Autowired
    private EmailService emailService; // 이메일 서비스 주입
    
    // 이메일 인증번호 전송
    @PostMapping("/send_email_code")
    public void sendMail(
			@RequestParam("userMail") String userMail,
			HttpServletRequest request
			) {
		try {
			// 임시번호 6자리 만들기
			Random random = new Random();
			// 0 ~ 1000000 미만의 정수를 무작위로 생성(6자리 숫자 중 하나를 랜덤으로 만듦)
			String ranNum = String.valueOf(random.nextInt(1000000));
			
			// 길이가 6자리가 안 되면 0으로 채우자
			if (ranNum.length() < 6) {
				int substract = 6 - ranNum.length();
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < substract; i++) {
					sb.append("0");
				}
				sb.append(ranNum);
				ranNum = sb.toString();
			}
			// 임시번호 서버에 출력
			System.out.println("임시번호: " + ranNum);
			
			// 해당 임시번호를 DB에 저장 또는 세션에 저장하기
			// 세션에 저장하기
			request.getSession().setAttribute("emailCode", ranNum);
			
			// EmailService 호출해서 사용하기
			emailService.sendEmail(ranNum, userMail);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 이메일 인증번호 확인
	@PostMapping("/judge_code_match")
	public Map<String, String> checkAuthNum(@RequestParam("authNumber") String authNumber, HttpServletRequest request) {
		Map<String, String> response = new HashMap<>();
		String emailCode = (String) request.getSession().getAttribute("emailCode");
		if (emailCode != null && emailCode.equals(authNumber)) {
			response.put("status", "success");
			response.put("message", "인증번호가 일치합니다.");
			request.getSession().removeAttribute("emailCode"); // 인증 성공 시 세션에서 인증 코드 삭제
		} else {
			response.put("status", "fail");
			response.put("message", "인증번호가 일치하지 않습니다.");
		}
		return response;
	}
}