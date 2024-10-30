/*
 * package com.human.web.controller;
 * 
 * import java.util.Arrays;
 * 
 * import javax.servlet.http.HttpSession;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.web.bind.annotation.PostMapping; import
 * org.springframework.web.bind.annotation.RequestParam;
 * 
 * import com.human.web.service.TripSchedService; import
 * com.human.web.vo.M_MemberVO; import com.human.web.vo.TripSchedVO;
 * 
 * @Controller public class TripSchedController {
 * 
 * @Autowired private TripSchedService tripSchedService;
 * 
 * // 여행 일정 저장을 처리하는 메서드
 * 
 * @PostMapping("/saveTripSchedule") public String saveTripSchedule(HttpSession
 * session,
 * 
 * @RequestParam("title") String title, // 제목
 * 
 * @RequestParam("period_start") String period_start, // 시작일
 * 
 * @RequestParam("period_end") String period_end, // 종료일
 * 
 * @RequestParam("days[]") String[] dayNumbers, // day 배열
 * 
 * @RequestParam("city_names[]") String[] cityNames, // 도시 이름 배열
 * 
 * @RequestParam("label_numbers[]") String[] labelNumbers, // 라벨 번호 배열
 * 
 * @RequestParam("place_names[]") String[] placeNames, // 장소 이름 배열
 * 
 * @RequestParam("place_addresses[]") String[] placeAddresses, // 주소 배열
 * 
 * @RequestParam("place_latitudes[]") String[] placeLatitudes, // 위도 배열
 * 
 * @RequestParam("place_longitudes[]") String[] placeLongitudes) { // 경도 배열
 * 
 * // 세션에서 m_idx, m_email, m_nickname을 가져옴 M_MemberVO member = (M_MemberVO)
 * session.getAttribute("member");
 * 
 * // 세션에 member 정보가 없으면 로그인 페이지로 리다이렉트 if (member == null) { return
 * "redirect:/Member/login"; }
 * 
 * int m_idx = member.getM_idx(); String m_email = member.getM_email(); String
 * m_nickname = member.getM_nickname();
 * 
 * // VO 생성 TripSchedVO tripSchedVO = new TripSchedVO();
 * tripSchedVO.setM_idx(m_idx); tripSchedVO.setM_email(m_email);
 * tripSchedVO.setM_nickname(m_nickname); tripSchedVO.setTitle(title);
 * tripSchedVO.setPeriod_start(period_start);
 * tripSchedVO.setPeriod_end(period_end);
 * 
 * // 배열 필드를 사용하여 여러 장소 정보를 설정
 * tripSchedVO.setDayNumbers(convertStringArrayToIntArray(dayNumbers)); //
 * String 배열을 int 배열로 변환 tripSchedVO.setCityNames(cityNames);
 * tripSchedVO.setLabelNumbers(convertStringArrayToIntArray(labelNumbers)); //
 * String 배열을 int 배열로 변환 tripSchedVO.setPlaceNames(placeNames);
 * tripSchedVO.setPlaceAddresses(placeAddresses);
 * 
 * // 좌표 정보 추가
 * tripSchedVO.setPlaceLatitudes(convertStringArrayToDoubleArray(placeLatitudes)
 * ); // String 배열을 double 배열로 변환
 * tripSchedVO.setPlaceLongitudes(convertStringArrayToDoubleArray(
 * placeLongitudes)); // String 배열을 double 배열로 변환
 * 
 * // 서비스 호출 tripSchedService.saveTripSchedule(tripSchedVO);
 * 
 * return "redirect:/MyPage/myPageMain"; // 저장 후 리다이렉트 }
 * 
 * // String 배열을 int 배열로 변환하는 유틸리티 메서드 private int[]
 * convertStringArrayToIntArray(String[] stringArray) { return
 * Arrays.stream(stringArray).mapToInt(Integer::parseInt).toArray(); }
 * 
 * // String 배열을 double 배열로 변환하는 유틸리티 메서드 private double[]
 * convertStringArrayToDoubleArray(String[] stringArray) { return
 * Arrays.stream(stringArray).mapToDouble(Double::parseDouble).toArray(); } }
 */