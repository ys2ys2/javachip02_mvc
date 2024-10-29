package com.human.web.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.human.web.service.M_MemberService;
import com.human.web.vo.M_MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/Member") // 공통으로 적용되는 URL 정의
// lombok을 적용해서 생성자를 이용한 의존 자동주입
@RequiredArgsConstructor
public class M_MemberController {

	private final M_MemberService m_memberServiceImpl;

	// 회원가입 페이지
	@GetMapping("/joinmain")
	public String joinmain() {
		return "Member/joinmain"; // 회원가입 폼으로 이동
	}

	// 이메일 회원가입 페이지
	@GetMapping("/join")
	public String join() {
		return "Member/join"; // 회원가입 폼으로 이동
	}

	// 프로필 변경
	@GetMapping("/m_updateProfile")
	public String m_updateProfile() {
		return "Member/m_updateProfile"; // 프로필 변경
	}

	// 회원정보찾기
	@GetMapping("/m_findId")
	public String m_findId() {
		return "Member/m_findId"; // 회원정보찾기
	}

	// 회원가입 처리 요청
	@PostMapping("/joinProcess")
	public String joinProcess(@ModelAttribute M_MemberVO memberVO, Model model) {
		// 회원가입 결과를 처리할 뷰 이름 초기화
		String viewName = "Member/join"; // 회원가입 실패 시 반환할 뷰

		// MemberServiceImpl 클래스를 통해 회원가입 요청 처리
		int result = m_memberServiceImpl.insertM_Member(memberVO);
		System.out.println("insertM_Member 반환값: " + result); // 반환값 확인

		// 회원가입 성공 여부 확인 (m_idx가 0보다 크면 성공)
		if (result > 0) {
			viewName = "redirect:/"; // 성공 시 메인 페이지로 리다이렉트
		} else {
			// 회원가입 실패 시 오류 메시지를 모델에 저장
			model.addAttribute("msg", "회원가입이 정상적으로 이루어지지 않았습니다.");
		}
		// 회원가입 성공 여부 확인 (m_idx가 0보다 크면 성공)
		if (result > 0) {
			viewName = "redirect:/"; // 성공 시 메인 페이지로 리다이렉트
		} else {
			// 회원가입 실패 시 오류 메시지를 모델에 저장
			model.addAttribute("msg", "회원가입이 정상적으로 이루어지지 않았습니다.");
		}

		return viewName; // 처리된 뷰 이름 반환
	}

	// 로그인 페이지 요청
	@GetMapping("/login")
	public String login() {
		return "Member/login";
	}

	// 로그인 처리 요청
	@PostMapping("/loginProcess")
	public String loginProcess(String m_email, String m_password,
			HttpServletRequest request, Model model) {

		// 로그로 로그인 시도 정보 출력
		System.out.println("로그인 요청이 들어왔습니다: " + m_email);

		// 로그인 실패시 보여줄 뷰 이름을 미리 설정
		String viewName = "Member/login";

		// 이메일과 비밀번호를 사용해 로그인 시도
		M_MemberVO vo = m_memberServiceImpl.login(m_email, m_password);

		// 로그인 성공 여부 판단 (vo가 null이 아닐 경우 성공)
		if (vo != null) {
			
			if("deleted".equals(vo.getM_status())) {
				//탈퇴한 회원인 경우 로그인 실패 처리
				model.addAttribute("msg_del", "탈퇴한 회원입니다. 다시 가입해주세요.");
			}else {
				//탈퇴하지 않은 회원인 경우 로그인 성공 처리
				// 세션 객체를 가져와서 세션에 회원 정보를 저장
				HttpSession session = request.getSession();
				session.setAttribute("member", vo);
			
			// 세션에 회원 정보가 제대로 저장되었는지 확인하기 위한 로그 추가
			M_MemberVO sessionMember = (M_MemberVO) session.getAttribute("member");
			if (sessionMember != null) {
				System.out.println("세션에 저장된 회원 정보: " + sessionMember);
				System.out.println("닉네임: " + sessionMember.getM_nickname());
				System.out.println("m_idx: " + sessionMember.getM_idx());
				System.out.println("프로필 이미지 경로: " + sessionMember.getM_profile()); // 프로필 이미지 확인
			} else {
				System.out.println("세션에 저장된 회원 정보가 없습니다.");
			}

			// 로그인 성공 시 메인 페이지로 리다이렉트
			viewName = "redirect:/HomePage/mainpage";
			}
			
			}else {
			// 로그인 실패 시 메시지와 함께 다시 로그인 페이지로 이동
			model.addAttribute("msg", "아이디나 비밀번호가 일치하지 않습니다.");
		}

		// 로그인 결과에 따라 뷰 반환
		return viewName;
	}

