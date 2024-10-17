package com.human.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.human.web.service.MypageService;
import com.human.web.vo.MypageVO;

@Controller
@RequestMapping("/MyPage") 
public class MypageController {

	// 내 여행 페이지로 이동
	  
		  @GetMapping("/m_myTrips") 
		  public String myTrips() { 
			  return "MyPage/m_myTrips"; }
		  
		  // 내 여행기 페이지로 이동
		  
		  @GetMapping("/m_myJourneys") 
		  public String myJourneys() { 
			  return "MyPage/m_myJourneys"; }
		  
		  // 저장 목록 페이지로 이동
		  
		  @GetMapping("/m_savedList") 
		  public String savedList() { 
			  return "MyPage/m_savedList"; }
		 
		  @GetMapping("/m_commentManagement") 
		  public String m_commentManagement() { 
			  return "MyPage/m_commentManagement"; }
		 
	
	@Autowired
	private MypageService mypageService;
	
	  // model: JSP에 데이터를 전달하기 위한 Model 객체
	@GetMapping("/myPageMain")
	public String showMypage(Model model) {
		 System.out.println("MypageController - showMypage 호출됨");  // 메서드 호출 확인
		List<MypageVO> mypageList = mypageService.getMypageList();
		 // JSP에서 사용할 수 있도록 모델에 데이터를 추가
		model.addAttribute("m_mypageList", mypageList);
		
        // "mypage" 이름의 JSP 파일을 반환
		return "MyPage/myPageMain";
	}
	
	
	// 출력하든 상세페이지 이런건 여기서 처리
	
	
	
	

}