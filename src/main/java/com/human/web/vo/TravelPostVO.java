package com.human.web.vo;

public class TravelPostVO {
    private int postId;         // 게시글 ID
    private String topic;       // 게시글의 토픽 (도시여행, 자연여행, 해외여행 등)
    private String title;       // 게시글의 제목
    private String content;     // 게시글 본문
    private String tags;        // 태그 (쉼표로 구분된 문자열)
    private String createdAt;   // 작성 시간

    // 기본 생성자
    public TravelPostVO() {}

    // 매개변수를 받는 생성자
    public TravelPostVO(int postId, String topic, String title, String content, String tags, String createdAt) {
        this.postId = postId;
        this.topic = topic;
        this.title = title;
        this.content = content;
        this.tags = tags;
        this.createdAt = createdAt;
    }

    // Getter & Setter
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}
