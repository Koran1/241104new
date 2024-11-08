package com.ict.mytravellist.ADMIN.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.mytravellist.ADMIN.vo.AdminVO;
import com.ict.mytravellist.vo.FAQVO;
import com.ict.mytravellist.vo.NoticeVO;
import com.ict.mytravellist.vo.QNAVO;
import com.ict.mytravellist.vo.TourTalkVO;
import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.UserVO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<UserVO> getUserList(int offset, int limit) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("admin.getUserList", map);
	}

	@Override
	public int countTotalData() throws Exception {
		return sqlSessionTemplate.selectOne("admin.countTotalData");
	}

	@Override
	public TourTalkVO getTTRecentOne(String userId) throws Exception {
		return sqlSessionTemplate.selectOne("admin.getTTRecentOne", userId);
	}

	@Override
	public QNAVO getQNARecentOne(String userId) throws Exception {
		return sqlSessionTemplate.selectOne("admin.getQNARecentOne", userId);
	}

	@Override
	public int getCountTT(String userId) throws Exception {
		return sqlSessionTemplate.selectOne("admin.getCountTT", userId);
	}

	@Override
	public int getCountQNA(String userId) throws Exception {
		return sqlSessionTemplate.selectOne("admin.getCountQNA", userId);
	}

	@Override
	public int getManageUser(UserVO uvo) throws Exception {
		return sqlSessionTemplate.update("admin.getManageUser", uvo);
	}

	@Override
	public List<UserVO> getFilteredList(String f_keyword, String filter_lev, int offset, int limit) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("f_keyword", f_keyword);
		map.put("filter_lev", filter_lev);
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("admin.getFilteredList", map);
	}

	@Override
	public int countFilteredData(String f_keyword, String filter_lev) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("f_keyword", f_keyword);
		map.put("filter_lev", filter_lev);
		return sqlSessionTemplate.selectOne("admin.countFilteredData", map);
	}
	
	@Override
	public List<NoticeVO> getNoticeList(int offset, int limit) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("admin.notice_list", map);
	}

	@Override
	public int getNoticeInsert(NoticeVO noticevo) throws Exception {
		return sqlSessionTemplate.insert("admin.notice_insert", noticevo);
	}

	@Override
	public int getNoticeUpdate(NoticeVO noticeVO) throws Exception {
		return sqlSessionTemplate.update("admin.notice_update", noticeVO);
	}

	@Override
	public int getNoticeTotalCount() throws Exception {
		return sqlSessionTemplate.selectOne("admin.notice_count");
	}

	@Override
	public List<FAQVO> getFAQList(int offset, int limit) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("admin.faq_list", map);
	}

	@Override
	public int getFAQInsert(FAQVO faqvo) throws Exception {
		return sqlSessionTemplate.insert("admin.faq_insert", faqvo);
	}

	@Override
	public int getFAQUpdate(FAQVO faqvo) throws Exception {
		return sqlSessionTemplate.update("admin.faq_update", faqvo);
	}

	@Override
	public int getFAQTotalCount() throws Exception {
		return sqlSessionTemplate.selectOne("admin.faq_count");
	}

	@Override
	public int getQNAAnswered(QNAVO qnavo) throws Exception {
		return sqlSessionTemplate.update("admin.qna_update", qnavo);
	}

	@Override
	public List<QNAVO> getQNAList(int offset, int limit) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("admin.qna_list", map);
	}

	@Override
	public int getQNATotalCount() throws Exception {
		return sqlSessionTemplate.selectOne("admin.qna_count");
	}

	@Override
	public QNAVO getQNAOneList(String qnaIdx) throws Exception {
		return sqlSessionTemplate.selectOne("admin.qna_onelist", qnaIdx);
	}

	@Override
	public List<TravelDBVO> getMainList(int offset, int limit) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("admin.main_list", map);
	}

	@Override
	public TravelDBVO getMainOneList(String travelIdx) throws Exception {
		return sqlSessionTemplate.selectOne("admin.main_onelist", travelIdx);
	}

	@Override
	public int getMainInsert(TravelDBVO tdvo) throws Exception {
		return sqlSessionTemplate.insert("admin.main_insert", tdvo);
	}

	@Override
	public int getMainUpdate(TravelDBVO tdvo) throws Exception {
		return sqlSessionTemplate.update("admin.main_update", tdvo);
	}

	@Override
	public int getMainTotalCount() throws Exception {
		return sqlSessionTemplate.selectOne("admin.main_count");
	}

	@Override
	public AdminVO getAdminInfo(String adminID) throws Exception {
		return sqlSessionTemplate.selectOne("admin.get_admininfo", adminID);
	}

}