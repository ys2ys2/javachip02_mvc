package com.human.web.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
/*
import com.human.web.service.DaejeonEventApiService;
import com.human.web.service.DaejeonMatzipApiService;*/
import com.human.web.service.EventsService;
import com.human.web.service.SeMatzipCommentsService;
/*import com.human.web.service.SeoulEventApiService;
import com.human.web.service.SeoulMatzipApiService;*/
import com.human.web.vo.DaejeonEventApiVO.Item;
import com.human.web.vo.DaejeonMatzipApiVO.Damat;
import com.human.web.vo.EventsCommentsVO;
import com.human.web.vo.SeoulEventApiVO;
import com.human.web.vo.SeoulMatzipApiVO;
import com.human.web.vo.SeoulMatzipCommentsVO;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class HomeController {
	
	/*
	 * // 필드 정의 - 주입받을 서비스에 final 추가 private SeoulEventApiService
	 * seoulEventApiServiceImpl; private SeoulMatzipApiService
	 * seoulMatzipApiServiceImpl; private EventsService eventsServiceImpl ; private
	 * SeMatzipCommentsService seMatzipCommentsService; private
	 * DaejeonEventApiService daejeonEventApiServiceImpl; private
	 * DaejeonMatzipApiService daejeonMatzipApiServiceImpl;
	 * 
	 */
	// 메인페이지
	@GetMapping("/")
	public String home() {
		return "redirect:/HomePage/mainpage";
	}
	@GetMapping("/index.do")
	public String index() {
		return "HomePage/mainpage";
	}
	
	// 403에러
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

	// 영준 여행기 작성 페이지
	@GetMapping("/Community/c_board/travelWrite")
	public String showTravelWritePage() {
		return "Community/c_board/travelWrite";
	}

	// 영준 커뮤니티 메인
	@GetMapping("/Community/c_main")
	public String c_main() {
		return "Community/c_main";
	}


	// 여행일정작성 페이지
	@GetMapping("/TripSched/tripSched")
	public String tripSched() {
		return "TripSched/tripSched";
	}

	
	// 여행일정작성 페이지
    @GetMapping("/TripSchedule/TripSchedule")
    public String tripSchedule() {
        return "TripSchedule/TripSchedule";
    }
    
	// 여행일정 리스트 페이지
	@GetMapping("/TripSchedule/List")
	public String TripScheduleList() {
	    return "TripSchedule/TripList";
	}
	    
	    
	// 여행일정 상세 페이지
	@GetMapping("TripSchedule/TripDetail")
	public String TripDetail() {
	    return "TripSchedule/TripPage";
	}
	
	
	// 여행뽈볼 페이지
	@GetMapping("/TravelSpot/TravelSpot")
	public String TravelSpot() {
	    return "TravelSpot/TravelSpot";
	}
	
	//자주묻는 질문
	@GetMapping("/HomePage/FAQ")
	public String FAQ() {
		return "HomePage/FAQ";
	}
	
	/*
	 * ////////////////////////////////// 희진
	 * /////////////////////////////////////////////////////
	 * 
	 * //축제 페이지
	 * 
	 * @GetMapping("/Festival/Event") public String Event(Model model) { String
	 * viewName = "/RecoSpot/travel_Seoul";//입력 실패시 뷰이름 //서울 공공 데이터를 가져와서 Model에
	 * 저장하기 //int result = seoulEventApiServiceImpl.insertSeoul();
	 * 
	 * //if(result==1) { //System.out.println("서울 공공 데이터가 정상적으로 입력되었습니다."); //행사 목록
	 * 가져오기 List<SeoulEventApiVO.Row> events =
	 * seoulEventApiServiceImpl.getAllEvents();
	 * 
	 * //댓글 목록 가져오기 List<EventsCommentsVO> commentsList =
	 * eventsServiceImpl.getAllComments();
	 * 
	 * if(events.size() > 0) { //행사 목록 저장하기 model.addAttribute("events", events);
	 * //댓글 목록 저장하기 model.addAttribute("commentsList", commentsList);
	 * 
	 * viewName = "Festival/Event";//입력 성공시 뷰이름 } //}
	 * 
	 * return viewName; }
	 * 
	 * // 맛집 API
	 * 
	 * @GetMapping("/Matzip/seoulFamous") public String Famous(Model model) { String
	 * viewName = "/RecoSpot/travel_Seoul";//입력 실패시 뷰이름 //서울 공공 데이터를 가져와서 Model에
	 * 저장하기 //int result = seoulMatzipApiServiceImpl.insertSeoul();
	 * 
	 * //if(result==1) { //System.out.println("서울 공공 데이터가 정상적으로 입력되었습니다."); //DB에
	 * 저장된 데이터를 가져와서 Model객체에 저장하기 //맛집 목록 가져오기 List<SeoulMatzipApiVO.Row> matzips =
	 * seoulMatzipApiServiceImpl.getAllSeoulMatzip();
	 * 
	 * //댓글 목록 가져오기 List<SeoulMatzipCommentsVO> commentsList =
	 * seMatzipCommentsService.getAllComments();
	 * 
	 * 
	 * if(matzips.size() > 0) { //맛집 목록 저장 하기 model.addAttribute("matzips",
	 * matzips); //댓글 목록 저장하기 model.addAttribute("commentsList", commentsList);
	 * 
	 * 
	 * viewName = "Matzip/seoulFamous";//입력 성공시 뷰이름 } //}
	 * 
	 * return viewName; }
	 * 
	 * //희진 행사 대전 페이지
	 * 
	 * @GetMapping("/Festival/DaejeonEvent") public String DaejeonEvent(Model model)
	 * { String viewName = "/RecoSpot/travel_Seoul";//입력 실패시 뷰이름
	 * 
	 * // 데이터를 가져와서 Model에 저장하기 //int result =
	 * daejeonEventApiServiceImpl.insertDaejeonEvent();
	 * 
	 * //if(result==1) { //System.out.println("대전 공공 데이터가 정상적으로 입력되었습니다."); //DB에
	 * 저장된 데이터를 가져와서 Model객체에 저장하기 //축제 목록 가져오기 List<Item> daeEventList =
	 * daejeonEventApiServiceImpl.getAllDaejeonEvent();
	 * 
	 * //댓글 목록 가져오기 //List<SeoulMatzipCommentsVO> commentsList =
	 * seMatzipCommentsService.getAllComments();
	 * 
	 * if(daeEventList.size() > 0) { //대전 행사 목록 저장 하기
	 * model.addAttribute("daeEventList", daeEventList); //댓글 목록 저장하기
	 * //model.addAttribute("commentsList", commentsList);
	 * 
	 * 
	 * viewName = "Festival/DaejeonEventApi";//입력 성공시 뷰이름 } // }
	 * 
	 * return viewName; }
	 * 
	 * //희진 맛집 대전 페이지
	 * 
	 * @GetMapping("/Matzip/daejeonFamous") public String daejeonFamous(Model model)
	 * { String viewName = "/RecoSpot/travel_Seoul";//입력 실패시 뷰이름
	 * 
	 * // 데이터를 가져와서 Model에 저장하기 //int result =
	 * daejeonMatzipApiServiceImpl.insertDaejeonMatzip();
	 * 
	 * //if(result==1) { //System.out.println("대전 공공 데이터가 정상적으로 입력되었습니다."); //DB에
	 * 저장된 데이터를 가져와서 Model객체에 저장하기 //축제 목록 가져오기 List<Damat> daeDamatList =
	 * daejeonMatzipApiServiceImpl.getAllDaejeonMatzip();
	 * 
	 * //댓글 목록 가져오기 //List<SeoulMatzipCommentsVO> commentsList =
	 * seMatzipCommentsService.getAllComments();
	 * 
	 * if(daeDamatList.size() > 0) { //대전 행사 목록 저장 하기
	 * model.addAttribute("daeDamatList", daeDamatList); //댓글 목록 저장하기
	 * //model.addAttribute("commentsList", commentsList);
	 * 
	 * viewName = "Matzip/daejeonFamous";
	 * 
	 * }
	 * 
	 * //} return viewName; }
	 */
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
