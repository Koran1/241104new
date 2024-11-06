package com.ict.mytravellist.MAIN.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mytravellist.MAIN.dao.MainDAO;
import com.ict.mytravellist.MAIN.dao.TourTalkDAO;
import com.ict.mytravellist.vo.TourTalkVO;
import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.WeatherVO;

@Service
public class MainServiceImpl implements MainService {
		
	@Autowired
	private MainDAO mainDAO;
	
	@Autowired
    private TourTalkDAO tourTalkDAO;
	
	// 랜덤 지역 이미지 불러오기
	@Override
    public List<TravelDBVO> getRandomList() {
    	List<TravelDBVO> list = mainDAO.getRandomList();
        // System.out.println("getRandomList MainServiceImpl 통과");
        return list;
    }
	
	@Override
    public List<TravelDBVO> getRandomLoginList(String userId) {
        return mainDAO.getRandomLoginList(userId);
    }

	// 키워드와 지역으로 검색
    @Override
    public List<TravelDBVO> searchKeywordAndRegion(String keyword, String region) {
        List<TravelDBVO> list = mainDAO.searchKeywordAndRegion(keyword, region);
        System.out.println("searchKeywordAndRegion MainService 통과");
        return list;
    }

    // 특정 관광지 이름으로 상세 정보 조회
    @Override
    public List<TravelDBVO> getDetailList(String travelIdx) {
        List<TravelDBVO> list = mainDAO.getDetailList(travelIdx);
        // System.out.println("getDetailList MainService 통과");
        return list;
    }

	@Override
	public List<WeatherVO> getWeatherList() {
		return mainDAO.getWeatherList();
	}


	@Override
	public int getSearchCount(String keyword, String region) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("keyword", keyword);
	    map.put("region", region);
	    return mainDAO.getSearchCount(map);
	}

	@Override
	public List<TravelDBVO> getSearchPageList(int limit, int offset, TravelDBVO tdvo) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("offset", offset);
	    map.put("limit", limit);
	    map.put("tdvo", tdvo);
	    return mainDAO.getSearchPageList(map);
	}

	@Override
	public List<TravelDBVO> getSearchList(String keyword) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertTourTalk(TourTalkVO tourtvo) {
		return mainDAO.insertTourTalk(tourtvo);
		
	}
}
