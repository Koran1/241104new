package com.ict.mytravellist.ADMIN.service;

import java.util.List;

import com.ict.mytravellist.ADMIN.vo.AdminVO;
import com.ict.mytravellist.vo.FAQVO;
import com.ict.mytravellist.vo.NoticeVO;
import com.ict.mytravellist.vo.QNAVO;
import com.ict.mytravellist.vo.TourTalkVO;
import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.UserVO;

public interface AdminService {
	public List<UserVO> getUserList(int offset, int limit) throws Exception;
	public int countTotalData() throws Exception;
	public TourTalkVO getTTRecentOne(String userId) throws Exception;
	public QNAVO getQNARecentOne(String userId) throws Exception;
	public int getCountTT(String userId) throws Exception;
	public int getCountQNA(String userId) throws Exception;
	public int getManageUser(UserVO uvo ) throws Exception;
	public List<UserVO> getFilteredList(String f_keyword, String filter_lev, int offset, int limit) throws Exception;
	public int countFilteredData(String f_keyword,  String filter_lev) throws Exception;
	
	// 공지사항 초기화면
	public List<NoticeVO> getNoticeList(int offset, int limit) throws Exception;
	public int getNoticeInsert(NoticeVO noticevo) throws Exception;
	public int getNoticeUpdate(NoticeVO noticeVO) throws Exception;
	public int getNoticeTotalCount() throws Exception;
	
	public List<FAQVO> getFAQList(int offset, int limit) throws Exception;
	public int getFAQInsert(FAQVO faqvo) throws Exception;
	public int getFAQUpdate(FAQVO faqvo) throws Exception;
	public int getFAQTotalCount() throws Exception;
	
	public List<QNAVO> getQNAList(int offset, int limit) throws Exception;
	public QNAVO getQNAOneList(String qnaIdx) throws Exception;
	public int getQNAAnswered(QNAVO qnavo) throws Exception;
	public int getQNATotalCount() throws Exception;
	
	public List<TravelDBVO> getMainList(int offset, int limit) throws Exception;
	public TravelDBVO getMainOneList(String travelIdx) throws Exception;
	public int getMainInsert(TravelDBVO tdvo) throws Exception;
	public int getMainUpdate(TravelDBVO tdvo) throws Exception;
	public int getMainTotalCount() throws Exception;
	
	public AdminVO getAdminInfo(String adminID) throws Exception;
}