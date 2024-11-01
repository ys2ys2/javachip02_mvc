package com.human.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.human.web.service.TravelCommentService;
import com.human.web.service.TravelLikeService;
import com.human.web.service.TravelPostService;
import com.human.web.util.FileManager;
import com.human.web.vo.M_MemberVO;
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

    @PostMapping("/travel/writeProcess")
    public String writeProcess(
            TravelPostVO vo, 
            @RequestParam String tags, 
            @RequestParam MultipartFile[] uploadFiles,
            HttpServletRequest request) {

        // 세션에서 member 객체를 가져옴
        M_MemberVO member = (M_MemberVO) request.getSession().getAttribute("member");

        if (member == null) {
            // 로그인이 안 되어 있으면 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }

        // member 객체에서 m_idx와 m_nickname을 추출하여 설정
        vo.setM_idx(member.getM_idx());
        vo.setWriter(member.getM_nickname());

        // 여행기 포스트 작성
        int result = travelPostService.insertTravelPost(vo, request);

        if (result == 1) {
            // 태그 처리 로직
            String[] tagList = tags.split(",");
            for (String tag : tagList) {
                tag = tag.trim();
                Map<String, Object> params = new HashMap<>();
                params.put("tp_idx", vo.getTp_idx());
                params.put("tag", tag);

                // 중복 확인 후 태그 삽입
                if (travelPostService.checkDuplicateTag(params) == 0) {
                    travelPostService.insertTag(params);
                }
            }

            // 첨부파일 처리 로직
            for (MultipartFile file : uploadFiles) {
                if (!file.isEmpty()) {
                    TravelMediaVO mediaVO = fileManager.handleFile(file, request);
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
    public String travelPostDetail(@PathVariable("tp_idx") int tp_idx, Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        M_MemberVO member = (M_MemberVO) session.getAttribute("member");

        if (member == null) {
            redirectAttributes.addFlashAttribute("loginMessage", "로그인이 필요합니다.");
            return "redirect:/Member/login";
        }

        // 로그인한 사용자 정보를 모델에 추가
        model.addAttribute("member", member);

        // 여행기 정보 및 좋아요 상태 추가
        TravelPostVO post = travelPostService.getTravelPost(tp_idx);

        // 좋아요 상태 및 개수 추가
        boolean isLiked = travelLikeService.likeExists(tp_idx, member.getM_idx());
        int likeCount = travelLikeService.getLikeCount(tp_idx);

        post.setLiked(isLiked);
        model.addAttribute("post", post);
        model.addAttribute("likeCount", likeCount);

        return "Community/c_board/travelPostDetail"; // 여행기 상세 페이지로 이동
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
