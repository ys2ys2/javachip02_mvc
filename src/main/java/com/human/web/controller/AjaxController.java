package com.human.web.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.human.web.service.M_MemberService;

import lombok.RequiredArgsConstructor;

@RestController //@Controller + @ResponseBody
@RequiredArgsConstructor
public class AjaxController {
	
	//필드 정의
	private final M_MemberService m_memberServiceImpl;
	
	
	// 아이디 중복검사
    @PostMapping("/Member/checkId")
    public String checkId(@RequestParam("m_email") String m_email) {
        String result = "PASS";  // 중복된 아이디가 없는 경우 기본값

        try {
            if (m_memberServiceImpl.checkId(m_email) >= 1) {
                result = "FAIL";
            }
        } catch (Exception e) {
            System.out.println("아이디 중복 검사 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }

        return result;
    }

    @PostMapping("/Member/checkNickname")
    public String checkNickname(@RequestParam("m_nickname") String m_nickname) {
    	String result = "PASS";
    	
    	try {
			if(m_memberServiceImpl.checkNickname(m_nickname) >= 1) {
				result = "FAIL";
			}
		} catch (Exception e) {
			 System.out.println("닉네임 중복 검사 중 오류 발생: " + e.getMessage());
	            e.printStackTrace();
		}
    	return result;
    }
    
    
    
	
}
