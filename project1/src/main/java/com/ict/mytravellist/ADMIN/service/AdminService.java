package com.ict.mytravellist.ADMIN.service;

import java.util.List;

import com.ict.mytravellist.vo.NoticeVO;

public interface AdminService {
	// 공지사항 초기화면
	public List<NoticeVO> getNoticeList();
	
	// 공지사항 작성화면
	public int getNoticeInsert(NoticeVO noticevo);
}