package com.human.web.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.human.web.service.HotPlaceService;
import com.human.web.service.MatzipService;
import com.human.web.vo.MatzipVO;

@Controller
public class inputApiController {
	
	//inputApi.jsp
	@GetMapping("/HotPlace/inputApi")
	public String inputApi() {
		return "HotPlace/inputApi";
	}
	
	//processCodeApi.jsp
	@PostMapping("/HotPlace/processCodeApi")
	public String processCodeApi() {
		return "HotPlace/processCodeApi";
	}
	
	//processDetailApi.jsp
	@PostMapping("/HotPlace/processDetailApi")
	public String processDetailApi() {
		return "HotPlace/processDetailApi";
	}
	
	
	
	//inputDB
	@Autowired
	private HotPlaceService hotPlaceService; //서비스 주입
	
		@PostMapping("HotPlace/inputDB")
		public String inputData(@RequestParam("selectedContentIds") String selectedContentIds,
                		HttpSession session, RedirectAttributes redirectAttributes) {
	        // 세션에서 'detailItemList' 가져오기
	        List<Map<String, Object>> detailItemList = (List<Map<String, Object>>) session.getAttribute("detailItemList");
	        
	        if (selectedContentIds == null || selectedContentIds.isEmpty()) {
	            redirectAttributes.addFlashAttribute("message", "콘텐츠 ID를 선택해 주세요.");
	            return "redirect:/HotPlace/errorPage";  // 에러 페이지로 리다이렉트
	        }
	
	        if (detailItemList == null) {
	            redirectAttributes.addFlashAttribute("message", "세션에서 데이터를 가져올 수 없습니다.");
	            return "redirect:/HotPlace/errorPage";  // 에러 페이지로 리다이렉트
	        }
	
	        // 서비스 호출하여 DB에 데이터 저장
	        String resultMessage = hotPlaceService.insertHotPlaceData(selectedContentIds, detailItemList);
	        redirectAttributes.addFlashAttribute("message", resultMessage);
	
	        // 성공 후 결과 페이지로 리다이렉트
	        return "redirect:/HotPlace/inputDB";  // 성공 페이지로 리다이렉트
	    }
	
	@GetMapping("/HotPlace/inputDB")
	public String inputDB() {
	    return "HotPlace/inputDB";
	}
	
	
	//맛집 api
	//MatzipApi
	@GetMapping("/Matzip/MatzipApi")
	public String MatzipApi() {
		return "Matzip/MatzipApi";
	}
	
	//processMatzipCodeApi
	@PostMapping("/Matzip/processMatzipCodeApi")
	public String processMatzipCodeApi() {
		return "Matzip/processMatzipCodeApi";
	}
	
	//processDetailApi
	@PostMapping("/Matzip/processMatzipDetailApi")
	public String processMatzipDetailApi() {
		return "Matzip/processMatzipDetailApi";
	}
	
	
	//inputMatzipDB
	@Autowired
	private MatzipService matzipService;
	
	@PostMapping("/Matzip/inputMatzipDB")
	public String inputMatzipDB(@RequestParam("selectedContentIds") String selectedContentIds,
						HttpSession session, RedirectAttributes redirectAttributes) {
	    
		    List<MatzipVO> restaurantList = (List<MatzipVO>) session.getAttribute("restaurantList");
		
		if (selectedContentIds == null || selectedContentIds.isEmpty()) {
			redirectAttributes.addFlashAttribute("message", "음식점 ID를 선택해 주세요.");
			return "redirect:/Matzip/MatzipApi";
			
		}
		
		if(restaurantList == null) {
			redirectAttributes.addFlashAttribute("message", "세션에서 데이터를 가져올 수 없습니다.");
			return "redirect:/Matzip/MatzipApi";
		}
		
		 // 선택된 ID를 기준으로 restaurantList에서 필터링
	    List<MatzipVO> selectedRestaurants = restaurantList.stream()
	            .filter(restaurant -> selectedContentIds.contains(restaurant.getId()))
	            .collect(Collectors.toList());

	    // 서비스 호출하여 DB에 데이터 저장
	    String resultMessage = matzipService.insertMatzipData(selectedRestaurants);
	    redirectAttributes.addFlashAttribute("message", resultMessage);

	    // 성공 후 결과 페이지로 리다이렉트
	    return "redirect:/Matzip/inputMatzipDB";  // 성공 페이지로 리다이렉트
	}
	
	@GetMapping("/Matzip/inputMatzipDB")
	public String inputMatzip() {
		return "Matzip/inputMatzipDB";
	}
}
