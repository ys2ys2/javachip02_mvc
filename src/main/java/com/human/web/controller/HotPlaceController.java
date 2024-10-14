package com.human.web.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.human.web.service.HotPlaceService;

public class HotPlaceController {
	
	@Autowired
	private HotPlaceService hotplaceService;
	
	// contentID로 해당 핫플레이스 상세 정보 가져오기
	@GetMapping("/hotplace/detail")
	public String showHotplaceDetail(@RequestParam("contentid") int contentid, Model model) {
		//contentid로 해당 hotplace 상세 정보 가져오기
		Map<String, Object> hotplace = hotplaceService.getHotplaceById(contentid);
		model.addAttribute("hotplace", hotplace);
		return "HotPlace/detail";
	}

}
