package com.human.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.human.web.service.TravelPostService;
import com.human.web.util.FileManager;
import com.human.web.vo.TravelMediaVO;
import com.human.web.vo.TravelPostVO;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/Community")
@AllArgsConstructor
public class TravelPostController {

    private final TravelPostService travelPostService;
    private final FileManager fileManager;

    // 여행기 작성 페이지로 이동하는 메서드
    @GetMapping("/travelWrite")
    public String showTravelWritePage() {
        return "Community/c_board/travelWrite"; // JSP 파일 경로 (views 폴더 내)
    }

    // 여행기 작성 처리 메서드
    @PostMapping("/travel/writeProcess")
    public String writeProcess(TravelPostVO vo, @RequestParam String tags, @RequestParam MultipartFile[] uploadFiles,
                               HttpServletRequest request) {
        int result = travelPostService.insertTravelPost(vo, request);

        if (result == 1) {
            // 태그 저장 로직 (태그 문자열을 ',' 기준으로 나누어 각 태그를 DB에 저장)
            String[] tagList = tags.split(",");
            for (String tag : tagList) {
                tag = tag.trim(); // 태그 공백 제거
                Map<String, Object> params = new HashMap<>();
                params.put("tp_idx", vo.getTp_idx());
                params.put("tag", tag);

                // 중복 확인 후, 태그 삽입
                int count = travelPostService.checkDuplicateTag(params);
                if (count == 0) {
                    travelPostService.insertTag(params); // 중복이 없을 경우에만 태그 저장
                }
            }

            // 첨부파일 처리 (업로드된 파일이 있을 경우 처리)
            for (MultipartFile file : uploadFiles) {
                if (!file.isEmpty()) {
                    TravelMediaVO mediaVO = fileManager.handleFile(file, request); // 파일 처리
                    mediaVO.setTp_idx(vo.getTp_idx()); // 여행기 ID 설정
                    travelPostService.insertTravelMedia(mediaVO); // DB에 파일 정보 저장
                }
            }
        }

        return "redirect:/Community/c_main"; // 작성 후 커뮤니티 메인 페이지로 이동
    }

    // 여행기 목록 페이지를 반환하는 메서드
    @GetMapping("/travelPostList")
    public String travelPostList(Model model) {
        Map<String, List<TravelPostVO>> taggedPosts = new HashMap<>();
        taggedPosts.put("서울", travelPostService.getPostsByTag("서울"));
        taggedPosts.put("부산", travelPostService.getPostsByTag("부산"));
        taggedPosts.put("제주", travelPostService.getPostsByTag("제주"));
        taggedPosts.put("인천", travelPostService.getPostsByTag("인천"));
        
        model.addAttribute("taggedPosts", taggedPosts);
        return "Community/c_board/travelPostList"; // JSP 파일 경로로 이동
    }

    // 여행기 상세 페이지로 이동하는 메서드
    @GetMapping("/travelPostDetail")
    public String travelPostDetail(@RequestParam("tp_idx") int tp_idx, Model model) {
        TravelPostVO post = travelPostService.getTravelPost(tp_idx); // 특정 여행기 데이터 가져오기
        model.addAttribute("post", post);
        return "Community/c_board/travelPostDetail"; // 상세보기 페이지로 이동
    }

    // 파일 다운로드 기능
    @GetMapping("/download")
    public void downloadFile(@RequestParam String originFilename, @RequestParam String saveFilename,
                             HttpServletRequest request, HttpServletResponse response) {
        fileManager.download(originFilename, saveFilename, request, response); // 파일 다운로드 처리
    }

    // 태그별 최신 여행기 목록을 JSON으로 반환하는 메서드
    @GetMapping("/travelPostListData")
    @ResponseBody
    public Map<String, List<TravelPostVO>> travelPostListData() {
        Map<String, List<TravelPostVO>> taggedPosts = new HashMap<>();
        taggedPosts.put("서울", travelPostService.getRecentPostsByTag("서울")); // 서울 태그의 최신 3개
        taggedPosts.put("부산", travelPostService.getRecentPostsByTag("부산")); // 부산 태그의 최신 3개
        taggedPosts.put("제주", travelPostService.getRecentPostsByTag("제주")); // 제주 태그의 최신 3개
        taggedPosts.put("인천", travelPostService.getRecentPostsByTag("인천")); // 인천 태그의 최신 3개
        return taggedPosts; // JSON 형태로 데이터를 반환
    }
}
