package com.ict.mytravellist.PLAN.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mytravellist.PLAN.dao.TravelDAO;
import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.TrvlPlanVO;

@Service
public class TravelServiceImpl implements TravelService{
	
	@Autowired
	private TravelDAO travelDAO;

	@Override
	public List<TravelDBVO> selectListTrvlFavPaged(String userId, int offset, int limit) throws Exception {
		return travelDAO.selectListTrvlFavPaged(userId, offset, limit);
	}
	
	@Override
	public List<TravelDBVO> selectListTrvlFav(String userId) throws Exception {
		return travelDAO.selectListTrvlFav(userId);
	}
	
	@Override
	public TravelDBVO selectOne(String travelIdx) throws Exception {
		return travelDAO.selectOne(travelIdx);
	}

	@Override
	public List<TrvlPlanVO> selectTrvlPlans(String userId, int offset, int limit) throws Exception {
		return travelDAO.selectTrvlPlans(userId, offset, limit);
	}

	@Override
	public TrvlPlanVO selectOneTrvlPlan(String trvlPlanIdx) throws Exception {
		return travelDAO.selectOneTrvlPlan(trvlPlanIdx);
	}

	@Override
	public int insertTrvlPlan(TrvlPlanVO tplvo) throws Exception {
		return travelDAO.insertTrvlPlan(tplvo);
	}

	@Override
	public int updateTrvlPlan(TrvlPlanVO tplvo) throws Exception {
		return travelDAO.updateTrvlPlan(tplvo);
	}

	@Override
	public int getTotalCount(String userId) throws Exception {
		return travelDAO.getTotalCount(userId);
	}

	@Override
	public int getPlansCount(String userId) throws Exception {
		return travelDAO.getPlansCount(userId);
	}

	@Override
	public int unlikeTrvlFav(String userId, String trvlPlanIdx) throws Exception {
		return travelDAO.unlikeTrvlFav(userId, trvlPlanIdx);
	}

	
}
