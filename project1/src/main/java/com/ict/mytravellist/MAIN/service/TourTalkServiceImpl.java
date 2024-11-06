package com.ict.mytravellist.MAIN.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mytravellist.MAIN.dao.TourTalkDAO;
import com.ict.mytravellist.vo.TourTalkVO;

@Service
public class TourTalkServiceImpl implements TourTalkService{

	@Autowired
	private TourTalkDAO tourTalkDAO;

	@Override
	public int getTourTalkInsert(TourTalkVO tourtvo) {
		return tourTalkDAO.getTourTalkInsert(tourtvo);
	}

	@Override
	public List<TourTalkVO> getTourTalkList(String travelIdx) {
		return tourTalkDAO.getTourTalkList(travelIdx);
	}

	@Override
	public int getHitUpdate(String userIdx) {
		return 0;
	} 
	
}
