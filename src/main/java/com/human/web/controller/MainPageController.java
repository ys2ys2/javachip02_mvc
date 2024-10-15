package com.human.web.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.human.web.service.HotPlaceService;

@Controller
public class MainPageController {

    @Autowired
    private HotPlaceService hotplaceService;

    // 핫플 테이블의 상세 정보를 랜덤으로 가져오기
    @GetMapping("/HomePage/mainpage")
    public String showHotplaceDetails(Model model) {
        // 랜덤으로 5개의 핫플레이스 정보를 가져옴
        List<Map<String, Object>> hotplaceDetails = hotplaceService.getRandomHotplaceDetail(5);

        // JSP로 데이터 전달
        model.addAttribute("hotplaceDetails", hotplaceDetails);

        return "HomePage/mainpage"; // mainpage.jsp로 이동
    }

    // contentID로 해당 페이지 가져오기
    @GetMapping("/hotplace/detail")
    public String showHotplaceDetail(@RequestParam("contentid") int contentid, Model model) {
        Map<String, Object> hotplace = hotplaceService.getHotplaceById(contentid);
        model.addAttribute("hotplace", hotplace);
        return "hotplace/detail";
    }

    // HotPlace 상세 페이지 만들기
    @GetMapping("/HotPlace/{contentid}")
    public String showHotplaceByContentId(@PathVariable("contentid") int contentid, Model model) {
        // contentid에 해당하는 hotplace 정보 가져오기
        Map<String, Object> hotplace = hotplaceService.getHotplaceById(contentid);

        // jsp로 전달
        model.addAttribute("hotplace", hotplace);

        // HotPlace detail 페이지로 이동
        return "HotPlace/detail";

    }
}
