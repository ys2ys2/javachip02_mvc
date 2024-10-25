package com.human.web.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.human.web.service.BannerPlaceService;

@Controller
public class BannerPlaceController {

    @Autowired
    private BannerPlaceService bannerPlaceService;


    // contentID로 배너 상세 페이지 가져오기
    @GetMapping("/BannerPlace/{contentid}")
    public String showBannerDetailByContentId(@PathVariable("contentid") int contentid, Model model) {
        // contentid에 해당하는 배너 정보를 가져옴
        Map<String, Object> banner = bannerPlaceService.getBannerById(contentid);

        // JSP로 데이터 전달
        model.addAttribute("banner", banner);

        return "HomePage/bannerDetail"; // 상세 페이지로 이동
    }
}
