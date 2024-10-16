package com.human.web.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.human.web.service.MypageService;
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
	@GetMapping("/m_savedList") 
	public String savedList() { 
		return "MyPage/m_savedList"; 
	}

	// 댓글 관리 페이지로 이동
	@GetMapping("/m_commentManagement") 
	public String m_commentManagement() { 
		return "MyPage/m_commentManagement"; 
	}

	/*
	 * // 프로필 수정 페이지로 이동
	 * 
	 * @GetMapping("/m_updateProfile") public String m_updateProfile(HttpSession
	 * session, Model model) { M_MemberVO member = (M_MemberVO)
	 * session.getAttribute("member");
	 * 
	 * if (member == null) { model.addAttribute("msg", "로그인이 필요합니다."); return
	 * "member/login"; // 로그인 필요 메시지 출력 }
	 * 
	 * model.addAttribute("member", member); // JSP에서 사용하기 위해 세션 정보 전달 return
	 * "MyPage/m_updateProfile"; }
	 */
	@Autowired
	private MypageService mypageService;

	@GetMapping("/myPageMain")
	public String showMypage(Model model) {
		System.out.println("MypageController - showMypage 호출됨");  // 디버깅
		List<MypageVO> mypageList = mypageService.getMypageList();
		model.addAttribute("m_mypageList", mypageList);
		return "MyPage/myPageMain";
	}

	/*
	 * // 회원정보 변경 처리 요청
	 * 
	 * @PostMapping("/updateProcess") public String updateProcess(M_MemberVO vo,
	 * HttpServletRequest request, Model model) {
	 * System.out.println("MypageController - updateProcess 호출됨"); // 디버깅 String
	 * viewName = "MyPage/m_updateProfile"; // 실패 시 기본 뷰
	 * 
	 * M_MemberVO newVo = m_memberServiceImpl.updateMember(vo);
	 * 
	 * if (newVo != null) { HttpSession session = request.getSession();
	 * session.removeAttribute("member"); session.setAttribute("member", newVo);
	 * System.out.println("회원정보 변경 성공"); // 디버깅 viewName =
	 * "redirect:/MyPage/myPageMain"; // 성공 시 리다이렉트 } else {
	 * System.out.println("회원정보 변경 실패"); // 디버깅 model.addAttribute("msg",
	 * "회원정보 변경 중 오류가 발생했습니다."); }
	 * 
	 * return viewName; }
	 * 
	 * // 회원탈퇴 처리
	 * 
	 * @GetMapping("/cancelProcess") public String cancelProcess(HttpServletRequest
	 * request, Model model) { HttpSession session = request.getSession();
	 * M_MemberVO vo = (M_MemberVO) session.getAttribute("member");
	 * 
	 * if (vo == null) { model.addAttribute("msg", "로그인이 필요합니다."); return
	 * "member/login"; // 로그인 필요 메시지 }
	 * 
	 * int m_idx = vo.getM_idx(); int result = m_memberServiceImpl.cancel(m_idx);
	 * 
	 * String viewName = "member/update"; // 실패 시 기본 뷰
	 * 
	 * if (result == 1) { session.invalidate(); // 세션 초기화 viewName =
	 * "redirect:/index.do"; } else { model.addAttribute("msg",
	 * "회원탈퇴 중 오류가 발생했습니다."); }
	 * 
	 * return viewName; }
	 */
}
