package com.human.web.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.human.web.service.TalkService;
import com.human.web.vo.TalkVO;

@Controller
@RequestMapping("/HotPlace")  // HotPlace 경로로 수정
public class TalkController {

    @Autowired
    private TalkService talkService;

    // 핫플레이스 및 댓글 리스트 가져오기 (페이지네이션 적용)
    @GetMapping("/hotplace2")
    public String listTalks(@RequestParam(defaultValue = "1") int page, Model model) {
        int commentsPerPage = 10; // 페이지당 댓글 수
        int offset = (page - 1) * commentsPerPage;

        // 댓글 리스트 가져오기
        List<TalkVO> talkList = talkService.getTalkList(offset, commentsPerPage);
        
        // 핫플레이스 리스트 가져오기
        // LIMIT 1 OFFSET 2를 적용한 getItemList 메서드 호출
        List<Map<String, String>> itemList = talkService.getItemList(2, 1); // 2행부터 1개 가져오기

        // 전체 댓글 수
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

    // 댓글 작성 처리
    @PostMapping("/insert")
    public String insertTalk(TalkVO talkVO, Model model) {
        int result = talkService.insertTalk(talkVO);

        if (result > 0) {
            model.addAttribute("message", "댓글이 성공적으로 등록되었습니다.");
        } else {
            model.addAttribute("message", "댓글 등록에 실패했습니다. 다시 시도해주세요.");
        }

        // 댓글 리스트 페이지로 리다이렉트
        return "redirect:/HotPlace/hotplace2";  // hotplace2.jsp로 리다이렉트
    }

    // 댓글 삭제 처리
    @PostMapping("/delete")
    public String deleteTalk(@RequestParam("talkIdx") int talkIdx, Model model) {
        int result = talkService.deleteTalk(talkIdx);

        if (result > 0) {
            model.addAttribute("message", "댓글이 성공적으로 삭제되었습니다.");
        } else {
            model.addAttribute("message", "댓글 삭제에 실패했습니다.");
        }

        return "redirect:/HotPlace/hotplace2";  // hotplace2.jsp로 리다이렉트
    }

    // 댓글 수정 처리
    @PostMapping("/update")
    public String updateTalk(@RequestParam("talkIdx") int talkIdx, @RequestParam("updatedText") String updatedText, Model model) {
        int result = talkService.updateTalk(talkIdx, updatedText);

        if (result > 0) {
            model.addAttribute("message", "댓글이 성공적으로 수정되었습니다.");
        } else {
            model.addAttribute("message", "댓글 수정에 실패했습니다.");
        }

        return "redirect:/HotPlace/hotplace2";  // hotplace2.jsp로 리다이렉트
    }
}
