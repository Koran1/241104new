package com.ict.mytravellist.ADMIN.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ict.mytravellist.ADMIN.service.AdminService;
import com.ict.mytravellist.vo.QNAVO;
import com.ict.mytravellist.vo.TourTalkVO;

@RestController
public class AdminRestController {

	@Autowired
	private AdminService adminService;
	
	@RequestMapping(value="/getUserActivityCount",  produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> getUserActivityCount(@RequestParam("userId") String userId){
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			TourTalkVO ttvo = adminService.getTTRecentOne(userId);
			QNAVO qvo = adminService.getQNARecentOne(userId);
			
			map.put("ttvo", ttvo);
			map.put("qvo", qvo);
			
			int countTT = adminService.getCountTT(userId);
			int countQNA = adminService.getCountQNA(userId);
			map.put("countTT", countTT);
			map.put("countQNA", countQNA);
			return map; 

		} catch (Exception e) {
			e.printStackTrace();
			return null ;
		}
		
	}

	
}
