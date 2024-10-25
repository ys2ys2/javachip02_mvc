package com.human.web.controller;

import java.util.List;

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

    // 게시글 작성 처리 (JSON 응답)
    @PostMapping("/create")
    public ResponseEntity<String> createPost(@RequestBody PostVO post) {
        int result = postService.createPost(post);
        if (result == 1) {
            return ResponseEntity.status(HttpStatus.CREATED).body("SUCCESS");  // 성공 시 201 응답
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("ERROR");  // 실패 시 500 응답
        }
    }
    
    
}
