package com.ict.mytravellist.MEM.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mytravellist.MEM.dao.MemDAO;
import com.ict.mytravellist.vo.UserVO;

@Service
public class MemServiceImpl implements MemService {
	@Autowired
	private MemDAO memDAO;
	
	@Override
	public UserVO userLogin(String userId) {
		return memDAO.userLogin(userId);
	}

	@Override
	public int userJoin(UserVO uservo) {
		return memDAO.userJoin(uservo);
	}

	@Override
	public String userIdChk(String userId) {
		return memDAO.userIdChk(userId);
	}

	@Override
	public String userMailChk(String userMail) {
		return memDAO.userMailChk(userMail);
	}

	@Override
	public UserVO userIdFind(UserVO uservo) {
		return memDAO.userIdFind(uservo);
	}

	@Override
	public UserVO userPwFind(UserVO uservo) {
		return memDAO.userPwFind(uservo);
	}

	@Override
	public int userPwChange(UserVO uservo) {
		return memDAO.userPwChange(uservo);
	}

	@Override
	public int userLoginTime(UserVO uservo) {
		return memDAO.userLoginTime(uservo);
	}
}