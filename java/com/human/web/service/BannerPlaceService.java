package com.human.web.service;

import java.util.List;
import java.util.Map;

public interface BannerPlaceService {
    List<Map<String, Object>> getRandomBannerPlace(int limit);  // 랜덤 배너 데이터 가져오기
    Map<String, Object> getBannerById(int contentid);  // contentid로 배너 상세 정보 가져오기
}
