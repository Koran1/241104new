package com.ict.mytravellist.MAIN.controller;

import java.io.File;

import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.mytravellist.MAIN.service.TourTalkService;
import com.ict.mytravellist.vo.TourTalkVO;

@Controller
public class TourTalkController {

	@Autowired
	private TourTalkService tourTalkService;
	
	@PostMapping("/bbs_write_ok")
	public ModelAndView getBbsWriteOk(TourTalkVO tourtvo, HttpServletRequest request) {
		try {
			ModelAndView mv = new ModelAndView("redirect:/travelDetail_go");

			String path = request.getSession().getServletContext().getRealPath("/resources/upload");
			MultipartFile file = tourtvo.getFile_name();
			if (file.isEmpty()) {
				tourtvo.setF_name("");
			} else {
				UUID uuid = UUID.randomUUID();
				String f_name = uuid.toString() + "_" + file.getOriginalFilename();
				tourtvo.setF_name(f_name);

				// 업로드
				file.transferTo(new File(path, f_name));
			}
			
			/*
			// 비밀번호 암호화
			String pwd = passwordEncoder.encode(tourtvo.getPwd());
			tourtvo.setPwd(pwd);
			*/
			
			int result = tourTalkService.getTourTalkInsert(tourtvo);
			if (result > 0) {
				return mv;
			}

			return null;
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
	}
}