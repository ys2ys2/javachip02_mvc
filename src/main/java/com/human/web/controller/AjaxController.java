package com.human.web.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.human.web.service.M_MemberService;
import com.human.web.vo.M_MemberVO;

import lombok.RequiredArgsConstructor;

@RestController // @Controller + @ResponseBody
@RequiredArgsConstructor
public class AjaxController {

	// 필드 정의
	private final M_MemberService m_memberServiceImpl;

	// 아이디 중복검사
	@PostMapping("/Member/checkId")
	public String checkId(@RequestParam("m_email") String m_email) {
		String result = "PASS"; // 중복된 아이디가 없는 경우 기본값

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

	// 닉네임 중복 체크
	@PostMapping("/Member/checkNickname")
	public String checkNickname(@RequestParam("m_nickname") String m_nickname) {
		String result = "PASS";

		try {
			if (m_memberServiceImpl.checkNickname(m_nickname) >= 1) {
				result = "FAIL";
			}
		} catch (Exception e) {
			System.out.println("닉네임 중복 검사 중 오류 발생: " + e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

	// 프로필 업데이트 처리
	@PostMapping("/Member/updateProfile")
	@ResponseBody
	public String updateProfile(@RequestParam("nickname") String nickname,
			@RequestParam("profileImage") MultipartFile profileImage,
			HttpSession session) {
		M_MemberVO member = (M_MemberVO) session.getAttribute("member");

		// 프로필 이미지 저장 로직
		if (!profileImage.isEmpty()) {
			String savedPath = saveProfileImage(profileImage);
			member.setM_profile(savedPath);
		}

		// 닉네임 및 생년월일 업데이트
		member.setM_nickname(nickname);

		// 업데이트 수행
		boolean isUpdated = m_memberServiceImpl.updateMemberProfile(member);

		return isUpdated ? "success" : "fail";
	}

	private String saveProfileImage(MultipartFile profileImage) {
		String uploadDir = "C:/uploads/";
		String fileName = UUID.randomUUID().toString() + "_" + profileImage.getOriginalFilename();
		Path filePath = Paths.get(uploadDir + fileName);
		try {
			Files.write(filePath, profileImage.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return fileName;
	}

}
