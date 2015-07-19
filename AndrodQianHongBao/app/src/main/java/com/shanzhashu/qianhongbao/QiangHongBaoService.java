package com.shanzhashu.qianhongbao;

import android.accessibilityservice.AccessibilityService;
import android.annotation.TargetApi;
import android.app.Notification;
import android.app.PendingIntent;
import android.os.Build;
import android.os.Handler;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.Toast;

import java.util.List;

/**
 * 当前在微信聊天界面中时，状态栏上不会弹出通知，因此无法触发消息
 * 当前在微信主界面时，触发状态栏弹出聊天窗口不会触发Window State Changed，
 * 发现领完有三种：
 * 1、聊天窗口出现红包后，点击就进详情，表示点击那一刻就已被抢完。已处理好。
 * 2、聊天窗口出现红包后，点击进对话框并拉取，拉取到领完的消息，就不会显示“拆红包”按钮，而是根据实际情况如红包多少等，在对话框上显示“查看领取详情”或“看看大家的手气”，也已处理好。
 * 3、聊天窗口出现红包后，点击进对话框并拉取，拉取到可领的消息便显示“拆红包”按钮，自动点击按钮后提示已被抢完，这个已被抢完无事件通知，只能 postDelay 检查并根据需要进详情，也已处理好。
 * 还有个问题，从详情返回聊天窗口，也会触发Window State Changed，但无法判断红包是否已领取，所以又会触发一次点击红包事件，最终进红包详情页。
 */
public class QiangHongBaoService extends AccessibilityService {

    static final String TAG = "QiangHongBao";

    /** 微信的包名*/
    static final String WX_PACKAGE_NAME = "com.tencent.mm";
    /** 红包消息的关键字*/
    static final String RED_PACKET_TEXT_KEY = "[微信红包]";

    Handler handler = new Handler();

    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {
        final int eventType = event.getEventType();

        Log.d(TAG, "onAccessibilityEvent " + event);

        //通知栏事件
        if(eventType == AccessibilityEvent.TYPE_NOTIFICATION_STATE_CHANGED) {
            List<CharSequence> texts = event.getText();
            if(!texts.isEmpty()) {
                for(CharSequence t : texts) {
                    String text = String.valueOf(t);
                    if(text.contains(RED_PACKET_TEXT_KEY)) {
                        openNotify(event);
                        break;
                    }
                }
            }
        } else if(eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
            openRedPacket(event);
        }
    }

    @Override
    public void onInterrupt() {
        Toast.makeText(this, "抢红包服务关闭", Toast.LENGTH_LONG).show();
    }

    @Override
    protected void onServiceConnected() {
        super.onServiceConnected();
        Toast.makeText(this, "已启动抢红包服务", Toast.LENGTH_LONG).show();
    }

