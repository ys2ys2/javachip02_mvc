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

	/*
	 * // 내 여행기 페이지로 이동
	 * 
	 * @GetMapping("/m_myJourneys") public String myJourneys() { return
	 * "MyPage/m_myJourneys"; }
	 */
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
	

     //게시글 불러오기
	@RequestMapping("/m_myJourneys")  // "/m_myJourneys"라는 URL 경로로 클라이언트가 요청을 보낼 때 이 메서드가 실행됨
	public String getSavedPostList(HttpSession session, Model model) {
	    // 세션에서 M_MemberVO 객체 가져오기
	    // 로그인 시 세션에 저장된 회원 정보를 가져옴. "member"는 로그인 시 세션에 저장된 M_MemberVO 객체의 키 값임
	    M_MemberVO member = (M_MemberVO) session.getAttribute("member"); // 로그인할 때 저장된 vo를 session에서 가져오기
	    
	    // 만약 세션에 "member" 객체가 없다면, 즉 사용자가 로그인하지 않았을 경우
	    if (member == null) {
	    	 System.out.println("세션에서 member를 찾을 수 없습니다.");
	        // 로그인 페이지로 리다이렉트 함. 이는 로그인되지 않은 사용자가 접근할 수 없도록 하기 위함
	        return "redirect:/Member/login";  // 로그인 정보가 없으면 로그인 페이지로 리다이렉트
	    }

	    // 세션에서 가져온 M_MemberVO 객체에서 회원의 고유 식별자 m_idx를 가져옴
	    // m_idx는 데이터베이스에서 회원을 식별하는 중요한 키 값임
	    int m_idx = member.getM_idx();  // 로그인된 사용자의 m_idx 값을 가져옴
	    System.out.println("로그인된 사용자 m_idx: " + m_idx);  // 콘솔에 m_idx 값을 출력하여 디버깅에 사용

	    // mypageService를 통해 저장된 목록과 post 테이블과 조인된 데이터를 가져옴
	    // mypageService.getSavedPostList(m_idx)는 m_idx에 해당하는 사용자의 저장된 목록과 게시글을 불러오는 로직임
	    List<MypageVO> savedPostList = mypageService.getSavedPostList(m_idx); // m_idx로 조인된 데이터를 가져오는 메서드 호출
	    
	    // model 객체에 "savedList"라는 이름으로 가져온 데이터를 추가함
	    // 이 데이터는 View(JSP)에서 사용되어 화면에 표시됨
	    model.addAttribute("savedPostList", savedPostList);  // 모델에 저장된 목록 데이터를 추가

	    // MyPage 폴더 내에 있는 m_myJourneys.jsp 파일을 반환하여, 클라이언트에게 해당 페이지를 보여줌
	    // 이 페이지에서 model에 저장된 savedList 데이터를 활용해 UI에 표시할 수 있음
	    return "MyPage/m_myJourneys";  // MyPage 폴더 내의 m_myJourneys.jsp로 이동
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
