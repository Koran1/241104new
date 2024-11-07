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
		return tourTalkDAO.insertTourTalk(tourtvo);
		
	}

	@Override
	public void saveReport(ReportVO repvo) {
		tourTalkDAO.saveReport(repvo);
		tourTalkDAO.increaseReportCount(repvo.getTourTalkIdx());

        if (tourTalkDAO.getReportCount(repvo.getTourTalkIdx()) >= 3) {
        	tourTalkDAO.deactivatePost(repvo.getTourTalkIdx());
        }		
	}

	@Override
	public int getReportCount(int tourTalkIdx) {
        return tourTalkDAO.getReportCount(tourTalkIdx);
	}

	@Override
	public void deactivatePost(int tourTalkIdx) {
		tourTalkDAO.deactivatePost(tourTalkIdx);		
	}

}
