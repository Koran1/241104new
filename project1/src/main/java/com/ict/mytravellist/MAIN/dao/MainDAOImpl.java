package com.ict.mytravellist.MAIN.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.mytravellist.vo.ReportVO;
import com.ict.mytravellist.vo.TourTalkVO;
import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.WeatherVO;

@Repository
public class MainDAOImpl implements MainDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	} 
	
	// 랜덤 지역 이미지 불러오기
	@Override
	public List<TravelDBVO> getRandomList() {
	    return sqlSessionTemplate.selectList("main.randomList");  // 랜덤한 여행지 반환
	}
	
	@Override
	public List<TravelDBVO> getRandomLoginList(String userId) {
	    return sqlSessionTemplate.selectList("main.randomLoginList", userId);  // 랜덤한 여행지 반환
	}
	
	 // 키워드와 지역으로 검색하는 메서드
	@Override
    public List<TravelDBVO> searchKeywordAndRegion(String keyword, String region) {
        try {
            Map<String, String> map = new HashMap<>();
            map.put("keyword", keyword);
            map.put("region", region);

            List<TravelDBVO> list = sqlSessionTemplate.selectList("main.getSearchKeyRegion", map);
            return list;
        } catch (Exception e) {
            return null;
        }
    }
	
    // 특정 관광지 이름으로 상세 정보를 가져오는 메서드
	@Override
    public List<TravelDBVO> getDetailList(String travelIdx) {
        try {
            List<TravelDBVO> list = sqlSessionTemplate.selectList("main.getDetailList", travelIdx);
            return list;
        } catch (Exception e) {
        	e.printStackTrace();
            System.out.println("getDetailList 검색 중 오류 발생: " + e.getMessage());
            return null;
        }
    }

	@Override
	public List<WeatherVO> getWeatherList() {
		return sqlSessionTemplate.selectList("main.getWeatherList");
	}

	@Override
	public int getSearchCount(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("main.count", map);
	}

    @Override
    public List<TravelDBVO> getSearchPageList(Map<String, Object> map) {
        return sqlSessionTemplate.selectList("main.page_list", map);
    }

}