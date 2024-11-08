package com.ict.mytravellist.MEM.service;

import java.util.List;

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
	public UserVO userPhoneCheck(String userPhone) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int userUpdate(UserVO uservo) {
		return memDAO.userUpdate(uservo);
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
	public String userPhoneChk(String userPhone) {
		String email = memDAO.userPhoneChk(userPhone);
		System.out.println("Service에서 가져온 이메일: " + email);
		return email;
		// return memDAO.userPhoneChk(userPhone);
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

	@Override
	public UserVO selectNaverUserOne(String n_userId) throws Exception {
		return memDAO.selectNaverUserOne(n_userId);
	}

	@Override
	public int userJoin2(UserVO uservo) throws Exception {
		return memDAO.userJoin2(uservo);
	}

	@Override
	public UserVO selectKakaoUserOne(String k_userId) throws Exception {
		return memDAO.selectKakaoUserOne(k_userId);
	}

	@Override
	public List<UserVO> userPhoneChk2(String userPhone) {
		return memDAO.userPhoneChk2(userPhone);
	}
}