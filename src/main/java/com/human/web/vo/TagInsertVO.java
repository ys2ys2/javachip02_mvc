package com.human.web.vo;

public class TagInsertVO {
    private int tp_idx;
    private String tag_name;

    public TagInsertVO(int tp_idx, String tag_name) {
        this.tp_idx = tp_idx;
        this.tag_name = tag_name;
    }

    public int getTp_idx() {
        return tp_idx;
    }

    public void setTp_idx(int tp_idx) {
        this.tp_idx = tp_idx;
    }

    public String getTag_name() {
        return tag_name;
    }

    public void setTag_name(String tag_name) {
        this.tag_name = tag_name;
    }
}
