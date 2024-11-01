package com.human.web.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.web.service.DaejeonEventApiService;
import com.human.web.service.DaejeonMatzipApiService;
import com.human.web.service.EventsService;
import com.human.web.service.MatzipService;
import com.human.web.service.SeMatzipCommentsService;
import com.human.web.service.SeoulEventApiService;
import com.human.web.service.SeoulMatzipApiService;
import com.human.web.service.TalkService;
import com.human.web.vo.DaejeonEventApiVO.Item;
import com.human.web.vo.DaejeonMatzipApiVO.Damat;
import com.human.web.vo.EventsCommentsVO;
import com.human.web.vo.MatzipVO;
import com.human.web.vo.SeoulEventApiVO;
import com.human.web.vo.SeoulMatzipApiVO;
import com.human.web.vo.SeoulMatzipCommentsVO;
import com.human.web.vo.TalkVO;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class HomeController {
	
	// 필드 정의 - 주입받을 서비스에 final 추가
    private SeoulEventApiService seoulEventApiServiceImpl;
    private SeoulMatzipApiService seoulMatzipApiServiceImpl;
    private EventsService eventsServiceImpl ;
    private SeMatzipCommentsService seMatzipCommentsService;
    private DaejeonEventApiService daejeonEventApiServiceImpl;
    private DaejeonMatzipApiService daejeonMatzipApiServiceImpl;

	// 메인페이지
	@GetMapping("/")
	public String home() {
		return "redirect:/HomePage/mainpage";
		
	}
	
	@GetMapping("/index.do")
	public String index() {
		return "redirect:/HomePage/mainpage";
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
	
	// 여행뽈뽈 페이지
	@GetMapping("/TravelSpot/TravelSpot")
	public String TravelSpot() {
	    return "TravelSpot/TravelSpot";
	}

	

	
    //////////////////////////////////  희진  /////////////////////////////////////////////////////
    
	//축제 페이지
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
		
		
		
		//축제 페이지
			@GetMapping("/Festival/Event2")
			public String Event2(Model model) {
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
						
						viewName = "Festival/Event2";//입력 성공시 뷰이름
					}
				//}
				
			    return viewName;
			}
		
			//축제 페이지
			@GetMapping("/Festival/Event3")
			public String Event3(Model model) {
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
						
						viewName = "Festival/Event3";//입력 성공시 뷰이름
					}
				//}
				
			    return viewName;
			}
		
		
			//축제 페이지
			@GetMapping("/Festival/Event4")
			public String Event4(Model model) {
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
						
						viewName = "Festival/Event4";//입력 성공시 뷰이름
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
			List<SeoulMatzipCommentsVO> commentsList = seMatzipCommentsService.getAllComments();


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
	
	//희진 행사 대전 페이지
    @GetMapping("/Festival/DaejeonEvent")
    public String DaejeonEvent(Model model) {
		String viewName = "/RecoSpot/travel_Seoul";//입력 실패시 뷰이름
		
		// 데이터를 가져와서 Model에 저장하기
		//int result = daejeonEventApiServiceImpl.insertDaejeonEvent();
		
		//if(result==1) {
			//System.out.println("대전 공공 데이터가 정상적으로 입력되었습니다.");
			//DB에 저장된 데이터를 가져와서 Model객체에 저장하기
			//축제 목록 가져오기	
			List<Item> daeEventList = daejeonEventApiServiceImpl.getAllDaejeonEvent();
			
			//댓글 목록 가져오기 
			//List<SeoulMatzipCommentsVO> commentsList = seMatzipCommentsService.getAllComments();

			if(daeEventList.size() > 0) {
				//대전 행사 목록 저장 하기
				model.addAttribute("daeEventList", daeEventList);
				//댓글 목록 저장하기
				//model.addAttribute("commentsList", commentsList);
				
				
				viewName = "Festival/DaejeonEventApi";//입력 성공시 뷰이름 
			}
//  }
		
	    return viewName;
	}

	//희진 맛집 대전 페이지
    @GetMapping("/Matzip/daejeonFamous")
    public String daejeonFamous(Model model) {
		String viewName = "/RecoSpot/travel_Seoul";//입력 실패시 뷰이름
		
		// 데이터를 가져와서 Model에 저장하기
		//int result = daejeonMatzipApiServiceImpl.insertDaejeonMatzip(); 
		
		//if(result==1) {
		//System.out.println("대전 공공 데이터가 정상적으로 입력되었습니다.");
			//DB에 저장된 데이터를 가져와서 Model객체에 저장하기
			//축제 목록 가져오기
			List<Damat> daeDamatList = daejeonMatzipApiServiceImpl.getAllDaejeonMatzip();
			
			//댓글 목록 가져오기 
		//List<SeoulMatzipCommentsVO> commentsList = seMatzipCommentsService.getAllComments();

			if(daeDamatList.size() > 0) {
				//대전 행사 목록 저장 하기
				model.addAttribute("daeDamatList", daeDamatList);
				//댓글 목록 저장하기
				//model.addAttribute("commentsList", commentsList);
				 
				viewName = "Matzip/daejeonFamous";
			
           }

		//}
	    return viewName;
		}
	//--------------- 여행지 --------------------

	
	  @Autowired private MatzipService matzipService; // MatzipService 인스턴스를 주입받음
	  //서울: travel_Seoul
	  
		/*
		 * @GetMapping("/RecoSpot/travel_Seoul") public String getTravelSeoulList(Model
		 * model) { List<MatzipVO> matzipList = matzipService.getMatzipList(); // DB에서
		 * 모든 맛집 리스트를 가져옴
		 * 
		 * // 각 맛집의 firstimage에서 쉼표로 구분된 첫 번째 URL만 가져오도록 처리 matzipList.forEach(matzip ->
		 * { String firstimage = matzip.getFirstimage(); // MatzipVO에서 firstimage 필드
		 * 가져오기 if (firstimage != null && firstimage.contains(",")) { // 쉼표로 구분된 이미지 중 첫
		 * 번째만 추출 firstimage = firstimage.split(",")[0].trim(); }
		 * matzip.setFirstimage(firstimage); // 첫 번째 URL로 설정 });
		 * 
		 * model.addAttribute("matzipList", matzipList); // JSP에 데이터 전달 return
		 * "RecoSpot/journal_Seoul"; // journal_Seoul.jsp로 이동 } }
		 */
	  
	 
    
    
    
	
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
	
	/*
	 * //희진 journal_Seoul
	 * 
	 * @GetMapping("/RecoSpot/journal_Seoul") public String journal_Seoul() { return
	 * "RecoSpot/journal_Seoul"; }
	 */
	
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
	
	//FAQ
    @GetMapping("/HomePage/FAQ")
    public String FAQ() {
        return "HomePage/FAQ";
    }
    
    
 // matzipDetail.jsp
    @Autowired
    private TalkService talkService;

    @GetMapping("/matzip/{contentid}")
    public String showBannerDetailByContentId(@PathVariable("contentid") int contentid,
                                              @RequestParam(defaultValue = "1") int page,
                                              Model model) {
        // contentid에 해당하는 맛집 정보를 가져옴
        MatzipVO matzip = matzipService.getMatzipDetailById(contentid);


        // 댓글 페이지네이션 로직
        int commentsPerPage = 10;
        int offset = (page - 1) * commentsPerPage;

        // 댓글 리스트
        List<TalkVO> talkList = talkService.getTalkList(contentid, "matzip", offset, commentsPerPage);
        int totalTalkCount = talkService.getTotalTalkCount(contentid, "matzip");
        int totalPages = (int) Math.ceil((double) totalTalkCount / commentsPerPage);

        // DataPlace 정보와 댓글 정보 JSP로 전달
        model.addAttribute("matzip", matzip);  // MatzipVO 객체 전달
        model.addAttribute("talkList", talkList);
        model.addAttribute("currentPageNumber", page);
        model.addAttribute("totalTalkCount", totalTalkCount);
        model.addAttribute("totalPages", totalPages);

        return "Matzip/matzipDetail";
    }

    // 댓글 리스트 가져오기 + 페이지네이션 적용
    @GetMapping("/Matzip/{contentid}/comments")
    @ResponseBody
    public Map<String, Object> listTalks(@PathVariable("contentid") int contentid,
                                         @RequestParam(defaultValue = "1") int page) {
        
        int commentsPerPage = 10;
        int offset = (page - 1) * commentsPerPage;

        // contentid에 해당하는 댓글 리스트 가져오기
        List<TalkVO> talkList = talkService.getTalkList(contentid, "matzip", offset, commentsPerPage);

        // 날짜 포맷 정의
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));

        // 포맷팅된 댓글 리스트 생성
        List<Map<String, String>> formattedTalkList = new ArrayList<>();
        for (TalkVO talk : talkList) {
            Map<String, String> talkData = new HashMap<>();
            talkData.put("talkIdx", String.valueOf(talk.getTalkIdx()));
            talkData.put("talkNickname", talk.getTalkNickname());
            talkData.put("talkEmail", talk.getTalkEmail());
            talkData.put("talkText", talk.getTalkText());
            talkData.put("talkCreatedAt", dateFormat.format(talk.getTalkCreatedAt()));
            talkData.put("talkUpdatedAt", talk.getTalkUpdatedAt() != null ? dateFormat.format(talk.getTalkUpdatedAt()) : null);
            talkData.put("talkProfile", talk.getTalkProfile());

            formattedTalkList.add(talkData);
        }

        int totalTalkCount = talkService.getTotalTalkCount(contentid, "matzip");
        int totalPages = (int) Math.ceil((double) totalTalkCount / commentsPerPage);

        // 응답 데이터로 댓글 리스트 및 페이지네이션 정보 반환
        Map<String, Object> response = new HashMap<>();
        response.put("talkList", formattedTalkList);
        response.put("currentPageNumber", page);
        response.put("totalTalkCount", totalTalkCount);
        response.put("totalPages", totalPages);

        return response;
    }
	 
    
	
}







