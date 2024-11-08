package com.ict.mytravellist.MEM.service;

import java.util.List;

import com.ict.mytravellist.vo.UserVO;

public interface MemService {
	// 로그인
	public UserVO userLogin(String userId);
	
	// 회원가입 컨트롤러에 필요한 전화번호 중복 체크
	public UserVO userPhoneCheck(String userPhone);
	
	// 전화번호 중복O-사용자 정보 업데이트
	public int userUpdate(UserVO uservo);
	
	// 전화번호 중복X-회원가입
	public int userJoin(UserVO uservo);
	
	// 아이디 중복 체크
	public String userIdChk(String userId);
	
	// 이메일 중복 체크
	public String userMailChk(String userMail);
	
	// 전화번호 중복 체크(회원가입 화면에서)
	public String userPhoneChk(String userPhone);
	
	public List<UserVO> userPhoneChk2(String userPhone);
	
	// 아이디 찾기
	public UserVO userIdFind(UserVO uservo);
	
	// 비밀번호 찾기
	public UserVO userPwFind(UserVO uservo);
	
	// 비밀번호 변경
	public int userPwChange(UserVO uservo);
	
	// 로그인 시간
	public int userLoginTime(UserVO uservo);
	
    public UserVO selectNaverUserOne(String n_userId) throws Exception;
    
    public int userJoin2(UserVO uservo) throws Exception;
    
    public UserVO selectKakaoUserOne(String k_userId) throws Exception;
}