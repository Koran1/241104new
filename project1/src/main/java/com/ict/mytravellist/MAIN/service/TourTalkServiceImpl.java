package com.ict.mytravellist.MAIN.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mytravellist.MAIN.dao.TourTalkDAO;
import com.ict.mytravellist.vo.ReportVO;
import com.ict.mytravellist.vo.TourTalkVO;

@Service
public class TourTalkServiceImpl implements TourTalkService{

	@Autowired
	private TourTalkDAO tourTalkDAO;
	
	@Override
	public List<TourTalkVO> getTourTalkList(String travelIdx) {
		return tourTalkDAO.getTourTalkList(travelIdx);
	}

	@Override
	public int getTourTalkInsert(TourTalkVO tourtvo) {
		return tourTalkDAO.getTourTalkInsert(tourtvo);
	}

	@Override
	public int getReportInsert(ReportVO reportVO) {
		return tourTalkDAO.getReportInsert(reportVO);
	}

	@Override
	public int getReportCountUpdate(String tourTalkIdx) {
		return tourTalkDAO.getReportCountUpdate(tourTalkIdx);
	}

	@Override
	public int getCustomerCountUpdate(String writer) {
		return tourTalkDAO.getCustomerCountUpdate(writer);
	}



}
