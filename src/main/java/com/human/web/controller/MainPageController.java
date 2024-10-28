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

import com.human.web.service.BannerPlaceService;
import com.human.web.service.DataPlaceService;
import com.human.web.service.EventsService;
import com.human.web.service.HotPlaceService;
import com.human.web.service.TalkService;
import com.human.web.service.TravelPostService;
import com.human.web.vo.TalkVO;

@Controller
public class MainPageController {

	@Autowired
	private HotPlaceService hotplaceService;

	@Autowired
	private BannerPlaceService bannerPlaceService;

	@Autowired
	private TalkService talkService;

	@Autowired
	private DataPlaceService dataPlaceService;

	@Autowired
	private TravelPostService travelPostService;
	
	@Autowired
	private EventsService eventsService;

	// 핫플 테이블의 상세 정보를 랜덤으로 가져오기
	@GetMapping("/HomePage/mainpage")
	public String showHotplaceDetails(Model model) {
		// 랜덤으로 5개의 핫플레이스 정보를 가져옴
		List<Map<String, Object>> hotplaceDetails = hotplaceService.getRandomHotplaceDetail(33); // 핫플 부분
		List<Map<String, Object>> bannerPlaces = bannerPlaceService.getRandomBannerPlace(7); // 배너 부분
		List<Map<String, Object>> dataplaceDetails = dataPlaceService.getRandomDataPlace(4); // 빅데이터 부분
		// 랜덤 travelpost 가져오기
		List<Map<String, Object>> travelPost = travelPostService.getRandomTravelPost(4);
		
		// 랜덤 travelpost 가져와서 누르면 해당 포스트에 link하기
		
		
		// 이벤트 이미지 가져오기 (9개)
		List<Map<String, Object>> eventImages = eventsService.getRandomEventImages();

		// JSP로 데이터 전달
		model.addAttribute("hotplaceDetails", hotplaceDetails);
		model.addAttribute("bannerPlaces", bannerPlaces);
		model.addAttribute("dataplaceDetails", dataplaceDetails);
		// 랜덤 travelpost
		model.addAttribute("travelPost", travelPost);
		//이벤트 이미지
		model.addAttribute("eventImages", eventImages);

		return "HomePage/mainpage"; // mainpage.jsp로 이동

		// travelPost 랜덤 4개 가져오기

		// JSP로 전달

	}

	// HotPlace 상세 페이지 만들기 + 댓글 가져오기
	@GetMapping("/HotPlace/{contentid}")
	public String showHotplaceByContentId(@PathVariable("contentid") int contentid,
			@RequestParam(defaultValue = "1") int page,
			Model model) {
		// contentid에 해당하는 hotplace 정보 가져오기
		Map<String, Object> hotplace = hotplaceService.getHotplaceById(contentid);

		// 댓글 관련 로직 추가
		int commentsPerPage = 10;
		int offset = (page - 1) * commentsPerPage;

		// 댓글 리스트 가져오기
		List<TalkVO> talkList = talkService.getTalkList(contentid, "hotplace", offset, commentsPerPage);
		int totalTalkCount = talkService.getTotalTalkCount(contentid, "hotplace");
		int totalPages = (int) Math.ceil((double) totalTalkCount / commentsPerPage);

		// HotPlace 정보와 댓글 정보를 JSP로 전달
		model.addAttribute("hotplace", hotplace);
		model.addAttribute("talkList", talkList);
		model.addAttribute("currentPageNumber", page);
		model.addAttribute("totalTalkCount", totalTalkCount);
		model.addAttribute("totalPages", totalPages);

		// HotPlace detail 페이지로 이동
		return "HotPlace/hotdetail";
	}

	// 댓글 리스트만 가져오는 메서드 (페이지네이션 적용, AJAX 요청에 사용)
	@GetMapping("/HotPlace/{contentid}/comments")
	@ResponseBody
	public Map<String, Object> listTalks(@PathVariable("contentid") int contentid,
			@RequestParam(defaultValue = "1") int page) {
		int commentsPerPage = 10;
		int offset = (page - 1) * commentsPerPage;

		// contentid에 해당하는 댓글 리스트 가져오기
		List<TalkVO> talkList = talkService.getTalkList(contentid, "hotplace", offset, commentsPerPage);

		// 날짜 포맷 정의
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		dateFormat.setTimeZone(TimeZone.getTimeZone("UTC")); // UTC로 시간대를 설정

		// 날짜를 포맷팅한 후 새로운 리스트로 변환
		List<Map<String, String>> formattedTalkList = new ArrayList<>();
		for (TalkVO talk : talkList) {
			Map<String, String> talkData = new HashMap<>();
			talkData.put("talkIdx", String.valueOf(talk.getTalkIdx()));
			talkData.put("talkNickname", talk.getTalkNickname());
			talkData.put("talkEmail", talk.getTalkEmail());
			talkData.put("talkText", talk.getTalkText());
			talkData.put("talkCreatedAt", dateFormat.format(talk.getTalkCreatedAt()));
			talkData.put("talkUpdatedAt",
					talk.getTalkUpdatedAt() != null ? dateFormat.format(talk.getTalkUpdatedAt()) : null);

			// 프로필 이미지 URL 그대로 사용
			talkData.put("talkProfile", talk.getTalkProfile()); // 프로필 URL 추가

			formattedTalkList.add(talkData);
		}

		int totalTalkCount = talkService.getTotalTalkCount(contentid, "hotplace");
		int totalPages = (int) Math.ceil((double) totalTalkCount / commentsPerPage);

		// 응답 데이터로 댓글 리스트와 페이지네이션 정보를 포함한 맵을 반환
		Map<String, Object> response = new HashMap<>();
		response.put("talkList", formattedTalkList); // 포맷팅된 리스트를 전달
		response.put("currentPageNumber", page);
		response.put("totalTalkCount", totalTalkCount);
		response.put("totalPages", totalPages);

		return response;
	}

}
