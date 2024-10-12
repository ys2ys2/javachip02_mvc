package com.human.web.service;

import java.util.List;
import java.util.Map;

public interface HotPlaceService {
    String insertHotPlaceData(String selectedContentIds, List<Map<String, Object>> detailItemList);

}
