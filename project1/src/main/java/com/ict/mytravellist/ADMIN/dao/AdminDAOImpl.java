package com.ict.mytravellist.ADMIN.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.mytravellist.vo.NoticeVO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<NoticeVO> getNoticeList() {
		return sqlSessionTemplate.selectList("admin.notice_list");
	}

	@Override
	public int getNoticeInsert(NoticeVO noticevo) {
		return sqlSessionTemplate.insert("admin.notice_insert", noticevo);
	}
}