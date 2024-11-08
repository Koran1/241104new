package com.ict.mytravellist.PLAN.service;

import java.util.List;

import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.TrvlPlanVO;
import com.ict.mytravellist.vo.UserInterest;

public interface TravelService {
	public List<TravelDBVO> selectListTrvlFav(String userId) throws Exception;
	public List<TravelDBVO> selectListTrvlFavPaged(String userId, int offset, int limit) throws Exception;
	public TravelDBVO selectOne(String travelIdx) throws Exception;
	public List<TrvlPlanVO> selectTrvlPlans(String userId, int offset, int limit) throws Exception;
	public TrvlPlanVO selectOneTrvlPlan(String trvlPlanIdx) throws Exception;
	public int insertTrvlPlan(TrvlPlanVO tplvo) throws Exception;
	public int updateTrvlPlan(TrvlPlanVO tplvo) throws Exception;
	public int getTotalCount(String userId) throws Exception;
	public int getPlansCount(String userId) throws Exception;
	public int unlikeTrvlFav(String userId, String trvlPlanIdx) throws Exception;
	public int likeTrvlFav(String userId, String trvlPlanIdx) throws Exception;
	public List<UserInterest> getUserFavs(String userId) throws Exception;
}
