package com.ict.mytravellist.MAIN.dao;

import java.util.List;
import java.util.Map;

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
	public int getReportInsert(ReportVO reportVO) {
		return sqlSessionTemplate.insert("tourTalk.reportInsert", reportVO);
	}

	@Override
	public int getReportCountUpdate(String tourTalkIdx) {
		return sqlSessionTemplate.update("tourTalk.tourtalkCountUpdate", tourTalkIdx);
	}

	@Override
	public int getCustomerCountUpdate(String writer) {
		return sqlSessionTemplate.update("tourTalk.customerCountUpdate", writer);
	}

	@Override
	public Integer checkDuplicateReport(String reporter, String tourTalkIdx) {
	    return sqlSessionTemplate.selectOne("tourTalk.userCheck", Map.of("reporter", reporter, "tourTalkIdx", tourTalkIdx));
	}


}