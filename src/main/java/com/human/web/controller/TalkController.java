package com.human.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.human.web.service.TalkService;
import com.human.web.vo.M_MemberVO;
import com.human.web.vo.TalkVO;

@Controller
@RequestMapping({ "/HotPlace", "/DataPlace", "/Matzip" }) // hotplace랑 DataPlace, Matzip 포함
public class TalkController {

    @Autowired
    private TalkService talkService;

    // 댓글 작성
    @PostMapping("/insert")
    public String insertTalk(@RequestParam("talkText") String talkText,
            @RequestParam("contentid") int contentid,
            @RequestParam("type") String type,
            HttpSession session, RedirectAttributes redirectAttributes) {

        // TalkVO 객체 생성
        TalkVO talkVO = new TalkVO(); // 사용자가 입력한 댓글 데이터를 담을 객체 생성
        talkVO.setTalkText(talkText); // 사용자가 입력한 댓글 내용(talkText)을 TalkVO 객체에 저장
        talkVO.setContentid(contentid); // contentid 저장
        talkVO.setType(type);
        // 세션에서 로그인할 때 저장된 member 객체 가져오기
        // 세션에 로그인한 사용자의 정보(M_MemberVO)를 저장해 두었으므로 그 정보를 꺼내옴
        M_MemberVO member = (M_MemberVO) session.getAttribute("member");

        // TalkVO 객체에 세션에서 가져온 로그인한 사용자의 정보를 저장
        // 로그인한 사용자의 닉네임, 이메일, 프로필 이미지를 TalkVO에 저장
        talkVO.setTalkNickname(member.getM_nickname()); // 로그인한 사용자의 닉네임 설정
        talkVO.setTalkEmail(member.getM_email()); // 로그인한 사용자의 이메일 설정
        talkVO.setTalkProfile(member.getM_profile()); // 로그인한 사용자의 프로필 이미지 설정

        // 댓글 데이터를 DB에 삽입하는 서비스 호출
        // TalkService의 insertTalk() 메서드를 호출하여 TalkVO 객체를 전달, 댓글 데이터를 DB에 삽입
        int result = talkService.insertTalk(talkVO);

        // 댓글 등록 성공 여부에 따라 메시지를 설정하고 리다이렉트할 때 전달
        if (result > 0) { // 댓글 등록 성공 시
            redirectAttributes.addFlashAttribute("message", "댓글이 성공적으로 등록되었습니다."); // 성공 메시지 추가
        } else { // 댓글 등록 실패 시
            redirectAttributes.addFlashAttribute("message", "댓글 등록에 실패했습니다. 다시 시도해주세요."); // 실패 메시지 추가
        }

        // 해당 contentid로 리다이렉트
        return "redirect:/" + type + "/" + contentid; // type + contentid 페이지로 리다이렉트
    }

    // 댓글 수정하기
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