	// 로그아웃 요청
	@PostMapping("/logout")
	public String logout(HttpServletRequest request) {
		// 세션객체를 초기화 시킴(request객체의 getSession()메소드 이용해서 세션객체 얻음)
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		return "redirect:/";
	}

	// 회원정보 변경
	@PostMapping("/updateProcess")
	public String updateProcess(
			M_MemberVO vo,
			@RequestParam("profileImage") MultipartFile profileImage, // 프로필 이미지 파일 받기
			HttpServletRequest request,
			Model model) {

		String viewName = "Member/m_updateProfile"; // 회원정보 변경 실패 시 반환할 뷰 이름

		// 세션에서 기존 회원 정보를 가져옴 (기존 닉네임과 비교를 위해)
		HttpSession session = request.getSession();
		M_MemberVO sessionMember = (M_MemberVO) session.getAttribute("member");

		// 1. 닉네임이 변경되었는지 확인
		if (!vo.getM_nickname().equals(sessionMember.getM_nickname())) {
			// 닉네임이 변경되었을 경우에만 중복 체크 수행
			int nicknameCount = m_memberServiceImpl.checkNickname(vo.getM_nickname());
			if (nicknameCount > 0) {
				model.addAttribute("nicknameError", "닉네임이 중복되었습니다. 다른 닉네임을 사용해 주세요.");
				return viewName;
			}
		}

		// 2. 비밀번호 확인 값 가져오기
		String confirmPassword = request.getParameter("confirmPassword"); // JSP의 confirmPassword 필드값을 가져옴

		// 3. 비밀번호가 입력되지 않은 경우 처리: 비밀번호를 변경하지 않고 기존 비밀번호 유지
		if ((vo.getM_password() == null || vo.getM_password().isEmpty()) &&
				(confirmPassword == null || confirmPassword.isEmpty())) {
			// 비밀번호가 공란이면 기존 비밀번호 유지
			vo.setM_password(sessionMember.getM_password()); // 세션에서 기존 비밀번호를 유지
		} else {
			// 3.1. 비밀번호 일치 확인
			if (!vo.getM_password().equals(confirmPassword)) {
				model.addAttribute("passwordError", "비밀번호와 비밀번호 확인이 일치하지 않습니다.");
				return viewName;
			}

			// 3.2. 비밀번호 유효성 검사
			if (!m_memberServiceImpl.isValidPassword(vo.getM_password())) {
				model.addAttribute("passwordValidationError", "비밀번호는 최소 8자 이상이어야 하며, 숫자와 특수문자를 포함해야 합니다.");
				return viewName;
			}

		}
		// 4. 프로필 이미지 처리
		if (profileImage != null && !profileImage.isEmpty()) {
			System.out.println("Uploaded File Name: " + profileImage.getOriginalFilename());

			// 웹 접근 경로
			String webPath = "/resources/images";
			// 실제 이미지 파일이 저장되어야 하는 서버 컴퓨터 경로
			String filePath = session.getServletContext().getRealPath(webPath);
			// String filePath = "C:/Users/admin/Downloads";
			System.out.println("Actual File Path: " + filePath); // 실제 경로 확인
			// 파일 저장 경로 설정
			String fileName = profileImage.getOriginalFilename();
			try {
				File saveFile = new File(filePath, fileName);
				profileImage.transferTo(saveFile); // 파일 저장
				vo.setM_profile(webPath + "/" + fileName); // 이미지 경로 설정
				System.out.println("Profile Image Path: " + vo.getM_profile()); // 경로 로그 확인

				// DB 업데이트 시도
				M_MemberVO updatedMember = m_memberServiceImpl.updateProfileImage(vo);
				if (updatedMember != null) {
					System.out.println("DB 업데이트 성공: " + updatedMember.getM_profile());
				} else {
					System.out.println("DB 업데이트 실패");
				}

			} catch (IOException e) {
				e.printStackTrace();
				model.addAttribute("fileError", "파일 업로드 중 오류가 발생했습니다.");
				return viewName;
			}
		}

		// 5. 회원 정보 업데이트 요청
		M_MemberVO newVo = m_memberServiceImpl.updateMember(vo);

		// 6. 회원 정보 변경 성공 여부 판단
		if (newVo != null) {
			// 회원정보 변경 성공
			session.removeAttribute("member");
			session.setAttribute("member", newVo);
			viewName = "redirect:/MyPage/myPageMain"; // 성공 시 메인 페이지로 리다이렉트
		} else {
			model.addAttribute("generalError", "회원정보 변경 중 오류가 발생했습니다. 변경 내용을 확인해 주세요.");
		}

		return viewName;
	}

