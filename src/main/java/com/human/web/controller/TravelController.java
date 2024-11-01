package com.human.web.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.human.web.service.HotPlaceService;
import com.human.web.service.MatzipService;
import com.human.web.service.TravelPostService;
import com.human.web.service.TravelService;
import com.human.web.vo.MatzipVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/RecoSpot")
@RequiredArgsConstructor
public class TravelController {
	
	
    @Autowired
    private TravelService travelService; // TravelService를 통한 데이터 조회
    
    @Autowired
	private HotPlaceService hotplaceService;
    
	@Autowired
	private TravelPostService travelPostService;
	
	@Autowired
	private MatzipService matzipService; // MatzipService 인스턴스를 주입받음
    
    // travel_seoul에 여행기 가져오기
    
    @GetMapping("/travel_Seoul")
    public String travel_Seoul(Model model) {
		List<Map<String, Object>> travelPost = travelPostService.getRandomTravelPost(4);
    	List<Map<String, Object>> hotplaceDetails = hotplaceService.getRandomHotplaceDetail(33); // 핫플 부분
		List<MatzipVO> matzipList = matzipService.getMatzipList(); // DB에서 모든 맛집 리스트를 가져옴 

		// 각 맛집의 firstimage에서 쉼표로 구분된 첫 번째 URL만 가져오도록 처리
		  matzipList.forEach(matzip -> { String firstimage = matzip.getFirstimage(); // MatzipVO에서 firstimage 필드 가져오기
		  if (firstimage != null && firstimage.contains(",")) { // 쉼표로 구분된 이미지 중 첫 번째만 추출
			  firstimage = firstimage.split(",")[0].trim(); } matzip.setFirstimage(firstimage); // 첫 번째 URL로 설정 
		  });
		
    	
		model.addAttribute("travelPost", travelPost);
    	model.addAttribute("hotplaceDetails", hotplaceDetails);
    	model.addAttribute("matzipList", matzipList);

    	
        return "/RecoSpot/travel_Seoul";
    }
    
    
   
   
   
}
    
