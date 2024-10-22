package com.human.web.service;

import java.util.List;
import java.util.Map;

public interface TravelPostService {
	
	// 랜덤 travelPost
	List<Map<String, Object>> getRandomTravelPost(int limit);

}
