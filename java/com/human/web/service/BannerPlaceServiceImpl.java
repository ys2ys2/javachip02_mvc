package com.human.web.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.BannerPlaceDAO;

@Service
public class BannerPlaceServiceImpl implements BannerPlaceService {

    @Autowired
    private BannerPlaceDAO bannerPlaceDAO;

    @Override
    public List<Map<String, Object>> getRandomBannerPlace(int limit) {
        // DB에서 랜덤으로 배너 데이터를 가져옴
        List<Map<String, Object>> bannerPlaces = bannerPlaceDAO.getRandomBannerPlace(limit);

        // firstimage 필드에서 첫 번째 이미지 URL만 남기기
        return bannerPlaces.stream().map(bannerPlace -> {
            String firstimage = (String) bannerPlace.get("firstimage");
            if (firstimage != null && firstimage.contains(",")) {
                // 쉼표로 구분된 이미지 중 첫 번째만 추출
                firstimage = firstimage.split(",")[0].trim();
            }
            bannerPlace.put("firstimage", firstimage);
            return bannerPlace;
        }).collect(Collectors.toList());
    }

    @Override
    public Map<String, Object> getBannerById(int contentid) {
        return bannerPlaceDAO.getBannerById(contentid);
    }
    
    
    
    
    
}

