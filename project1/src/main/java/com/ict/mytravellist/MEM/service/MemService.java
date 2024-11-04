package com.ict.mytravellist.MEM.service;

import com.ict.mytravellist.vo.UserVO;

public interface MemService {
	// 로그인
	public UserVO userLogin(String userId);
	
	// 회원가입
	public int userJoin(UserVO uservo);
	
	// 아이디 중복 체크
	public String userIdChk(String userId);
	
	// 이메일 중복 체크
	public String userMailChk(String userMail);
	
	// 아이디 찾기
	public UserVO userIdFind(UserVO uservo);
	
	// 비밀번호 찾기
	public UserVO userPwFind(UserVO uservo);
	
	// 비밀번호 변경
	public int userPwChange(UserVO uservo);
	
	// 로그인 시간
	public int userLoginTime(UserVO uservo);
}