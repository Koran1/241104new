package com.ict.mytravellist.ADMIN.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mytravellist.ADMIN.dao.AdminDAO;
import com.ict.mytravellist.vo.NoticeVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO adminDAO;
	
	@Override
	public List<NoticeVO> getNoticeList() {
		return adminDAO.getNoticeList();
	}

	@Override
	public int getNoticeInsert(NoticeVO noticevo) {
		return adminDAO.getNoticeInsert(noticevo);
	}
	
}