package com.human.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.human.web.service.TravelCommentService;
import com.human.web.service.TravelLikeService;
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
    private final TravelLikeService travelLikeService;
    private final TravelCommentService travelCommentService;
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
    
    @GetMapping("/travelPostList")
    public String showTravelPostListPage(Model model) {
        // 전체 게시글 데이터를 기본으로 가져와서 뷰로 넘겨줄 수 있습니다 (원할 경우)
        model.addAttribute("taggedPosts", travelPostService.getAllPosts());
        return "Community/c_board/travelPostList"; // JSP 파일 경로
    }

 // 태그 또는 토픽에 따라 필터링된 여행기 목록을 반환하는 메서드 (검색 기능 추가)
    @GetMapping(value = "/filterPosts", produces = "application/json")
    @ResponseBody
    public Map<String, Object> filterPostsByTagOrTopicWithPagination(
        @RequestParam(value = "filter", required = false) String filter,
        @RequestParam(value = "page", defaultValue = "1") int page,
        @RequestParam(value = "pageSize", defaultValue = "9") int pageSize,
        @RequestParam(value = "query", required = false) String query) {  // 검색어 추가

        List<TravelPostVO> posts;
        int totalPostCount;

        // 검색어가 있을 경우 검색어와 필터를 함께 처리
        if (query != null && !query.isEmpty()) {
            posts = travelPostService.getPostsByFilterAndQuery(filter, page, pageSize, query); // 필터 + 검색어로 게시글 조회
            totalPostCount = travelPostService.countPostsByFilterAndQuery(filter, query);  // 필터 + 검색어로 게시글 수 조회
        } 
        // 검색어가 없을 경우 기존 로직을 사용
        else {
            // 필터가 '전체'이거나 필터가 없는 경우 모든 게시글을 가져오도록 처리
            if (filter == null || filter.equals("전체")) {
                posts = travelPostService.getAllPostsWithPagination(page, pageSize);  // 모든 게시글 가져오기 (페이지네이션 포함)
                totalPostCount = travelPostService.getTotalPostCount();  // 전체 게시글 수
            } else {
                // 특정 필터(태그 또는 토픽)에 따른 게시글 목록과 총 게시글 수 가져오기
                posts = travelPostService.getPostsByFilterWithPagination(filter, page, pageSize);
                totalPostCount = travelPostService.getTotalPostCountByFilter(filter);
            }
        }
        Map<String, Object> response = new HashMap<>();
        response.put("posts", posts);
        response.put("totalPostCount", totalPostCount);
        response.put("currentPage", page);
        response.put("pageSize", pageSize);
        return response;
    }

 // 여행기 상세 페이지로 이동하는 메서드
    @GetMapping("/travelPostDetail/{tp_idx}")
    public String travelPostDetail(@PathVariable("tp_idx") int tp_idx, Model model) {
        TravelPostVO post = travelPostService.getTravelPost(tp_idx);
        
        String currentUserId = "guest_user";  // 현재 로그인된 사용자의 ID를 가져오는 로직 필요
        boolean isLiked = travelLikeService.likeExists(tp_idx, currentUserId);

        int likeCount = travelLikeService.getLikeCount(tp_idx);
        post.setLiked(isLiked);  // 사용자가 좋아요를 눌렀는지 여부 설정
        model.addAttribute("post", post);
        model.addAttribute("likeCount", likeCount);  // likeCount를 모델에 추가
       
        
        return "Community/c_board/travelPostDetail";
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
