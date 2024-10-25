package com.human.web.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomeController {

	// 메인페이지
	@GetMapping("/")
	public String home() {
	    return "redirect:/HomePage/mainpage";
	}

	// 403에러

	@GetMapping("/index.do")
	public String index() {
		return "HomePage/mainpage";
	}

	@GetMapping("/error/errorPage")
	public String errorPage() {
		return "error/errorPage";
	}

	@GetMapping("/error/error403.do")
	public String error403() {
		return "error/error403";
	}

	// 404에러
	@GetMapping("/error/error404.do")
	public String error404() {
		return "error/error404";
	}

	// 405에러
	@GetMapping("/error/error405.do")
	public String error405() {
		return "error/error405";
	}

	// 500에러
	@GetMapping("/error/error500.do")
	public String error500() {
		return "error/error500";
	}

	// 영신 회사소개 페이지
	@GetMapping("/FooterPage/introduce")
	public String introduce() {
		return "FooterPage/introduce";
	}

	// 영신 이용약관 페이지
	@GetMapping("/FooterPage/clause")
	public String clause() {
		return "FooterPage/clause";
	}

	// 영신 개인정보 수집,동의 페이지
	@GetMapping("/FooterPage/privacy")
	public String privacy() {
		return "FooterPage/privacy";
	}

	// 영신 개인정보 3자동의 페이지
	@GetMapping("/FooterPage/thirdparty")
	public String thirdparty() {
		return "FooterPage/thirdparty";
	}

	// 영신 광고성 정보 수신동의 페이지
	@GetMapping("/FooterPage/marketing")
	public String marketing() {
		return "FooterPage/marketing";
	}

	// 예슬 로그인 페이지
	@GetMapping("/Login/login")
	public String login() {
		return "Login/login";
	}

	// 예슬 로그인Process = PostMapping → login.jsp에서 <form method="post">로 쓰고 있음
	@PostMapping("/Login/loginProcess")
	public String loginProcess() {
		return "Login/loginProcess";
	}

	// 영준 여행기 작성 페이지
	@GetMapping("/Community/c_board/travelWrite")
	public String showTravelWritePage() {
		return "Community/c_board/travelWrite";
	}

	// 영준 여행기 작성 저장 페이지
	@PostMapping("/Community/c_board/savetravelWrite")
	public String saveTravelPost(
			@RequestParam("topic") String topic,
			@RequestParam("title") String title,
			@RequestParam("content") String content,
			@RequestParam("tags") String tags,
			@RequestParam("imageUpload") MultipartFile imageUpload,
			RedirectAttributes redirectAttributes) {

		// 이미지 파일 저장 처리
		if (!imageUpload.isEmpty()) {
			try {
				// 이미지 파일 저장 경로 설정
				String uploadDir = "C:/team_dev/uploads/"; // 실제 경로에 맞게 수정
				File uploadDirFile = new File(uploadDir);
				if (!uploadDirFile.exists()) {
					uploadDirFile.mkdirs(); // 디렉토리가 없으면 생성
				}

				// 파일 저장
				String filePath = uploadDir + imageUpload.getOriginalFilename();
				File file = new File(filePath);
				imageUpload.transferTo(file); // 파일을 해당 경로에 저장

			} catch (IOException e) {
				e.printStackTrace();
				redirectAttributes.addFlashAttribute("message", "파일 업로드 중 오류가 발생했습니다.");
				return "redirect:/Community/c_board/travelWrite";
			}
		}

		// 폼 데이터 처리 후 리다이렉트
		redirectAttributes.addFlashAttribute("message", "여행기가 성공적으로 작성되었습니다.");
		return "redirect:/Community/c_board/travelWrite";
	}

	// 영준 커뮤니티 메인
	@GetMapping("/Community/c_main/c_main")
	public String c_main() {
		return "Community/c_main/c_main";
	}

	// 희진 축제페이지
	@GetMapping("/Festival/Event")
	public String Event() {
		return "Festival/Event";
	}

	// 희진 맛집페이지
	@GetMapping("/Matzip/famous")
	public String famous() {
		return "Matzip/famous";
	}

	// 희진 Festival_Daejeon
	@GetMapping("/RecoSpot/Festival_Daejeon")
	public String Festival_Daejeon() {
		return "RecoSpot/Festival_Daejeon";
	}

	// 희진 Festival_Incheon
	@GetMapping("/RecoSpot/Festival_Incheon")
	public String Festival_Incheon() {
		return "RecoSpot/Festival_Incheon";
	}

	// 희진 Festival_Seoul
	@GetMapping("/RecoSpot/Festival_Seoul")
	public String Festival_Seoul() {
		return "RecoSpot/Festival_Seoul";
	}

	// 희진 journal_Daejeon
	@GetMapping("/RecoSpot/journal_Daejeon")
	public String journal_Daejeon() {
		return "RecoSpot/journal_Daejeon";
	}

	// 희진 journal_Incheon
	@GetMapping("/RecoSpot/journal_Incheon")
	public String journal_Incheon() {
		return "RecoSpot/journal_Incheon";
	}

	// 희진 travel_Daejeon
	@GetMapping("/RecoSpot/travel_Daejeon")
	public String travel_Daejeon() {
		return "RecoSpot/travel_Daejeon";
	}

	// 희진 travel_Incheon
	@GetMapping("/RecoSpot/travel_Incheon")
	public String travel_Incheon() {
		return "RecoSpot/travel_Incheon";
	}

	// 희진 travel_Seoul
	@GetMapping("/RecoSpot/travel_Seoul")
	public String travel_Seoul() {
		return "RecoSpot/travel_Seoul";
	}
	
	// 여행일정 페이지
	@GetMapping("/TripSched/tripSched")
	public String tripSched() {
		return "TripSched/tripSched";
	}

}
