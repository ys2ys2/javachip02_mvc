package com.human.web.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; // Controller 어노테이션 추가
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.web.service.DataPlaceService;
import com.human.web.service.TalkService;
import com.human.web.vo.TalkVO;

@Controller // 이 클래스를 컨트롤러로 인식하게 함
public class DataPlaceController {
    
    @Autowired
    private DataPlaceService dataPlaceService;
    
    @Autowired
    private TalkService talkService;

    // DataPlace 상세 페이지 만들기 + 댓글 가져오기
    @GetMapping("/DataPlace/{contentid}")
    public String showBannerDetailByContentId(@PathVariable("contentid") int contentid,
    										  @RequestParam(defaultValue = "1") int page,
    										  Model model) {
        // contentid에 해당하는 배너 정보를 가져옴
        Map<String, Object> dataplace = dataPlaceService.getDataplaceById(contentid);
        
        // 댓글 페이지네이션 로직
        int commentsPerPage = 10;
        int offset = (page - 1) * commentsPerPage;
        
        // 댓글 리스트
        List<TalkVO> talkList = talkService.getTalkList(contentid, "dataplace", offset, commentsPerPage);
        int totalTalkCount = talkService.getTotalTalkCount(contentid, "dataplace");
        int totalPages = (int) Math.ceil((double) totalTalkCount / commentsPerPage);
        
        // DataPlace 정보와 댓글 정보 JSP로 전달하기
        model.addAttribute("dataplace", dataplace);
        model.addAttribute("talkList", talkList);
        model.addAttribute("currentPageNumber", page);
        model.addAttribute("totalTalkCount", totalTalkCount);
        model.addAttribute("totalPages", totalPages);

        return "HomePage/dataplaceDetail"; // 상세 페이지로 이동
    }
    
    
    // DataPlace의 댓글 리스트 가져오기 + 페이지네이션 적용, AJAX 요청 사용
    @GetMapping("/DataPlace/{contentid}/comments")
    @ResponseBody
    public Map<String, Object> listTalks(@PathVariable("contentid") int contentid,
    									 @RequestParam(defaultValue = "1") int page){
    	
    	int commentsPerPage = 10;
    	int offset = (page -1) * commentsPerPage;
    	
    	// contentid에 해당하는 댓글 리스트 가져오기
        List<TalkVO> talkList = talkService.getTalkList(contentid, "dataplace", offset, commentsPerPage);
    	
    	// 날짜 포맷 정의
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        dateFormat.setTimeZone(TimeZone.getTimeZone("UTC")); // UTC로 시간대를 설정
    	
    	//날짜 포맷팅 후 새로운 리스트 반환
    	List<Map<String, String>> formattedTalkList = new ArrayList<>();
    	for (TalkVO talk : talkList) {
    		Map<String, String> talkData = new HashMap<>();
    		talkData.put("talkIdx", String.valueOf(talk.getTalkIdx()));
    		talkData.put("talkNickname", talk.getTalkNickname());
    		talkData.put("talkEmail", talk.getTalkEmail());
            talkData.put("talkText", talk.getTalkText());
            talkData.put("talkCreatedAt", dateFormat.format(talk.getTalkCreatedAt()));
            talkData.put("talkUpdatedAt", talk.getTalkUpdatedAt() != null ? dateFormat.format(talk.getTalkUpdatedAt()) : null);
    		
            //프로필 이미지 URL
    		talkData.put("talkProfile", talk.getTalkProfile());
    		
    		formattedTalkList.add(talkData);
    		
    	}
    	
        int totalTalkCount = talkService.getTotalTalkCount(contentid, "dataplace");
    	int totalPages = (int) Math.ceil((double) totalTalkCount / commentsPerPage);
    	
    	//응답 데이터로 댓글 리스트, 페이지네이션 맵 반환
    	Map<String,Object> response = new HashMap<>();
    	response.put("talkList", formattedTalkList);
    	response.put("currentPageNumber", page);
        response.put("totalTalkCount", totalTalkCount);
        response.put("totalPages", totalPages);

        
        return response;
    			
    	
    }
    
    
}
