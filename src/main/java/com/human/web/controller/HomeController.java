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
	
	//기타 요청URL에 대한 처리 메소드
	@GetMapping("/")
	public String home() {
		return "HomePage/mainpage";
	}
	
	@GetMapping("/index.do")
	public String index() {
		return "HomePage/mainpage";
	}
	
	@GetMapping("/error/error403.do")
	public String error403() {
		return "error/error403";
	}
	
	@GetMapping("/error/error404.do")
	public String error404() {
		return "error/error404";
	}
	
	@GetMapping("/error/error405.do")
	public String error405() {
		return "error/error405";
	}
	
	@GetMapping("/error/error500.do")
	public String error500() {
		return "error/error500";
	}
	
	//영신 핫플1(api호출만 있는 페이지)
	@GetMapping("/HotPlace/hotplace")
	public String hotplace() {
	    return "HotPlace/hotplace";
	}
	
	//영신 핫플2(DB 저장되어있는 페이지)
	@GetMapping("/HotPlace/hotplace2")
	public String hotplace2() {
	    return "HotPlace/hotplace2";
	}
	
	//예슬 로그인 페이지
	@GetMapping("/Login/login")
	public String login() {
	    return "Login/login";
	}
	
	//예슬 로그인Process = PostMapping → login.jsp에서 <form method="post">로 쓰고 있음
	@PostMapping("/Login/loginProcess")
	public String loginProcess() {
	    return "Login/loginProcess"; 
	}


	//예슬 회원가입 페이지
	@GetMapping("/SignUp/join")
	public String join() {
		return "SignUp/join";
	}

	//예슬 회원가입 process = PostMapping
	@PostMapping("/SignUp/joinProcess")
	public String joinProcess() {
		return "SignUp/joinProcess";
	}
	
	//영준 여행기 작성 페이지
    @GetMapping("/Community/c_board/travelWrite")
    public String showTravelWritePage() {
        return "Community/c_board/travelWrite";
    }

    //영준 여행기 작성 저장 페이지
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
                String uploadDir = "C:/team_dev/uploads/";  // 실제 경로에 맞게 수정
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdirs(); // 디렉토리가 없으면 생성
                }

                // 파일 저장
                String filePath = uploadDir + imageUpload.getOriginalFilename();
                File file = new File(filePath);
                imageUpload.transferTo(file);  // 파일을 해당 경로에 저장

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
    
	//영준 커뮤니티 메인
    @GetMapping("/Community/c_main/c_main")
    public String c_main() {
        return "Community/c_main/c_main";
    }
    
    //희진 축제페이지
	@GetMapping("/Festival/Event")
	public String Event() {
	    return "Festival/Event";
	}
	
	//희진 맛집페이지
	@GetMapping("/Matzip/famous")
	public String famous() {
		return "Matzip/famous";
	}
	
	//희진 Festival_Daejeon
	@GetMapping("/RecoSpot/Festival_Daejeon")
	public String Festival_Daejeon() {
		return "RecoSpot/Festival_Daejeon";
	}
	
	//희진 Festival_Incheon
	@GetMapping("/RecoSpot/Festival_Incheon")
	public String Festival_Incheon() {
		return "RecoSpot/Festival_Incheon";
	}
	
	//희진 Festival_Seoul
	@GetMapping("/RecoSpot/Festival_Seoul")
	public String Festival_Seoul() {
		return "RecoSpot/Festival_Seoul";
	}
	
	//희진 journal_Daejeon
	@GetMapping("/RecoSpot/journal_Daejeon")
	public String journal_Daejeon() {
		return "RecoSpot/journal_Daejeon";
	}
	
	//희진 journal_Incheon
	@GetMapping("/RecoSpot/journal_Incheon")
	public String journal_Incheon() {
		return "RecoSpot/journal_Incheon";
	}
	
	//희진 travel_Daejeon
	@GetMapping("/RecoSpot/travel_Daejeon")
	public String travel_Daejeon() {
		return "RecoSpot/travel_Daejeon";
	}
	
	//희진 travel_Incheon
	@GetMapping("/RecoSpot/travel_Incheon")
	public String travel_Incheon() {
		return "RecoSpot/travel_Incheon";
	}
	
	//희진 travel_Seoul
	@GetMapping("/RecoSpot/travel_Seoul")
	public String travel_Seoul() {
		return "RecoSpot/travel_Seoul";
	}
	

}