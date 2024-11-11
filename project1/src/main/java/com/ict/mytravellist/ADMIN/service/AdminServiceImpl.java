package com.ict.mytravellist.ADMIN.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mytravellist.ADMIN.dao.AdminDAO;
import com.ict.mytravellist.ADMIN.vo.AdminVO;
import com.ict.mytravellist.vo.FAQVO;
import com.ict.mytravellist.vo.NoticeVO;
import com.ict.mytravellist.vo.QNAVO;
import com.ict.mytravellist.vo.TourTalkVO;
import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.UserVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO adminDAO;

	@Override
	public List<UserVO> getUserList(int offset, int limit) throws Exception {
		return adminDAO.getUserList(offset, limit);
	}

	@Override
	public int countTotalData() throws Exception {
		return adminDAO.countTotalData();
	}

	@Override
	public TourTalkVO getTTRecentOne(String userId) throws Exception {
		return adminDAO.getTTRecentOne(userId);
	}

	@Override
	public QNAVO getQNARecentOne(String userId) throws Exception {
		return adminDAO.getQNARecentOne(userId);
	}

	@Override
	public int getCountTT(String userId) throws Exception {
		return adminDAO.getCountTT(userId);
	}

	@Override
	public int getCountQNA(String userId) throws Exception {
		return adminDAO.getCountQNA(userId) ;
	}

	@Override
	public int getManageUser(UserVO uvo) throws Exception {
		return adminDAO.getManageUser(uvo);
	}

	@Override
	public List<UserVO> getFilteredList(String f_keyword, String filter_lev, int offset, int limit) throws Exception {
		return adminDAO.getFilteredList(f_keyword, filter_lev, offset, limit);
	}

	@Override
	public int countFilteredData(String f_keyword, String filter_lev) throws Exception {
		return adminDAO.countFilteredData(f_keyword, filter_lev);
	}
	
	@Override
	public List<NoticeVO> getNoticeList(int offset, int limit) throws Exception{
		return adminDAO.getNoticeList(offset, limit);
	}

	@Override
	public int getNoticeInsert(NoticeVO noticevo) throws Exception {
		return adminDAO.getNoticeInsert(noticevo);
	}

	@Override
	public int getNoticeUpdate(NoticeVO noticeVO) throws Exception {
		return adminDAO.getNoticeUpdate(noticeVO);
	}

	@Override
	public int getNoticeTotalCount() throws Exception {
		return adminDAO.getNoticeTotalCount();
	}

	@Override
	public List<FAQVO> getFAQList(int offset, int limit) throws Exception {
		return adminDAO.getFAQList(offset, limit);
	}

	@Override
	public int getFAQInsert(FAQVO faqvo) throws Exception {
		return adminDAO.getFAQInsert(faqvo);
	}

	@Override
	public int getFAQUpdate(FAQVO faqvo) throws Exception {
		return adminDAO.getFAQUpdate(faqvo);
	}

	@Override
	public int getFAQTotalCount() throws Exception {
		return adminDAO.getFAQTotalCount();
	}

	@Override
	public int getQNAAnswered(QNAVO qnavo) throws Exception {
		return adminDAO.getQNAAnswered(qnavo);
	}

	@Override
	public List<QNAVO> getQNAList(int offset, int limit) throws Exception {
		return adminDAO.getQNAList(offset, limit);
	}

	@Override
	public int getQNATotalCount() throws Exception {
		return adminDAO.getQNATotalCount();
	}

	@Override
	public QNAVO getQNAOneList(String qnaIdx) throws Exception {
		return adminDAO.getQNAOneList(qnaIdx);
	}

	@Override
	public List<TravelDBVO> getMainList(int offset, int limit) throws Exception {
		return adminDAO.getMainList(offset, limit);
	}

	@Override
	public TravelDBVO getMainOneList(String travelIdx) throws Exception {
		return adminDAO.getMainOneList(travelIdx);
	}

	@Override
	public int getMainInsert(TravelDBVO tdvo) throws Exception {
		return adminDAO.getMainInsert(tdvo);
	}

	@Override
	public int getMainUpdate(TravelDBVO tdvo) throws Exception {
		return adminDAO.getMainUpdate(tdvo);
	}

	@Override
	public int getMainTotalCount() throws Exception {
		return adminDAO.getMainTotalCount();
	}

	@Override
	public AdminVO getAdminInfo(String adminID) throws Exception {
		return adminDAO.getAdminInfo(adminID);
	}

	@Override
	public int getUserConnReg() throws Exception {
		return adminDAO.getUserConnReg();
	}

	@Override
	public int getNewUserReg() throws Exception {
		return adminDAO.getNewUserReg();
	}

	@Override
	public int getNewTourTalk() throws Exception {
		return adminDAO.getNewTourTalk();
	}

}