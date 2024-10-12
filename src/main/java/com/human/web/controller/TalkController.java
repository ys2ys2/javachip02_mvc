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
        model.addAttribute("itemList", itemList);	// mapx, mapy가 포함된 itemList
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


    // 댓글 작성
    @PostMapping("/insert")
    public String insertTalk(@RequestParam("talkText") String talkText, HttpSession session, RedirectAttributes redirectAttributes) {
        
        // TalkVO 객체 생성
        TalkVO talkVO = new TalkVO();  // 사용자가 입력한 댓글 데이터를 담을 객체 생성
        talkVO.setTalkText(talkText);  // 사용자가 입력한 댓글 내용(talkText)을 TalkVO 객체에 저장
        
        // 세션에서 로그인할 때 저장된 member 객체 가져오기
        // 세션에 로그인한 사용자의 정보(M_MemberVO)를 저장해 두었으므로 그 정보를 꺼내옴
        M_MemberVO member = (M_MemberVO) session.getAttribute("member");

        // TalkVO 객체에 세션에서 가져온 로그인한 사용자의 정보를 저장
        // 로그인한 사용자의 닉네임, 이메일, 프로필 이미지를 TalkVO에 저장
        talkVO.setTalkNickname(member.getM_nickname());  // 로그인한 사용자의 닉네임 설정
        talkVO.setTalkEmail(member.getM_email());        // 로그인한 사용자의 이메일 설정
        talkVO.setTalkProfile(member.getM_profile());    // 로그인한 사용자의 프로필 이미지 설정
        
        // 댓글 데이터를 DB에 삽입하는 서비스 호출
        // TalkService의 insertTalk() 메서드를 호출하여 TalkVO 객체를 전달, 댓글 데이터를 DB에 삽입
        int result = talkService.insertTalk(talkVO);

        // 댓글 등록 성공 여부에 따라 메시지를 설정하고 리다이렉트할 때 전달
        if (result > 0) {  // 댓글 등록 성공 시
            redirectAttributes.addFlashAttribute("message", "댓글이 성공적으로 등록되었습니다.");  // 성공 메시지 추가
        } else {  // 댓글 등록 실패 시
            redirectAttributes.addFlashAttribute("message", "댓글 등록에 실패했습니다. 다시 시도해주세요.");  // 실패 메시지 추가
        }

        // 댓글 리스트 페이지로 리다이렉트
        // 성공/실패 후 댓글 리스트가 표시되는 페이지(hotplace2.jsp)로 리다이렉트
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
