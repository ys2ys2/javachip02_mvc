package com.human.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.human.web.service.HotPlaceService;
import com.human.web.vo.M_MemberVO;

@Controller
public class HotPlaceController {
	
	@Autowired
	private HotPlaceService hotplaceService;
	
    // 저장 누르면 mypage 테이블에 저장
	@PostMapping("/hotplace/save")
	public String saveHotplaceToMypage(@RequestParam("contentid") String contentid, HttpSession session) {
		// 세션에서 로그인한 사용자 정보 가져오기
		M_MemberVO member = (M_MemberVO) session.getAttribute("member");

		// 세션에 저장된 사용자 정보가 null인지 확인
		if (member == null) {
			System.out.println("로그인된 사용자가 없습니다.");
			return "redirect:/Member/login";  // 로그인되지 않은 경우 리다이렉트
		}

		// 로그인한 사용자 정보 출력
		int m_idx = member.getM_idx(); // 로그인한 사용자 m_idx

		
		// MyPage 테이블에 contentid와 m_idx 저장
		hotplaceService.saveHotplace(m_idx, contentid);
		
		// 저장 후 마이페이지로 리다이렉트
		return "redirect:/MyPage/myPageMain";
	}
}
