package com.sixbugs.bujuan;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.widget.TextView;

import com.sixbugs.bujuan.entity.Lyric;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class LyricView implements PlatformView, MethodChannel.MethodCallHandler{
    private final TextView natvieTextView;
    Context context;
    public LyricView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
        this.context = context;
        TextView myNativeView = new TextView(context);
        myNativeView.setText("我是来自Android的原生TextView");
        if (params.containsKey("myContent")) {
            String myContent = (String) params.get("myContent");
            myNativeView.setText(myContent);
        }
        this.natvieTextView = myNativeView;
        MethodChannel methodChannel = new MethodChannel(messenger, "plugins.nightfarmer.top/myview_" + id);
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public View getView() {
        return natvieTextView;
    }

    @Override
    public void dispose() {

    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if ("setText".equals(call.method)) {
            String text = (String) call.arguments;
            natvieTextView.setText(text);
            result.success(null);
            Intent intent = new Intent();
            intent.setClass(context, LyricActivity.class);
            context.startActivity(intent);
        }
    }
}
