package com.human.web.vo;

import java.time.LocalDateTime;

public class PostVO {
	private int m_idx; //예슬 추가 
	
	private int id;              // 게시글 ID
    private String writer;        // 작성자
    private String content;       // 내용
    private LocalDateTime postDate; // 작성 날짜
    private int commentCount;
    private int likeCount;
    private boolean isLiked;
    // 생성자에서 기본 값 설정
    public PostVO() {
        this.postDate = LocalDateTime.now();  // 현재 시간으로 초기화
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getPostDate() {
        return postDate;
    }

    public void setPostDate(LocalDateTime postDate) {
        this.postDate = postDate;
    }
    
    public int getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

	public boolean isLiked() {
		return isLiked;
	}

	public void setLiked(boolean isLiked) {
		this.isLiked = isLiked;
	}
}
