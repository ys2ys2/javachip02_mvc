package com.human.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
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

import com.human.web.service.LikeService;
import com.human.web.service.PostService;
import com.human.web.vo.M_MemberVO;
import com.human.web.vo.PostVO;

@RestController // JSON 응답용 컨트롤러
@RequestMapping("/post") // 경로 매핑
public class PostController {

    @Autowired
    private PostService postService;
    private LikeService likeService;
    // 게시글 목록 조회 (JSON 응답)
 
    @GetMapping("/list")
    public ResponseEntity<List<PostVO>> getPostList() {
        List<PostVO> posts = postService.getAllPosts();
        // posts에 post_writer 값이 제대로 채워져 있는지 확인하기 위해 로그 출력
        posts.forEach(post -> System.out.println("Post Writer: " + post.getPost_writer()));
        return ResponseEntity.ok(posts);
    }

    
    // 특정 게시글 조회 (상세 보기)
    @GetMapping("/detail/{postId}")
    public ResponseEntity<PostVO> getPostDetail(@PathVariable int postId) {
        System.out.println("요청된 게시글 ID: " + postId);
        PostVO post = postService.getPostById(postId);
        
        if (post == null) {
            System.out.println("게시글을 찾을 수 없습니다.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        
        System.out.println("게시글 조회 성공: " + post);
        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(post);
    }



    // 게시글 작성 처리 (JSON 응답)
    @PostMapping("/create")
    public ResponseEntity<String> createPost(@RequestBody PostVO post, HttpSession session) {
        M_MemberVO member = (M_MemberVO) session.getAttribute("member");

        if (member == null) {
            System.out.println("로그인된 사용자 정보가 없습니다. 작성 불가.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        // 세션에서 가져온 사용자 정보로 게시글 작성자 정보 설정
        post.setM_idx(member.getM_idx());  // m_idx 설정
        post.setPost_writer(member.getM_nickname());  // post_writer에 닉네임 설정
        System.out.println("게시글 작성 요청 - m_idx: " + post.getM_idx() + ", 작성자: " + post.getPost_writer());

        int result = postService.createPost(post);
        if (result == 1) {
            return ResponseEntity.status(HttpStatus.CREATED).body("SUCCESS");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("ERROR");
        }
    }




}
