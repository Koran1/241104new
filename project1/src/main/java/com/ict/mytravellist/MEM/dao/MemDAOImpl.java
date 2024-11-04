package com.ict.mytravellist.MEM.dao;

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
}