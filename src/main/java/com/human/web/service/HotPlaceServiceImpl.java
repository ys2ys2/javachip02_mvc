package com.human.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.human.web.repository.HotPlaceDAO;

@Service
public class HotPlaceServiceImpl implements HotPlaceService {

    @Autowired
    private HotPlaceDAO hotplaceDAO;

    @Transactional
    @Override
    public String insertHotPlaceData(String selectedContentIds, List<Map<String, Object>> detailItemList) {
        String[] contentIdArray = selectedContentIds.split(",");
        
        try {
            for (String contentId : contentIdArray) {
                contentId = contentId.trim();
                
                // detailItemList에서 contentId에 맞는 데이터를 찾음
                for (Map<String, Object> detailData : detailItemList) {
                    if (contentId.equals(detailData.get("contentid"))) {
                        
                        // 추가 이미지 URL 처리
                        StringBuilder imageUrls = new StringBuilder((String) detailData.get("firstimage"));
                        List<Map<String,String>> images = (List<Map<String,String>>) detailData.get("images");
                        
                        if (images != null && !images.isEmpty()) {
                            for (Map<String, String> imageData : images) {
                                if (imageUrls.length() > 0) {
                                    imageUrls.append(",");
                                }
                                imageUrls.append(imageData.get("originimgurl"));
                            }
                        }
                        
                        // DAO 호출 (DB에 데이터 삽입)
                        try {
                            int result = hotplaceDAO.insertHotPlace(
                                contentId,
                                (String) detailData.get("title"),
                                (String) detailData.get("addr1"),
                                (String) detailData.get("overview"),
                                Double.parseDouble((String) detailData.get("mapx")),
                                Double.parseDouble((String) detailData.get("mapy")),
                                imageUrls.toString(),
                                (String) detailData.get("areacode")
                            );
                        } catch (Exception e) {
                            System.out.println("DB 삽입 중 오류 발생: " + e.getMessage());
                            e.printStackTrace();
                        }

                        break;
                    }
                }
            }
            return "데이터가 성공적으로 저장되었습니다.";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "데이터 저장 중 예외 발생: " + e.getMessage();
        }
    }
}