    /** 打开通知栏消息*/
    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    private void openNotify(AccessibilityEvent event) {
        if(event.getParcelableData() == null || !(event.getParcelableData() instanceof Notification)) {
            return;
        }
        // 将微信的通知栏消息打开
        Notification notification = (Notification) event.getParcelableData();
        PendingIntent pendingIntent = notification.contentIntent;
        try {
            Log.d(TAG, "To Open Notification.");
            pendingIntent.send();
        } catch (PendingIntent.CanceledException e) {
            e.printStackTrace();
        }
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    private void openRedPacket(AccessibilityEvent event) {
        Log.d(TAG, "Red Packet Event: " + event.toString());
        if ("com.tencent.mm.plugin.luckymoney.ui.LuckyMoneyReceiveUI".equals(event.getClassName())) {
            //点中了红包，下一步就是去拆红包
            Log.d(TAG, "Now Change into Red Packet Dialog.");
            checkRedPacketDialog();
        } else if ("com.tencent.mm.plugin.luckymoney.ui.LuckyMoneyDetailUI".equals(event.getClassName())) {
            //拆完红包后看详细的纪录界面
        } else if ("com.tencent.mm.ui.LauncherUI".equals(event.getClassName())) {
            //在聊天界面,去点中红包
            Log.d(TAG, "Now Change into Chat Window. Looking for Red Packet Item.");
            checkRedPacketInChat();
        }
    }

    private Runnable checkNoResultAfterClickButton = new Runnable() {
        @Override
        @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
        public void run() {
            AccessibilityNodeInfo nodeInfo = getRootInActiveWindow();
            if(nodeInfo == null) {
                return;
            }

            Log.d(TAG, "To Check whether Over after Click Open RedPacket Button.");
            List<AccessibilityNodeInfo> list = nodeInfo.findAccessibilityNodeInfosByText("手慢了，红包派完了");
            if (!list.isEmpty())
            {
                // 弹出对话框还没点时就出现此文字
                Log.d(TAG, "Over After Click Open RedPacket.");

                // 点击查看详情
                list = nodeInfo.findAccessibilityNodeInfosByText("看看大家的手气");
                if ( !list.isEmpty()) {
                    for (AccessibilityNodeInfo n : list) {
                        Log.d(TAG, "To Click the Red Packet List Record from Dialog.");
                        n.performAction(AccessibilityNodeInfo.ACTION_CLICK);
                    }
                }
                else
                {
                    list = nodeInfo.findAccessibilityNodeInfosByText("查看领取详情");
                    if ( !list.isEmpty()) {
                        for (AccessibilityNodeInfo n : list) {
                            Log.d(TAG, "To Click the Red Packet Detail Record from Dialog.");
                            n.performAction(AccessibilityNodeInfo.ACTION_CLICK);
                        }
                    }
                    else
                        Log.d(TAG, "No Details Text Found. Maybe Got Red Packet and Enter Details Directly.");
                }
            }
        }
    };

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    private void checkRedPacketDialog() {
        AccessibilityNodeInfo nodeInfo = getRootInActiveWindow();
        if(nodeInfo == null) {
            return;
        }

        List<AccessibilityNodeInfo> list = nodeInfo.findAccessibilityNodeInfosByText("手慢了，红包派完了");
        if (!list.isEmpty())
        {
            // 弹出对话框还没点时就出现此文字
            Log.d(TAG, "Already Over when Dialog Popup.");

            // 点击查看详情
            list = nodeInfo.findAccessibilityNodeInfosByText("看看大家的手气");
            for(AccessibilityNodeInfo n : list) {
                Log.d(TAG, "To Click the Red Packet List Record from Dialog.");
                n.performAction(AccessibilityNodeInfo.ACTION_CLICK);
            }
        }

        list = nodeInfo.findAccessibilityNodeInfosByText("拆红包");
        for(AccessibilityNodeInfo n : list) {
            Log.d(TAG, "To Click the Open Red Packet Button in Dialog.");
            n.performAction(AccessibilityNodeInfo.ACTION_CLICK);
            // 点击“拆红包”按钮后如果没有抢到，则收不到任何Event，因为连“加载中”的浮层都没弹出来
            handler.removeCallbacks(checkNoResultAfterClickButton);
            handler.postDelayed(checkNoResultAfterClickButton, 4000);
        }
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    private void checkRedPacketInChat() {
        AccessibilityNodeInfo nodeInfo = getRootInActiveWindow();
        if(nodeInfo == null) {
            return;
        }
        List<AccessibilityNodeInfo> list = nodeInfo.findAccessibilityNodeInfosByText("领取红包");
        if(!list.isEmpty()) {
            // 聊天窗口中，红包 Item 的文字“领取红包”
            for(int i = list.size() - 1; i >= 0; i --) {
                AccessibilityNodeInfo parent = list.get(i).getParent();
                Log.d(TAG, "To Click the Red Packet Item in Chat Window: " + parent);
                if (parent != null) {
                    parent.performAction(AccessibilityNodeInfo.ACTION_CLICK);
                    break;
                }
            }
        } else {
            list = nodeInfo.findAccessibilityNodeInfosByText(RED_PACKET_TEXT_KEY);// [微信红包] 四个字哪儿来的？
            for (AccessibilityNodeInfo n : list) {
                n.performAction(AccessibilityNodeInfo.ACTION_CLICK);
                break;
            }
        }
    }
}
