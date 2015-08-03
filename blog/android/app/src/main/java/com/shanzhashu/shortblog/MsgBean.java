package com.shanzhashu.shortblog;

/**
 * Created by LIUXIAO950 on 2015-07-19.
 */
public class MsgBean {
    public static final String F_ID = "f_id";
    public static final String F_TIME = "f_time";
    public static final String F_CONTENT = "f_content";

    private String id;
    private String time;
    private String content;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        if (id == null)
            id = "";
        this.id = id;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time)
    {
        if (time == null)
            time = "";
        this.time = time;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        if (content == null)
            content = "";
        this.content = content;
    }

}
