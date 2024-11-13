package com.ict.mytravellist.ADD.dao;

import java.util.List;

import com.ict.mytravellist.vo.FAQVO;
import com.ict.mytravellist.vo.NoticeVO;
import com.ict.mytravellist.vo.QNAVO;

public interface AddDAO {
	// 공지사항 초기화면
	public List<NoticeVO> getNoticeList();
	
	// 공지사항 상세화면
	public NoticeVO getNoticeDetail(String noticeIdx);
	
	// 공지사항 이전글, 다음글 관련
	public List<NoticeVO> getNoticeAll();
	
	// FAQ 초기화면
	public List<FAQVO> getFAQList();
	
	// QNA 작성화면
	public int getQNAInsert(QNAVO qnavo);
	
	// QNA 상세화면
	public QNAVO getQNADetail(String qnaIdx);
	
	// QNA 상세화면-관리자
	public QNAVO getQNADetailAdmin(String qnaIdx);
	
	// FAQ 페이징 처리 - 전체 게시물의 수
	public int getFAQTotalCount();
	
	// Notice 페이징 처리 - 전체 게시물의 수
	public int getNoticeTotalCount();
	
	// QNA 페이징 처리 - 전체 게시물의 수
	public int getQNATotalCount();
	
	// FAQ 페이징 처리를 위한 리스트
	public List<FAQVO> getFAOList(int offset, int limit);
	
	// Notice 페이징 처리를 위한 리스트
	public List<NoticeVO> getNoticeList2(int offset, int limit);
	
	// QNA 페이징 처리를 위한 리스트
	public List<QNAVO> getQNAList(int offset, int limit, String userId);
	
	// 공지사항 검색 기능
	public List<NoticeVO> getNoticeSearch(String keyword2);
}