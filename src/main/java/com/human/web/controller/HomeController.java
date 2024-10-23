package com.human.web.controller;


import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.human.web.service.EventsService;
import com.human.web.service.SeMatzipCommentsService;
import com.human.web.service.SeoulMatzipApiService;
import com.human.web.service.SeoulEventApiService;
import com.human.web.vo.EventsCommentsVO;
import com.human.web.vo.SeoulMatzipApiVO;
import com.human.web.vo.SeoulMatzipCommentsVO;
import com.human.web.vo.SeoulEventApiVO;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class HomeController {

    // 필드 정의 - 주입받을 서비스에 final 추가
    private SeoulEventApiService seoulEventApiServiceImpl;
    private SeoulMatzipApiService seoulMatzipApiServiceImpl;
    private EventsService eventsServiceImpl ;
    private SeMatzipCommentsService seMatzipCommentsService;

    // 프로젝트를 처음 실행시킬 때 요청 URL: /
    @GetMapping("/")
    public String home() {
        return "HomePage/mainpage"; // WEB-INF/views/HomePage/mainpage.jsp 페이지 실행
    }
	
	@GetMapping("/index.do")
	public String index() {
		return "HomePage/mainpage";//WEB-INF/views/HomePage/mainpage.jsp 페이지 실행
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
    

    //////////////////////////////////  희진  /////////////////////////////////////////////////////
    
 	
	@GetMapping("/Festival/Event")
	public String Event(Model model) {
		String viewName = "/RecoSpot/travel_Seoul";//입력 실패시 뷰이름
		//서울 공공 데이터를 가져와서 Model에 저장하기
		//int result = seoulEventApiServiceImpl.insertSeoul();
		
		//if(result==1) {
			//System.out.println("서울 공공 데이터가 정상적으로 입력되었습니다.");
			//행사 목록 가져오기
			List<SeoulEventApiVO.Row>  events = seoulEventApiServiceImpl.getAllEvents();
			
			//댓글 목록 가져오기
			List<EventsCommentsVO> commentsList = eventsServiceImpl.getAllComments();
			
			if(events.size() > 0) {
				//행사 목록 저장하기
				model.addAttribute("events", events);
				//댓글 목록 저장하기
				model.addAttribute("commentsList", commentsList);
				
				viewName = "Festival/Event";//입력 성공시 뷰이름
			}
		//}
		
	    return viewName;
	}
	
	// 맛집 API
	@GetMapping("/Matzip/seoulFamous")
	public String Famous(Model model) {
		String viewName = "/RecoSpot/travel_Seoul";//입력 실패시 뷰이름
		//서울 공공 데이터를 가져와서 Model에 저장하기
		//int result = seoulMatzipApiServiceImpl.insertSeoul();
		
		//if(result==1) {
			//System.out.println("서울 공공 데이터가 정상적으로 입력되었습니다.");
			//DB에 저장된 데이터를 가져와서 Model객체에 저장하기
			//맛집 목록 가져오기
			List<SeoulMatzipApiVO.Row>  matzips = seoulMatzipApiServiceImpl.getAllSeoulMatzip();
			
			//댓글 목록 가져오기
			List<SeoulMatzipCommentsVO> commentsList = seMatzipCommentsService.getAllCommentsMatzip();


			if(matzips.size() > 0) {
				//맛집 목록 저장 하기
				model.addAttribute("matzips", matzips);
				//댓글 목록 저장하기
				model.addAttribute("commentsList", commentsList);
				
				
				viewName = "Matzip/seoulFamous";//입력 성공시 뷰이름 
			}
	//}
		
	    return viewName;
	}
	
	//희진 행사 페이지
	


	//--------------- 여행지 --------------------

	//서울: travel_Seoul
	@GetMapping("/RecoSpot/travel_Seoul")
	public String travel_Seoul() {
		return "RecoSpot/travel_Seoul";
	}
	
	//인천: travel_Incheon
	@GetMapping("/RecoSpot/travel_Incheon")
	public String travel_Incheon() {
		return "RecoSpot/travel_Incheon";
	}
	
	//대전: travel_Daejeon
	@GetMapping("/RecoSpot/travel_Daejeon")
	public String travel_Daejeon() {
		return "RecoSpot/travel_Daejeon";
	}
	
	//--------------- 축제 --------------------
	
	//서울: Festival_Seoul
	@GetMapping("/RecoSpot/Festival_Seoul")
	public String Festival_Seoul() {
		return "RecoSpot/Festival_Seoul";
	}
	
	//인천: Festival_Incheon
	@GetMapping("/RecoSpot/Festival_Incheon")
	public String Festival_Incheon() {
		return "RecoSpot/Festival_Incheon";
	}
	
	//대전: Festival_Daejeon
	@GetMapping("/RecoSpot/Festival_Daejeon")
	public String Festival_Daejeon() {
		return "RecoSpot/Festival_Daejeon";
	}
	
	//--------------- journal --------------------
	
	//희진 journal_Seoul
	@GetMapping("/RecoSpot/journal_Seoul")
	public String journal_Seoul() {
		return "RecoSpot/journal_Seoul";
	}
	
	//인천: journal_Incheon
	@GetMapping("/RecoSpot/journal_Incheon")
	public String journal_Incheon() {
		return "RecoSpot/journal_Incheon";
	}

	//희진 journal_Daejeon
	@GetMapping("/RecoSpot/journal_Daejeon")
	public String journal_Daejeon() {
		return "RecoSpot/journal_Daejeon";
	}
	


	

}
