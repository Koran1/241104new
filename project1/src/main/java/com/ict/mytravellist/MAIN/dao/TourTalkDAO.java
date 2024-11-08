package com.ict.mytravellist.MAIN.dao;


import java.util.List;

import com.ict.mytravellist.vo.ReportVO;
import com.ict.mytravellist.vo.TourTalkVO;


public interface TourTalkDAO{
	
	// 리스트
	public List<TourTalkVO> getTourTalkList(String travelIdx);
	
    // 삽입(쓰기)
    public int getTourTalkInsert(TourTalkVO tourtvo);
	
    // report 정보 입력
    public int getReportInsert(ReportVO reportVO);
    	
    // TourTalk 업데이트
    public int getReportCountUpdate(String tourTalkIdx);
    
    // pjcustomer 업데이트
    public int getCustomerCountUpdate(String writer);
    
    // 동일 신고 금지
    public Integer checkDuplicateReport(String reporter, String tourTalkIdx);
}