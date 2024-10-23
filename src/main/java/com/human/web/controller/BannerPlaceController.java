package com.human.web.controller;

import java.util.List;
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

                // 현재 배너 areacode로 지역 여행지 만들기
                String areacode = (String) banner.get("areacode");
                String areaName = bannerPlaceService.convertAreaCodeToName(areacode);
                banner.put("areacode", areaName);

                // 해당 지역 다른 배너 정보 가져오기
                List<Map<String, Object>> bannersByArea = bannerPlaceService.getBannersByAreaCode(areacode);

                // JSP로 데이터 전달
                model.addAttribute("banner", banner); // 현재 배너 정보
                model.addAttribute("bannersByArea", bannersByArea); // 같은 지역 배너 리스트

                return "HomePage/bannerDetail"; // 상세 페이지로 이동
        }
}
