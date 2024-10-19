package com.human.web.service;

import java.util.List;
import java.util.Map;

public interface DataPlaceService {

	//title 목록 가져오기 랜덤(dataplace)
	List<Map<String, Object>> getRandomDataPlace(int limit);
	
	//contentid로 dataplaceDetail연결하기
	Map<String, Object> getDataplaceById(int contentid);
	


}
