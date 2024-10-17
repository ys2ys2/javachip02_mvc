package com.human.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.human.web.service.SeoulEventApiService;
import com.human.web.vo.SeoulEventApiVO;

@Controller
@RequestMapping("/api/events")
public class SeoulEventApiController {

	 private final SeoulEventApiService seoulEventApiService;

	    @Autowired
	    public SeoulEventApiController(SeoulEventApiService seoulEventApiService) {
	        this.seoulEventApiService = seoulEventApiService;
	    }

	    @GetMapping
	    public List<SeoulEventApiVO.Row> getAllEvents() {
	        return seoulEventApiService.getAllEvents();
	    }

//	    @PostMapping("/saveEvent.do")
//	    //@ResponseBody //이건 반환하는 값만 저장가능하다 안쓰면 페이지가 이동이 된다! 
//	    public String saveEvent(HttpServletRequest request) {
//	    	String result = "RecoSpot/travel_Seoul";
//	    	int num = 0;
//	    	
//	    	HttpSession session = request.getSession();
//	    	List<SeoulEventApiVO.Row> event = (List<SeoulEventApiVO.Row>)session.getAttribute("rowList");
//	    		    	
//	    	// rowList 처리 로직 구현
//	        if (event != null) {
//	            for (SeoulEventApiVO.Row row : event) {
//	            	//num += seoulEventApiService.saveEvent(row);
//	            }
//	        }
//	        if(num >= 1) {
//	        	result = "festival/Event";
//	        }
//	    
//	        
//	        return result;
//	    }
	}