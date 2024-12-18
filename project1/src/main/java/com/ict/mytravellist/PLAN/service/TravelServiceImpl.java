package com.ict.mytravellist.PLAN.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mytravellist.PLAN.dao.TravelDAO;
import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.TrvlPlanVO;
import com.ict.mytravellist.vo.UserInterest;

@Service
public class TravelServiceImpl implements TravelService{
	
	@Autowired
	private TravelDAO travelDAO;

	@Override
	public List<TravelDBVO> selectListTrvlFavPaged(String userId, int offset, int limit, String region) throws Exception {
		return travelDAO.selectListTrvlFavPaged(userId, offset, limit, region);
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
	public int getTotalCount(String userId, String region) throws Exception {
		return travelDAO.getTotalCount(userId, region);
	}

	@Override
	public int getPlansCount(String userId) throws Exception {
		return travelDAO.getPlansCount(userId);
	}

	@Override
	public int unlikeTrvlFav(String userId, String trvlPlanIdx) throws Exception {
		return travelDAO.unlikeTrvlFav(userId, trvlPlanIdx);
	}

	@Override
	public int likeTrvlFav(String userId, String trvlPlanIdx, String region) throws Exception {
		return travelDAO.likeTrvlFav(userId, trvlPlanIdx, region);
	}

	@Override
	public List<UserInterest> getUserFavs(String userId) throws Exception {
		return travelDAO.getUserFavs(userId);
	}

	@Override
	public int deleteTrvlPlan(String userId, String trvlPlanIdx) throws Exception {
		return travelDAO.deleteTrvlPlan(userId, trvlPlanIdx);
	}

	
}
