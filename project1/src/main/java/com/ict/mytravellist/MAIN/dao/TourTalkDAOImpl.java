package com.ict.mytravellist.MAIN.dao;

import java.util.List; 


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.mytravellist.vo.ReportVO;
import com.ict.mytravellist.vo.TourTalkVO;

@Repository
public class TourTalkDAOImpl implements TourTalkDAO{
     
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<TourTalkVO> getTourTalkList(String travelIdx) {
		return sqlSessionTemplate.selectList("tourTalk.list", travelIdx);
	}

	@Override
	public int getTourTalkInsert(TourTalkVO tourtvo) {
		return sqlSessionTemplate.insert("tourTalk.insert", tourtvo);
	}

	@Override
	public int getTourTalkUpdate(String userIdx) {
		return 0;
	}

	@Override
	public int getTourTalkDelete(String userIdx) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int insertTourTalk(TourTalkVO tourtvo) {
		return sqlSessionTemplate.insert("tourTalk.insert", tourtvo);		
	}

	@Override
	public int saveReport(ReportVO repvo) {
        return sqlSessionTemplate.insert("tourTalk.insertReport", repvo);
	}

	@Override
	public int increaseReportCount(int tourTalkIdx) {
        return sqlSessionTemplate.update("tourTalk.increaseReportCount", tourTalkIdx);

	}

	@Override
	public int getReportCount(int tourTalkIdx) {
        return sqlSessionTemplate.selectOne("tourTalk.getReportCount", tourTalkIdx);

	}

	@Override
	public int deactivatePost(int tourTalkIdx) {
        return sqlSessionTemplate.update("tourTalk.deactivatePost", tourTalkIdx);
	}
}