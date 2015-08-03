package com.shanzhashu.shortblog;

import java.util.ArrayList;

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

    public void insertBean(MsgBean bean) {
        if (bean != null) {
            if (!msgExists(bean))
                add(bean);
        }
    }

    public void sortBeans() {
        // TODO: 根据时间排序，新在前
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
