package com.human.web.service;

import java.util.List;
import java.util.Map;

public interface HotPlaceService {
    String insertHotPlaceData(String selectedContentIds, List<Map<String, Object>> detailItemList);

    //title 목록 가져오기
    List<Map<String, Object>> getRandomHotplaceDetail(int limit);
    
    Map<String, Object> getHotplaceById(int contentid);

	void saveHotplace(int m_idx, String contentid);
    
    
}
