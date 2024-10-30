package com.human.web.controller;

import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.human.web.service.TripScheduleService;
import com.human.web.vo.M_MemberVO;
import com.human.web.vo.TripScheduleVO;

@Controller
public class TripScheduleController {

    @Autowired
    private TripScheduleService tripSchedService;

    @PostMapping("/saveTripSchedule")
    public String saveTripSchedule(HttpSession session, 
            @RequestParam("title") String title,
            @RequestParam("period_start") String period_start,
            @RequestParam("period_end") String period_end,
            @RequestParam("days[]") String[] dayNumbers,
            @RequestParam("city_names[]") String[] cityNames,
            @RequestParam("label_numbers[]") String[] labelNumbers,
            @RequestParam("place_names[]") String[] placeNames,
            @RequestParam("place_addresses[]") String[] placeAddresses,
            @RequestParam("place_latitudes[]") String[] placeLatitudes,
            @RequestParam("place_longitudes[]") String[] placeLongitudes) {

        M_MemberVO member = (M_MemberVO) session.getAttribute("member");

        if (member == null) {
            return "redirect:/Member/login";
        }

        int m_idx = member.getM_idx();
        String m_email = member.getM_email();
        String m_nickname = member.getM_nickname();

        TripScheduleVO tripScheduleVO = new TripScheduleVO();
        tripScheduleVO.setM_idx(m_idx);
        tripScheduleVO.setM_email(m_email);
        tripScheduleVO.setM_nickname(m_nickname);
        tripScheduleVO.setTitle(title);
        tripScheduleVO.setPeriod_start(period_start);
        tripScheduleVO.setPeriod_end(period_end);

        tripScheduleVO.setDayNumbers(convertStringArrayToIntArray(dayNumbers));
        tripScheduleVO.setCityNames(cityNames);
        tripScheduleVO.setLabelNumbers(convertStringArrayToIntArray(labelNumbers));
        tripScheduleVO.setPlaceNames(placeNames);
        tripScheduleVO.setPlaceAddresses(placeAddresses);
        tripScheduleVO.setPlaceLatitudes(convertStringArrayToDoubleArray(placeLatitudes));
        tripScheduleVO.setPlaceLongitudes(convertStringArrayToDoubleArray(placeLongitudes));

        tripSchedService.saveTripSchedule(tripScheduleVO);

        return "redirect:/MyPage/myPageMain";  
    }

    @GetMapping("/TripSchedule/TripList")
    public String getTripScheduleList(Model model) {
        List<TripScheduleVO> tripList = tripSchedService.getTripScheduleList();
        model.addAttribute("tripList", tripList);
        return "TripSchedule/TripList";
    }

    @GetMapping("/TripSchedule/TripPage")
    public String getTripScheduleById(@RequestParam(value = "post_id", required = false) Integer postId, Model model) {
        List<TripScheduleVO> tripSchedules;

        if (postId == null) {
            TripScheduleVO sampleTrip = new TripScheduleVO();
            sampleTrip.setTitle("샘플 일정 제목");
            sampleTrip.setCityNames(new String[]{"서울"});
            sampleTrip.setPeriod_start("2024-01-01");
            sampleTrip.setPeriod_end("2024-01-07");
            sampleTrip.setM_nickname("샘플 사용자");
            sampleTrip.setPlaceNames(new String[]{"경복궁", "남산타워"});
            sampleTrip.setPlaceAddresses(new String[]{"서울 종로구 사직로 161", "서울 중구 남산공원길 105"});
            sampleTrip.setDayNumbers(new int[]{1, 1});
            sampleTrip.setLabelNumbers(new int[]{1, 2});
            tripSchedules = Arrays.asList(sampleTrip);
        } else {
            tripSchedules = tripSchedService.getTripScheduleById(postId);
            if (tripSchedules == null || tripSchedules.isEmpty()) {
                return "redirect:/TripSchedule/TripList";
            }
        }

        String tripSchedulesJson = "[]";
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            tripSchedulesJson = objectMapper.writeValueAsString(tripSchedules);
            System.out.println("Generated JSON: " + tripSchedulesJson); // JSON 출력
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("tripSchedulesJson", tripSchedulesJson);
        model.addAttribute("tripSchedules", tripSchedules);

        return "TripSchedule/TripPage";
    }

    private int[] convertStringArrayToIntArray(String[] stringArray) {
        return Arrays.stream(stringArray).mapToInt(Integer::parseInt).toArray();
    }

    private double[] convertStringArrayToDoubleArray(String[] stringArray) {
        return Arrays.stream(stringArray).mapToDouble(Double::parseDouble).toArray();
    }
}
