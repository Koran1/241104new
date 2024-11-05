package com.ict.mytravellist.MAIN.dao;

import java.util.List; 


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.mytravellist.vo.TourTalkVO;

@Repository
public class TourTalkDAOImpl implements TourTalkDAO{
     
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public int getTourTalkInsert(TourTalkVO tourtvo) {
		return sqlSessionTemplate.insert("tourTalk.insert", tourtvo);
	}

	@Override
	public List<TourTalkVO> getTourTalkList(String travelIdx) {
        System.out.println("TourTalkDAOImpl 통과 ");
		return sqlSessionTemplate.selectList("tourTalk.list", travelIdx);
	}

	@Override
	public int getHitUpdate(String userIdx) {
		return 0;
	}
	

}