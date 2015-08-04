package com.shanzhashu.shortblog;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;

/**
 * Created by LIUXIAO950 on 2015-08-03.
 */
public class MsgList extends ArrayList<MsgBean> {

    private boolean msgExists(MsgBean bean) {
        if (bean != null)
            return msgIdExists(bean.getId());
        return false;
    }

    private boolean msgIdExists(String id) {
        for (MsgBean bean : this) {
            if (bean.getId().equals(id))
                return true;
        }
        return false;
    }

    private MsgBean getMsgBeanById(String id)
    {
        for (MsgBean bean : this) {
            if (bean.getId().equals(id))
                return bean;
        }
        return null;
    }

    public void insertBean(MsgBean bean) {
        if (bean != null) {
            if (!msgExists(bean))
                add(bean);
            else
            {
                MsgBean b = getMsgBeanById(bean.getId());
                b.setTime(bean.getTime());
                b.setContent(bean.getContent());
            }
        }
    }

    private class SortComparator implements Comparator {
        public int compare(Object o1, Object o2) {
            MsgBean s1 = (MsgBean) o1;
            MsgBean s2 = (MsgBean) o2;

            return s2.getTime().compareTo(s1.getTime());
        }
    }

    public void sortBeans() {
        // 根据时间排序，新在前
        Collections.sort(this, new SortComparator());
    }

    public void removeBeanById(String id)
    {
        int i;
        for (i=0;i<size();i++) {
            if (get(i).getId().equals(id)) {
                remove(i);
                return;
            }
        }
    }
}
