package com.human.web.vo;

public class MediaVO {
    private int mediaId;     // 미디어 ID
    private int postId;      // 게시글 ID (여행기와 연결)
    private String fileName; // 업로드된 파일의 이름
    private String filePath; // 서버에 저장된 파일 경로

    // 기본 생성자
    public MediaVO() {}

    // 매개변수를 받는 생성자
    public MediaVO(int mediaId, int postId, String fileName, String filePath) {
        this.mediaId = mediaId;
        this.postId = postId;
        this.fileName = fileName;
        this.filePath = filePath;
    }

    // Getter & Setter
    public int getMediaId() {
        return mediaId;
    }

    public void setMediaId(int mediaId) {
        this.mediaId = mediaId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}
