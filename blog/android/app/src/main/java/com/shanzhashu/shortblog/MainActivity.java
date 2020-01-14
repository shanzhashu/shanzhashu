package com.shanzhashu.shortblog;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.media.Image;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.support.v7.app.AlertDialog;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.security.PrivateKey;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class MainActivity extends Activity {

    private static final String TAG = BlogConst.TAG;

    private ImageView btnAdd;
    private TextView txtHead;
    private ImageView btnBack;
    private ImageView btnSearch;

    private ListView lvList;

    private String draft;
    private String queryStr;
    private ProgressDialog mProgress;

    private void showProgress()
    {
        if (mProgress == null)
            mProgress = new ProgressDialog(this);
        mProgress.setMessage("请等待……");
        if (!mProgress.isShowing())
            mProgress.show();
    }

    private void hideProgress()
    {
        if (mProgress != null) {
            mProgress.dismiss();
            mProgress = null;
        }
    }

    private void showToast(String text)
    {
        Toast.makeText(this, text, Toast.LENGTH_LONG).show();
    }

    private void updateCaption(int count)
    {
        if (txtHead != null)
        {
            txtHead.setText("Short Blog (" + count + ")");
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mQueue = Volley.newRequestQueue(this);

        btnBack = (ImageView)findViewById(R.id.head_title_backimage);
        btnBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        btnAdd = (ImageView)findViewById(R.id.head_title_add);
        btnAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                View dialog = View.inflate(MainActivity.this, R.layout.dialog_add, null);
                final EditText addText = (EditText)dialog.findViewById(R.id.add_content);

                if (!TextUtils.isEmpty(draft))
                    addText.setText(draft);

                new AlertDialog.Builder(MainActivity.this)
                        .setTitle("发布一条新的")
                        .setIcon(android.R.drawable.ic_dialog_info)
                        .setView(dialog)
                        .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                String url = BlogConst.URL_POST + "?session=" + generateSeedSession();
                                StringRequest sr = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                                    @Override
                                    public void onResponse(String s) {
                                        hideProgress();
                                        Log.d(TAG, "onResponse Add " + s);
                                        if (s.startsWith("Success"))
                                        {
                                            showToast("发帖成功！");
                                            loadItemByPage(0, true);
                                            draft = "";
                                        }
                                        else {
                                            showToast("发帖失败：" + s);
                                            draft = addText.getText().toString();
                                        }
                                    }
                                }, new Response.ErrorListener() {
                                    @Override
                                    public void onErrorResponse(VolleyError volleyError) {
                                        hideProgress();
                                        Log.d(TAG, "onErrorResponse " + volleyError.toString());
                                        draft = addText.getText().toString();
                                        showToast("倒霉，发帖失败：" + volleyError.toString());
                                    }
                                }) {
                                    @Override
                                    protected Map<String, String> getParams() {
                                        Map<String, String> params = new HashMap<String, String>();
                                        params.put("content", addText.getText().toString());

                                        return params;
                                    }

                                    @Override
                                    public Map<String, String> getHeaders() throws AuthFailureError {
                                        Map<String, String> params = new HashMap<String, String>();
                                        params.put("Content-Type", "application/x-www-form-urlencoded");
                                        return params;
                                    }

                                };

                                showProgress();
                                MyX509TrustManager.allowAllSSL();

                                sr.setRetryPolicy(new DefaultRetryPolicy(BlogConst.TIME_OUT,
                                                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                                                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
                                mQueue.add(sr);
                            }
                        })
                        .setNegativeButton("取消", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                draft = addText.getText().toString();
                            }
                        })
                        .show();
            }
        });

        lvList = (ListView)findViewById(R.id.listview_msg);
        lvList.setAdapter(mAdapter);
        View footer = View.inflate(this, R.layout.foot_load_more, null);
        lvList.addFooterView(footer);
        Button btnLoad = (Button)footer.findViewById(R.id.button_load_more);
        btnLoad.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                loadItemByPage(mCurrentPage, false);
            }
        });
        // lvList.setEmptyView();

        txtHead = (TextView)findViewById(R.id.head_title_text);
        txtHead.setClickable(true);
        txtHead.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d(TAG, "onClick to Load page " + mCurrentPage);
                loadItemByPage(0, true);

            }
        });

        btnSearch = (ImageView)findViewById(R.id.button_search);
        btnSearch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                View dialog = View.inflate(MainActivity.this, R.layout.dialog_search, null);
                final EditText searchText = (EditText)dialog.findViewById(R.id.search_content);

                new AlertDialog.Builder(MainActivity.this)
                        .setTitle("查找")
                        .setIcon(android.R.drawable.ic_dialog_info)
                        .setView(dialog)
                        .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                queryStr = searchText.getText().toString();
                                loadItemByPage(0, false);
                            }
                        })
                        .setNegativeButton("取消", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                            }
                        })
                        .show();
            }
        });
    }

    @Override
    protected void onRestoreInstanceState(Bundle savedInstanceState) {
        super.onRestoreInstanceState(savedInstanceState);
        draft = savedInstanceState.getString("Draft");
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        outState.putString("Draft", draft);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        // getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    private static final class ViewHolder {
        public TextView tvTime;
        public TextView tvId;
        public TextView tvContent;
        public TextView tvWeek;
        public ImageView imDelete;
    }

    private class MsgAdapter extends BaseAdapter{

        @Override
        public int getCount() {
            return mList.size();
        }

        @Override
        public Object getItem(int position) {
            return null;
        }

        @Override
        public long getItemId(int position) {
            return 0;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            final ViewHolder holder;
            //Log.d(TAG, "getView " + position);

            if (convertView == null)
            {
                convertView = LayoutInflater.from(MainActivity.this).inflate(R.layout.list_item, null);
                holder = new ViewHolder();
                holder.tvId = (TextView) convertView.findViewById(R.id.textview_id);
                holder.tvTime = (TextView)convertView.findViewById(R.id.textview_time);
                holder.tvContent = (TextView)convertView.findViewById(R.id.textview_content);
                holder.tvWeek = (TextView)convertView.findViewById(R.id.textview_week);
                holder.imDelete = (ImageView)convertView.findViewById(R.id.imageview_delete);

                convertView.setTag(holder);
            }
            else
                holder = (ViewHolder)convertView.getTag();

            String s;
            s = mList.get(position).getId();
            holder.tvId.setText("#" + s);
            s = mList.get(position).getTime();
            holder.tvTime.setText(s);
            s = mList.get(position).getContent();
            holder.tvContent.setText(s);
            s = mList.get(position).getWeek();
            holder.tvWeek.setText(s);

            holder.tvContent.setOnLongClickListener(new View.OnLongClickListener() {
                @Override
                public boolean onLongClick(View v) {
                    ClipboardManager clipboardManager = (ClipboardManager)getSystemService(Context.CLIPBOARD_SERVICE);
                    clipboardManager.setPrimaryClip(ClipData.newPlainText(null, holder.tvContent.getText()));
                    showToast("已复制到剪贴板");
                    return false;
                }
            });
            holder.imDelete.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    new AlertDialog.Builder(MainActivity.this)
                            .setTitle("提示")
                            .setIcon(android.R.drawable.ic_dialog_info)
                            .setMessage("是否确定删除 " + holder.tvId.getText() + "?")
                            .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    String delid = holder.tvId.getText().toString();
                                    if (delid.startsWith("#"))
                                        delid = delid.substring(1, delid.length());
                                    String url = BlogConst.URL_DELETE + "?session=" + generateSeedSession() + "&delid=" + delid;
                                    //Log.d(TAG, url);

                                    final String fdelid = delid;
                                    StringRequest sr = new StringRequest(url, new Response.Listener<String>() {
                                        @Override
                                        public void onResponse(String s) {
                                            hideProgress();
                                            Log.d(TAG, "onResponse Delete " + s);
                                            if (s.startsWith("Success")) {
                                                showToast("删除成功");
                                                mList.removeBeanById(fdelid);
                                                mAdapter.notifyDataSetChanged();
                                                updateCaption(mList.size());
                                            } else
                                                showToast("删除失败：#" + fdelid);
                                        }
                                    }, new Response.ErrorListener() {
                                        @Override
                                        public void onErrorResponse(VolleyError volleyError) {
                                            hideProgress();
                                            showToast("删除失败：" + volleyError.toString());
                                        }
                                    });

                                    showProgress();
                                    MyX509TrustManager.allowAllSSL();
                                    sr.setRetryPolicy(new DefaultRetryPolicy(BlogConst.TIME_OUT,
                                            DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                                            DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
                                    mQueue.add(sr);
                                }
                            })
                            .setNegativeButton("取消", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    ;
                                }
                            })
                            .show();
                }
            });

            return convertView;
        }
    }

    private int mCurrentPage = 0;
    private MsgList mList = new MsgList();
    private MsgAdapter mAdapter = new MsgAdapter();
    private RequestQueue mQueue;

    private String generateSeedSession()
    {
//        char[] cs = s.toCharArray();
//        cs[5] = '6';
//        s = cs.toString();
        return BlogConst.SESSION_ID1 + BlogConst.SESSION_ID2;
    }

    private void loadItemByPage(int page, final boolean fromHead)
    {
        String s = generateSeedSession();
        if (fromHead)
            page = 0;
        String url = BlogConst.URL_INDEX + "?session=" + s + "&page=" + page;
        if (!TextUtils.isEmpty(queryStr)) {
            url = url + "&q=" + queryStr;
            // Log.d(TAG, "to Search " + queryStr);
        }
        //Log.d(TAG, "URL: " + url);

        Utf8StringRequest jar = new Utf8StringRequest(url, new Response.Listener<String>() {
            @Override
            public void onResponse(String res) {
                //Log.d(TAG, "onResponse " + res);
                hideProgress();

                try {
                    JSONArray arr = new JSONArray(res);
                    Log.d(TAG, "Get Size " + arr.length());
                    if (arr.length() > 0) {
                        if (!fromHead)
                            mCurrentPage++;
                    }
                    else
                    {
                        showToast("无更多数据。");
                        return;
                    }

                    int i;
                    for (i=0;i<arr.length();i++)
                    {
                        JSONObject obj = arr.getJSONObject(i);
                        MsgBean bean = new MsgBean();
                        bean.setId(obj.optString(MsgBean.F_ID));
                        bean.setTime(obj.optString(MsgBean.F_TIME));
                        bean.setContent(obj.optString(MsgBean.F_CONTENT));

                        mList.insertBean(bean);
                    }
                    mList.sortBeans();
                    Log.d(TAG, "Got Msgs " + mList.size());
                    mAdapter.notifyDataSetChanged();
                    updateCaption(mList.size());

                } catch (JSONException e) {
                    showToast("解析失败：" + res);
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError volleyError) {
                Log.e(TAG, "onErrorResponse" + volleyError.toString());
                showToast("刷新出错：" + volleyError.toString());
                hideProgress();
            }
        });
        showProgress();
        MyX509TrustManager.allowAllSSL();
        jar.setRetryPolicy(new DefaultRetryPolicy(BlogConst.TIME_OUT,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        mQueue.add(jar);
    }
}
