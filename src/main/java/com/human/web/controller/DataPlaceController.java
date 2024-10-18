package com.human.web.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; // Controller 어노테이션 추가
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.human.web.service.DataPlaceService;

@Controller // 이 클래스를 컨트롤러로 인식하게 함
public class DataPlaceController {
    
    @Autowired
    private DataPlaceService dataPlaceService;

    // contentID로 데이터 상세 페이지 가져오기
    @GetMapping("/DataPlace/{contentid}")
    public String showBannerDetailByContentId(@PathVariable("contentid") int contentid, Model model) {
        // contentid에 해당하는 배너 정보를 가져옴
        Map<String, Object> dataplace = dataPlaceService.getDataplaceById(contentid);

        // JSP로 데이터 전달
        model.addAttribute("dataplace", dataplace); 

        return "HomePage/dataplaceDetail"; // 상세 페이지로 이동
    }
}
