package com.human.web.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.human.web.service.TalkService;
import com.human.web.vo.M_MemberVO;
import com.human.web.vo.TalkVO;

@Controller
@RequestMapping("/HotPlace")
public class TalkController {

    @Autowired
    private TalkService talkService;

    // 핫플레이스 및 댓글 리스트 가져오기 (페이지네이션 적용)
    @GetMapping("/hotplace2")
    public String listItemsAndTalks(@RequestParam(defaultValue = "1") int page, Model model) {
        int commentsPerPage = 10; // 페이지당 댓글 수
        int offset = (page - 1) * commentsPerPage;


        
        // 핫플레이스 리스트 가져오기
        // LIMIT 1 OFFSET 2를 적용한 getItemList 메서드 호출
        List<Map<String, String>> itemList = talkService.getItemList(2, 1); // 2행부터 1개 가져오기

        // 전체 댓글 수
        // 댓글 리스트 가져오기
        List<TalkVO> talkList = talkService.getTalkList(offset, commentsPerPage);
        int totalTalkCount = talkService.getTotalTalkCount();
        int totalPages = (int) Math.ceil((double) totalTalkCount / commentsPerPage);

        // 모델에 데이터 추가하여 JSP에 전달
        model.addAttribute("talkList", talkList);
        model.addAttribute("itemList", itemList);
        model.addAttribute("currentPageNumber", page);
        model.addAttribute("totalTalkCount", totalTalkCount);
        model.addAttribute("totalPages", totalPages);

        return "HotPlace/hotplace2";  // hotplace2.jsp로 이동
    }
    
    // 댓글 리스트만 가져오는 메서드 (페이지네이션 적용, AJAX 요청에 사용)
    @GetMapping("/hotplace2/comments")
    @ResponseBody
    public Map<String, Object> listTalks(@RequestParam(defaultValue = "1") int page) {
        int commentsPerPage = 10;
        int offset = (page - 1) * commentsPerPage;

        List<TalkVO> talkList = talkService.getTalkList(offset, commentsPerPage);

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
            talkData.put("talkUpdatedAt", talk.getTalkUpdatedAt() != null ? dateFormat.format(talk.getTalkUpdatedAt()) : null);
            formattedTalkList.add(talkData);
        }

        int totalTalkCount = talkService.getTotalTalkCount();
        int totalPages = (int) Math.ceil((double) totalTalkCount / commentsPerPage);

        Map<String, Object> response = new HashMap<>();
        response.put("talkList", formattedTalkList); // 포맷팅된 리스트를 전달
        response.put("currentPageNumber", page);
        response.put("totalTalkCount", totalTalkCount);
        response.put("totalPages", totalPages);

        return response;
    }


    // 댓글 작성 처리
    @PostMapping("/insert")
    public String insertTalk(@RequestParam("talkText") String talkText, HttpSession session, RedirectAttributes redirectAttributes) {
        TalkVO talkVO = new TalkVO();
        talkVO.setTalkText(talkText);
        
        // 세션에서 로그인할때 저장한 member 객체를 가져오기
        M_MemberVO member = (M_MemberVO) session.getAttribute("member");

        // TalkVO에 세션 정보 저장
        talkVO.setTalkNickname(member.getM_nickname());
        talkVO.setTalkEmail(member.getM_email());
        talkVO.setTalkProfile(member.getM_profile());
        
        int result = talkService.insertTalk(talkVO);

        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "댓글이 성공적으로 등록되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("message", "댓글 등록에 실패했습니다. 다시 시도해주세요.");
        }

        // 댓글 리스트 페이지로 리다이렉트
        return "redirect:/HotPlace/hotplace2";  // hotplace2.jsp로 리다이렉트
    }
    
    
    //댓글 수정하기
    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<String> updateTalk(@RequestParam("talkIdx") int talkIdx, 
                                              @RequestParam("updatedText") String updatedText) {
        int result = talkService.updateTalk(talkIdx, updatedText);
        
        System.out.println("Update result for talkIdx " + talkIdx + ": " + result);
        if (result > 0) {
            return ResponseEntity.ok("success");
        } else {
            return ResponseEntity.ok("failure");
        }
    }
    
    // 댓글 삭제
    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<String> deleteTalk(@RequestParam("talkIdx") int talkIdx) {
        int result = talkService.deleteTalk(talkIdx);

        if (result > 0) {
            return ResponseEntity.ok("success");
        } else {
            return ResponseEntity.ok("failure");
        }
    }
    
}
