package com.human.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.human.web.service.M_MemberService;
import com.human.web.vo.M_MemberVO;

@Controller
public class M_MemberController {

    @Autowired
    private M_MemberService memberService;

    // 회원가입 페이지
    @GetMapping("/member/join")
    public String showJoinForm() {
        return "member/join"; // 회원가입 폼으로 이동
    }

    // 회원가입 처리
    @PostMapping("/member/join")
    public String processJoin(M_MemberVO memberVO, Model model) {
        int result = memberService.insertMember(memberVO);
        if (result > 0) {
            model.addAttribute("message", "회원가입에 성공했습니다.");
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        } else {
            model.addAttribute("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
            return "member/join";
        }
    }

    // 아이디 중복 검사
    @GetMapping("/member/checkId")
    public String checkId(@RequestParam("memberId") String memberId, Model model) {
        int count = memberService.checkId(memberId);
        model.addAttribute("isAvailable", count == 0);
        return "member/checkId";
    }
}
