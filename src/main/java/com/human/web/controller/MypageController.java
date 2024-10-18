package com.human.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.human.web.service.MypageService;
import com.human.web.vo.M_MemberVO;
import com.human.web.vo.MypageVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/MyPage") 
@RequiredArgsConstructor
public class MypageController {


	// 내 여행 페이지로 이동
	@GetMapping("/m_myTrips") 
	public String myTrips() { 
		return "MyPage/m_myTrips"; 
	}

	// 내 여행기 페이지로 이동
	@GetMapping("/m_myJourneys") 
	public String myJourneys() { 
		return "MyPage/m_myJourneys"; 
	}

	// 저장 목록 페이지로 이동
	/*
	 * @GetMapping("/m_savedList") public String savedList() { return
	 * "MyPage/m_savedList"; }
	 */

	// 댓글 관리 페이지로 이동
	@GetMapping("/m_commentManagement") 
	public String m_commentManagement() { 
		return "MyPage/m_commentManagement"; 
	}


	@Autowired
	private MypageService mypageService;

	@GetMapping("/myPageMain")
	public String showMypage(HttpSession session, Model model) {
		
		Integer m_idx = (Integer) session.getAttribute("m_idx");
	    System.out.println("로그인된 사용자 m_idx: " + m_idx);  // m_idx 값 로그로 출력	
		
		System.out.println("MypageController - showMypage 호출됨");  // 디버깅
		List<MypageVO> hotplaceList = mypageService.getRandomHotplaceList();
		model.addAttribute("hotplaceList", hotplaceList);
		
		return "MyPage/myPageMain";
	}

	
	@RequestMapping("/m_savedList")
	public String getSavedList(HttpSession session, Model model) {
	    // 세션에서 M_MemberVO 객체 가져오기
	    M_MemberVO member = (M_MemberVO) session.getAttribute("member"); //로그인할때 저장한 vo를 session에서 가져오기
	    
	    if (member == null) {
	        return "redirect:/Member/login";  // 로그인 정보가 없으면 로그인 페이지로 리다이렉트
	    }

	    // M_MemberVO에서 m_idx 값 가져오기
	    int m_idx = member.getM_idx();
	    System.out.println("로그인된 사용자 m_idx: " + m_idx);  // 로그로 m_idx 확인

	    // 저장된 목록 가져오기
	    List<MypageVO> savedList = mypageService.getSavedList(m_idx);
	    model.addAttribute("savedList", savedList);

	    return "MyPage/m_savedList";
	}
	
	
	
	/*
	 * @RequestMapping("/m_savedList") public String getSavedList(HttpSession
	 * session, Model model) { // 세션에서 m_idx 값 확인 Integer m_idx = (Integer)
	 * session.getAttribute("m_idx"); System.out.println("로그인된 사용자 m_idx: " +
	 * m_idx); // m_idx 값 로그로 출력
	 * 
	 * if (m_idx == null) {
	 * System.out.println("m_idx가 null입니다. 세션에 m_idx 값이 없습니다."); return
	 * "redirect:/Member/login"; // m_idx가 없으면 로그인 페이지로 리다이렉트 }
	 * 
	 * // 저장된 목록 가져오기
	 * 
	 * List<MypageVO> savedList = mypageService.getSavedList(m_idx);
	 * model.addAttribute("savedList", savedList); System.out.println("저장된 목록: " +
	 * savedList);
	 * 
	 * return "MyPage/m_savedList"; }
	 */
	
//		@RequestMapping("/m_savedList")
//	    public String getSavedList(HttpSession session, Model model) {
//	        // 세션에서 로그인된 사용자의 m_idx를 가져옴
//	        int m_idx = (Integer) session.getAttribute("m_idx");
//	        
//	        
//	        
//	        // 서비스 호출하여 저장된 목록을 가져옴
//	        List<MypageVO> savedList = mypageService.getSavedList(m_idx);
//	        
//	        // JSP로 데이터 전달
//	        model.addAttribute("savedList", savedList);
//	        
//	        return "MyPage/m_savedList"; // m_savedList.jsp로 이동
//	    }
	}
