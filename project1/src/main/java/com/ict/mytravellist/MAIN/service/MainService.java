package com.ict.mytravellist.MAIN.service;

import java.util.List;

import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.WeatherVO;

public interface MainService {

	public List<TravelDBVO> getRandomList();
	public List<TravelDBVO> getRandomLoginList(String userId);
	public int getSearchCount(String keyword, String region) ;
	public List<TravelDBVO> getSearchPageList(int limit, int offset, TravelDBVO tdvo) ;
	public List<TravelDBVO> searchKeywordAndRegion(String keyword, String region);
	public List<TravelDBVO> getDetailList(String travelIdx);
	public List<WeatherVO> getWeatherList();

}
