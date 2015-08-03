package com.shanzhashu.shortblog;

import com.android.volley.NetworkResponse;
import com.android.volley.Response;
import com.android.volley.toolbox.HttpHeaderParser;
import com.android.volley.toolbox.StringRequest;

import java.io.UnsupportedEncodingException;

/**
 * Created by LIUXIAO950 on 2015-08-03.
 */
public class Utf8StringRequest extends StringRequest {

    public Utf8StringRequest(int method, String url, Response.Listener<String> listener, Response.ErrorListener errorListener) {
        super(method, url, listener, errorListener);
    }

    public Utf8StringRequest(String url, Response.Listener<String> listener, Response.ErrorListener errorListener) {
        this(0, url, listener, errorListener);
    }

    protected Response<String> parseNetworkResponse(NetworkResponse response) {
        String parsed;
        try {
            parsed = new String(response.data, "utf-8");
        } catch (UnsupportedEncodingException var4) {
            parsed = new String(response.data);
        }

        return Response.success(parsed, HttpHeaderParser.parseCacheHeaders(response));
    }
}
