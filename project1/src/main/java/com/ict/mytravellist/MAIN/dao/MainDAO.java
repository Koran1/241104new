package com.ict.mytravellist.MAIN.dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import com.ict.mytravellist.vo.TourTalkVO;
import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.WeatherVO;

@Mapper
public interface MainDAO {
	public List<TravelDBVO> getRandomList();
	public List<TravelDBVO> getSearchList(String keyword) ;
	public int getSearchCount(Map<String, Object> map);
	public List<TravelDBVO> getSearchPageList(Map<String, Object> map);
	public List<TravelDBVO> searchKeywordAndRegion(String keyword, String region);
	public List<TravelDBVO> getDetailList(String travelIdx);
	public List<WeatherVO> getWeatherList();
	public int insertTourTalk(TourTalkVO tourtvo);
}