	// 회원탈퇴 요청
	@GetMapping("/cancelProcess")
	public String cancelProcess(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		M_MemberVO vo = (M_MemberVO) session.getAttribute("member");
		int m_idx = vo.getM_idx();

		int result = m_memberServiceImpl.cancel(m_idx);

		String viewName = "member/update";// 회원탈퇴 실패시 뷰이름

		if (result == 1) {// 회원탈퇴 성공
			session.invalidate();// 세션 초기화
			viewName = "redirect:/";

		} else {// 회원탈퇴 실패
			String msg = "시스템에 오류가 발생했습니다. 빠른 시일 내에 시스템을 정상화하도록 하겠습니다.";
			model.addAttribute("msg", msg);
		}

		return viewName;
	}

	// 회원정보 찾기
	@PostMapping("/findIdProcess")
	public String findIdProcess(@RequestParam("m_registration_type") String registrationType,
			@RequestParam("m_nickname") String nickname,

			Model model) {

		// 서비스 호출하여 아이디 찾기
		String foundId = m_memberServiceImpl.findIdByRegistrationAndNickname(registrationType, nickname);

		// 찾은 아이디를 JSP 페이지에 전달
		if (foundId != null) {
			model.addAttribute("foundId", foundId);
		} else {
			model.addAttribute("errorMessage", "해당 정보로 등록된 아이디가 없습니다.");
		}

		// 아이디 찾기 결과 페이지로 이동
		return "/Member/m_findId";
	}

	// 회원정보 찾기에서 비밀번호 재설정
	@PostMapping("/resetPassword")
	public String resetPassword(@RequestParam("newPassword") String newPassword,
			@RequestParam("confirmPassword") String confirmPassword,
			HttpSession session, RedirectAttributes redirectAttributes /*Model model*/) {

		// 세션에서 이메일 가져오기 전에 로그 출력
		System.out.println("세션에서 이메일 가져오기 시도...");

		// 세션에서 인증된 이메일 가져오기
		String m_email = (String) session.getAttribute("m_email");
		System.out.println("세션에 저장된 이메일: " + m_email);

		if (m_email == null) {
			  redirectAttributes.addFlashAttribute("errorMessage", "인증 정보가 만료되었습니다. 다시 시도해주세요");
//			model.addAttribute("errorMessage", "인증 정보가 만료되었습니다. 다시 시도해주세요");
			return "redirect:/Member/m_findId";
		}

		// 1. 비밀번호 일치 여부확인
		if (!newPassword.equals(confirmPassword)) {
			 redirectAttributes.addFlashAttribute("errorMessage", "비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		      return "redirect:/Member/m_findId";
			
			/*
			 * model.addAttribute("errorMessage", "비밀번호와 비밀번호 확인이 일치하지 않습니다."); return
			 * "Member/m_findId";
			 */
		}

		// 2. 비밀번호 유효성 검사
		if (!m_memberServiceImpl.isValidPassword(newPassword)) {
			
			 redirectAttributes.addFlashAttribute("passwordValidationError", "비밀번호는 최소 8자 이상이어야 하며 숫자와 특수문자를 포함해야 합니다.");
		        return "redirect:/Member/m_findId";
			/*
			 * model.addAttribute("passwordValidationError",
			 * "비밀번호는 최소 8자 이상이어야 하며 숫자와 특수문자를 포함해야 합니다."); return "Member/m_findId";
			 */
		}

		// 3. 비밀번호 업데이트 로직

		try {
			boolean isUpdated = m_memberServiceImpl.updatePassword(m_email, newPassword);

			if (isUpdated) {
				
				  redirectAttributes.addFlashAttribute("passwordResetSuccess", true);
		            return "redirect:/Member/m_findId";
				/*
				 * model.addAttribute("passwordResetSuccess", true); // 성공 여부 전달 return
				 * "Member/m_findId"; // 재설정 페이지로 돌아감
				 */			} else {
				
					 redirectAttributes.addFlashAttribute("errorMessage", "비밀번호 변경에 실패했습니다. 다시 시도해 주세요.");
			            return "redirect:/Member/m_findId";
					 /*
				 * model.addAttribute("errorMessage", "비밀번호 변경에 실패했습니다. 다시 시도해 주세요."); return
				 * "Member/m_findId"; // 업데이트 실패 시 재설정 페이지로 이동
				 */			}
		} catch (Exception e) {
			e.printStackTrace(); // 에러 로그 출력
			
			 redirectAttributes.addFlashAttribute("errorMessage", "비밀번호 변경 중 오류가 발생했습니다.");
		        return "redirect:/Member/m_findId";
			/*
			 * model.addAttribute("errorMessage", "비밀번호 변경 중 오류가 발생했습니다."); return
			 * "Member/m_findId"; // 예외 발생 시 비밀번호 재설정 페이지로 이동
			 */		}
	}

}
