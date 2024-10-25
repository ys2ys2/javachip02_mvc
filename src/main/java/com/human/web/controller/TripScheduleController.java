package com.human.web.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;  // 추가된 JSON 변환 라이브러리
import com.human.web.service.TripScheduleService;
import com.human.web.vo.M_MemberVO;
import com.human.web.vo.ScheduleVO;
import com.human.web.vo.TripScheduleVO;

@Controller
public class TripScheduleController {

    @Autowired
    private TripScheduleService tripSchedService;

    // 여행 일정 저장 처리
    @PostMapping("/saveTripSchedule")
    public String saveTripSchedule(HttpSession session, 
                                   @RequestParam("title") String title,   
                                   @RequestParam("period_start") String period_start,   
                                   @RequestParam("period_end") String period_end,       
                                   @RequestParam("days[]") String[] dayNumbers,         
                                   @RequestParam("city_names[]") String[] cityNames,    
                                   @RequestParam("label_numbers[]") String[] labelNumbers, 
                                   @RequestParam("place_names[]") String[] placeNames,  
                                   @RequestParam("place_addresses[]") String[] placeAddresses) {  

        M_MemberVO member = (M_MemberVO) session.getAttribute("member");

        if (member == null) {
            return "redirect:/Member/login";
        }

        int m_idx = member.getM_idx();
        String m_email = member.getM_email();
        String m_nickname = member.getM_nickname();

        TripScheduleVO tripSchedVO = new TripScheduleVO();
        tripSchedVO.setM_idx(m_idx);
        tripSchedVO.setM_email(m_email);
        tripSchedVO.setM_nickname(m_nickname);
        tripSchedVO.setTitle(title);
        tripSchedVO.setPeriod_start(period_start);
        tripSchedVO.setPeriod_end(period_end);

        List<ScheduleVO> scheduleList = new ArrayList<>();
        for (int i = 0; i < dayNumbers.length; i++) {
            ScheduleVO schedule = new ScheduleVO();
            schedule.setDay_number(Integer.parseInt(dayNumbers[i]));
            schedule.setCity_name(cityNames[i]);
            schedule.setLabel_number(Integer.parseInt(labelNumbers[i]));
            schedule.setPlace_name(placeNames[i]);
            schedule.setPlace_address(placeAddresses[i]);
            scheduleList.add(schedule);
        }

        tripSchedVO.setScheduleList(scheduleList);
        tripSchedService.saveTripSchedule(tripSchedVO);

        return "redirect:/MyPage/myPageMain";  
    }

    // 여행 일정 리스트 조회
    @GetMapping("/TripSchedule/TripList")
    public String getTripScheduleList(Model model) {
        List<TripScheduleVO> tripList = tripSchedService.getTripScheduleList();
        model.addAttribute("tripList", tripList);
        return "TripSchedule/TripList";
    }

    // 여행 일정 단일 조회 및 JSON 변환
    @GetMapping("/TripSchedule/TripPage")
    public String getTripScheduleById(@RequestParam(value = "post_id", required = false) Integer postId, Model model) {
        ObjectMapper mapper = new ObjectMapper();  // ObjectMapper를 사용하여 JSON으로 변환
        String scheduleListJson = "";

        if (postId == null || postId == 0) {
            // 샘플 데이터 반환
            TripScheduleVO sampleTrip = new TripScheduleVO();
            sampleTrip.setTitle("제목을 입력해주세요");
            sampleTrip.setPeriod_start("20yy-mm-dd");
            sampleTrip.setPeriod_end("20yy-mm-dd");
            sampleTrip.setM_nickname("샘플 사용자");
            List<ScheduleVO> sampleScheduleList = Arrays.asList(
                new ScheduleVO(0, 0, 1, "서울", 1, "경복궁", "서울 종로구 사직로 161"),
                new ScheduleVO(0, 0, 2, "서울", 1, "남산타워", "서울 중구 남산공원길 105")
            );
            sampleTrip.setScheduleList(sampleScheduleList);

            try {
                // 샘플 데이터의 scheduleList를 JSON으로 변환
                scheduleListJson = mapper.writeValueAsString(sampleScheduleList);
            } catch (Exception e) {
                e.printStackTrace();
            }
            model.addAttribute("tripSchedule", sampleTrip);
        } else {
            // DB에서 post_id로 조회
            List<TripScheduleVO> tripSchedules = tripSchedService.getTripScheduleById(postId);
            if (tripSchedules.isEmpty()) {
                return "redirect:/TripSchedule/TripList";
            }

            TripScheduleVO tripSchedule = tripSchedules.get(0);

            try {
                // 실제 데이터의 scheduleList를 JSON으로 변환
                scheduleListJson = mapper.writeValueAsString(tripSchedule.getScheduleList());
            } catch (Exception e) {
                e.printStackTrace();
            }

            model.addAttribute("tripSchedule", tripSchedule);
        }

        // scheduleListJson을 JSP에 전달
        model.addAttribute("scheduleListJson", scheduleListJson);
        return "TripSchedule/TripPage";
    }
}
