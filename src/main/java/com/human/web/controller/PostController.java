package com.human.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.human.web.service.PostService;
import com.human.web.vo.M_MemberVO;
import com.human.web.vo.PostVO;

@RestController  // JSON 응답용 컨트롤러
@RequestMapping("/post")  // 경로 매핑
public class PostController {

    @Autowired
    private PostService postService;

    // 게시글 목록 조회 (JSON 응답)
    @GetMapping(value = "/list", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<PostVO>> getPostList() {
        List<PostVO> posts = postService.getAllPosts();
        return ResponseEntity.ok(posts);  // 상태 코드와 함께 반환
    }
    
    
    // 특정 게시글 조회 (상세 보기)
    @GetMapping("/detail/{postId}")
    public ResponseEntity<PostVO> getPostDetail(@PathVariable int postId) {
        System.out.println("요청된 게시글 ID: " + postId);  // 로그 추가
        PostVO post = postService.getPostById(postId);
        if (post != null) {
            System.out.println("게시글 조회 성공: " + post);
            return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(post);
        } else {
            System.out.println("게시글을 찾을 수 없습니다.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }


 // 예슬 추가: 게시글 작성 처리 (JSON 응답)
    @PostMapping("/create")
    public ResponseEntity<String> createPost(HttpSession session, @RequestBody PostVO post) {
        // 세션에서 로그인한 사용자 정보 가져오기
        M_MemberVO member = (M_MemberVO) session.getAttribute("member");
        
        // 세션에 저장된 m_idx 값을 PostVO 객체에 설정
        if (member != null) {
            int m_idx = member.getM_idx();  // 세션에서 m_idx 가져오기
            post.setM_idx(m_idx);           // PostVO에 m_idx 설정
        } else {
            // 세션에 member 정보가 없으면 에러 처리
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 된 유저가 없음");
        }

        // 서비스 계층에 게시글 생성 요청
        int result = postService.createPost(post);

        // 성공 시 201 응답, 실패 시 500 응답 반환
        if (result == 1) {
            return ResponseEntity.status(HttpStatus.CREATED).body("SUCCESS");  // 성공 시 201 응답
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("ERROR");  // 실패 시 500 응답
        }
    }

    
    
	/* 영준이 코드 
	  
	 * // 게시글 작성 처리 (JSON 응답)
	 * 
	 * @PostMapping("/create") public ResponseEntity<String> createPost(@RequestBody
	 * PostVO post) { int result = postService.createPost(post); if (result == 1) {
	 * return ResponseEntity.status(HttpStatus.CREATED).body("SUCCESS"); // 성공 시 201
	 * 응답 } else { return
	 * ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("ERROR"); // 실패
	 * 시 500 응답 } }
	 */
    
}
