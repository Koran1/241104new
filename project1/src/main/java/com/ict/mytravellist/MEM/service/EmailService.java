package com.ict.mytravellist.MEM.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
	@Autowired
	private JavaMailSender javaMailSender; 
	
	// Controller 호출할 메서드 생성
	public void sendEmail(String randomNumber, String toMail) {
		try {
			// DB 안 가면 Service에서 MailHandler 클래스 만들어줘야 함
			EmailHandler sendMail = new EmailHandler(javaMailSender);

			// EmailHandler 메서드를 호출해서 쓴다.
			// 메일 제목
			sendMail.setSubject("[MyTravelList] 이메일 인증 메일입니다.");
			
			// 내용
			sendMail.setText(
				    "<div style='width: 100%; max-width: 600px; color: #333;'>"
				    + "    <table style='width: 100%; border-collapse: collapse;'>"
				    + "        <thead>"
				    + "            <tr>"
				    + "                <th style='background-color: #02B08A; color: white; padding: 15px; text-align: center;'>"
				    + "                    <h2>MyTravelList 이메일 인증</h2>"
				    + "                </th>"
				    + "            </tr>"
				    + "        </thead>"
				    + "        <tbody>"
				    + "            <tr>"
				    + "                <td style='padding: 20px; text-align: center;'>"
				    + "                    <p style='font-size: 16px;'>MyTravelList를 이용해 주셔서 감사합니다.</p>"
				    + "                    <p style='font-size: 16px;'>아래 인증 번호를 입력하여 인증을 완료해 주세요.</p>"
				    + "                    <p style='font-size: 18px; font-weight: bold; color: #02B08A;'>"
				    + "                        인증 번호: <span style='font-size: 20px;'>" + randomNumber + "</span>"
				    + "                    </p>"
				    + "                </td>"
				    + "            </tr>"
				    + "            <tr>"
				    + "                <td style='padding: 20px; text-align: center;'>"
				    + "                    <p style='font-size: 14px; color: #777;'>"
				    + "                        이 메일은 MyTravelList 서비스 이용 중 발송된 메일입니다.<br>"
				    + "                        인증 번호를 요청하지 않으셨다면 이 메일을 무시하셔도 됩니다."
				    + "                    </p>"
				    + "                </td>"
				    + "            </tr>"
				    + "        </tbody>"
				    + "    </table>"
				    + "</div>"
				);
			
			
			// 보내는 사람의 이메일과 제목
			sendMail.setFrom("mytravellist@mtl.com", "MyTravelList 관리자");
			
			// 받는 이메일
			sendMail.setTo(toMail);
			sendMail.send();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}