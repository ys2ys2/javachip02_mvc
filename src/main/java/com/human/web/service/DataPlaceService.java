package com.human.web.service;

import java.util.List;
import java.util.Map;

public interface DataPlaceService {

	List<Map<String, Object>> getRandomDataPlace(int limit);
	Map<String, Object> getDataplaceById(int contentid);


}
