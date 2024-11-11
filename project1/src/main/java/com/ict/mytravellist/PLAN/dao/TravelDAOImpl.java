package com.ict.mytravellist.PLAN.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.TrvlPlanVO;
import com.ict.mytravellist.vo.UserInterest;

@Repository
public class TravelDAOImpl implements TravelDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<TravelDBVO> selectListTrvlFav(String userId) throws Exception {
		return sqlSessionTemplate.selectList("trvlplan.list", userId);
	}
	
	@Override
	public List<TravelDBVO> selectListTrvlFavPaged(String userId, int offset, int limit) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("trvlplan.list_paged", map);
	}
	
	@Override
	public TravelDBVO selectOne(String travelIdx) throws Exception{
		return sqlSessionTemplate.selectOne("trvlplan.onelist", travelIdx);
	}

	@Override
	public List<TrvlPlanVO> selectTrvlPlans(String userId, int offset, int limit) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("trvlplan.select_trvlplans", map);
	}

	@Override
	public TrvlPlanVO selectOneTrvlPlan(String trvlPlanIdx) throws Exception {
		return sqlSessionTemplate.selectOne("trvlplan.select_onetrvlplan", trvlPlanIdx);
	}

	@Override
	public int insertTrvlPlan(TrvlPlanVO tplvo) throws Exception {
		return sqlSessionTemplate.insert("trvlplan.insert_trvlplan", tplvo);
	}

	@Override
	public int updateTrvlPlan(TrvlPlanVO tplvo) throws Exception {
		return sqlSessionTemplate.update("trvlplan.update_trvlplan", tplvo);
	}

	@Override
	public int getTotalCount(String userId) throws Exception {
		return sqlSessionTemplate.selectOne("trvlplan.count", userId);
	}

	@Override
	public int getPlansCount(String userId) throws Exception {
		return sqlSessionTemplate.selectOne("trvlplan.plan_count", userId);
	}

	@Override
	public int unlikeTrvlFav(String userId, String trvlPlanIdx) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("travelIdx", trvlPlanIdx);
		return sqlSessionTemplate.delete("trvlplan.unlike", map);
	}

	@Override
	public int likeTrvlFav(String userId, String trvlPlanIdx) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("travelIdx", trvlPlanIdx);
		return sqlSessionTemplate.insert("trvlplan.like", map);
	}

	@Override
	public List<UserInterest> getUserFavs(String userId) throws Exception {
		return sqlSessionTemplate.selectList("trvlplan.get_userfavs", userId);
	}

	@Override
	public int deleteTrvlPlan(String userId, String trvlPlanIdx) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("trvlPlanIdx", trvlPlanIdx);
		return sqlSessionTemplate.delete("trvlplan.delete_trvlplan", map);
	}

	

	
	
}
