package com.ict.mytravellist.MEM.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.mytravellist.vo.UserVO;

@Repository
public class MemDAOImpl implements MemDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public UserVO userLogin(String userId) {
		return sqlSessionTemplate.selectOne("mems.login", userId);
	}

	@Override
	public UserVO userPhoneCheck(String userPhone) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int userUpdate(UserVO uservo) {
		return sqlSessionTemplate.update("mems.update", uservo);
	}
	
	@Override
	public int userJoin(UserVO uservo) {
		return sqlSessionTemplate.insert("mems.insert", uservo);
	}
	

	@Override
	public String userIdChk(String userId) {
		int result = sqlSessionTemplate.selectOne("mems.idchk", userId);
		return String.valueOf(result);
	}

	@Override
	public String userMailChk(String userMail) {
		int result = sqlSessionTemplate.selectOne("mems.emailchk", userMail);
		return String.valueOf(result);
	}
	
	/*
	@Override
	public String userPhoneChk(String userPhone) {
		int result = sqlSessionTemplate.selectOne("mems.phonechk", userPhone);
		return String.valueOf(result);
	}
	*/
	
	@Override
	public String userPhoneChk(String userPhone) {
		// int result = sqlSessionTemplate.selectOne("mems.phonechk", userPhone);
		String email = sqlSessionTemplate.selectOne("mems.phonechk", userPhone);
		System.out.println("DAO에서 가져온 이메일: " + email);
		return email;
		//return sqlSessionTemplate.selectOne("mems.phonechk", userPhone);
	}

	@Override
	public UserVO userIdFind(UserVO uservo) {
		return sqlSessionTemplate.selectOne("mems.idfind", uservo);
	}

	@Override
	public UserVO userPwFind(UserVO uservo) {
		return sqlSessionTemplate.selectOne("mems.pwfind", uservo);
	}

	@Override
	public int userPwChange(UserVO uservo) {
		return sqlSessionTemplate.update("mems.pwchange", uservo);
	}

	@Override
	public int userLoginTime(UserVO uservo) {
		return sqlSessionTemplate.update("mems.logintime", uservo);
	}

    @Override
    public UserVO selectNaverUserOne(String n_userId) throws Exception {
        return sqlSessionTemplate.selectOne("mems.selectNaverUserOne", n_userId);
    }
    @Override
    public int userJoin2(UserVO uservo) throws Exception {
        return sqlSessionTemplate.insert("mems.userJoin2", uservo);
    }
    @Override
    public UserVO selectKakaoUserOne(String k_userId) throws Exception {
        return sqlSessionTemplate.selectOne("mems.selectKakaoUserOne", k_userId);
    }

	@Override
	public List<UserVO> userPhoneChk2(String userPhone) {
		return sqlSessionTemplate.selectList("mems.phonechk2", userPhone);
	}

	@Override
	public int userNaverUpdate(UserVO uservo) {
		return sqlSessionTemplate.update("mems.naverupdate", uservo);
	}

	@Override
	public int userNaverJoin(UserVO uservo) {
		return sqlSessionTemplate.insert("mems.naverinsert", uservo);
	}

	@Override
	public int userKakaoUpdate(UserVO uservo) {
		return sqlSessionTemplate.update("mems.kakaoupdate", uservo);
	}

	@Override
	public int userKakaoJoin(UserVO uservo) {
		return sqlSessionTemplate.insert("mems.kakaoinsert", uservo);
	}
}