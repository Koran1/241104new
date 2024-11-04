package com.ict.mytravellist.MAIN.service;


import java.util.List;

import com.ict.mytravellist.vo.TourTalkVO;

public interface TourTalkService{
    // 삽입(쓰기)
    public int getTourTalkInsert(TourTalkVO tourtvo);
		
	// 리스트
    public List<TourTalkVO> getTourTalkList();
    
    // 조회수 업데이트
    public int getHitUpdate(String userIdx);
	
    
}
