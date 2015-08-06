package com.shanzhashu.shortblog;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by LIUXIAO950 on 2015-07-19.
 */
public class MsgBean {
    public static final String F_ID = "f_id";
    public static final String F_TIME = "f_time";
    public static final String F_CONTENT = "f_content";

    private static final String[] weekOfDays = {"周日", "周一", "周二", "周三", "周四", "周五", "周六"};

    private String id;
    private String time;
    private String content;
    private String week;

    public String getWeek() { return week; }

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
        updateWeek();
    }

    private void updateWeek()
    {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Date date = sdf.parse(time);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            int w = calendar.get(Calendar.DAY_OF_WEEK) - 1;
            if (w < 0){
                w = 0;
            }
            week = weekOfDays[w];
        } catch (ParseException e) {
            e.printStackTrace();
            week = "";
        }
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
