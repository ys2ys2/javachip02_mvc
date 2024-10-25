package com.human.web.vo;

public class TravelCommentVO {
    private int commentId;
    private int tpIdx;              // 여행기 ID
    private String commentWriter;
    private String commentContent;
    private String commentDate;

    // Getters and Setters
    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getTpIdx() {
        return tpIdx;
    }

    public void setTpIdx(int tpIdx) {
        this.tpIdx = tpIdx;
    }

    public String getCommentWriter() {
        return commentWriter;
    }

    public void setCommentWriter(String commentWriter) {
        this.commentWriter = commentWriter;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public String getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(String commentDate) {
        this.commentDate = commentDate;
    }
}
