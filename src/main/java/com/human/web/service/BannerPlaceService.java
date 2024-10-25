package com.human.web.service;

import java.util.List;
import java.util.Map;

public interface BannerPlaceService {
    List<Map<String, Object>> getRandomBannerPlace(int limit); // 랜덤 배너 데이터 가져오기

    Map<String, Object> getBannerById(int contentid); // contentid로 배너 상세 정보 가져오기

    List<Map<String, Object>> getBannersByAreaCode(String areacode); // areacode로 지역정보 가져오기

    String convertAreaCodeToName(String areacode); // 지역명 한글 변환 메서드
}
