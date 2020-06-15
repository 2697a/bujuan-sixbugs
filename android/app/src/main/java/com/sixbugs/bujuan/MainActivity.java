package com.sixbugs.bujuan;

import androidx.annotation.NonNull;


import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    public static MainActivity activity;
    private String zhLyric = "";
    private String enLyric = "";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        activity = this;
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        String CHANNEL = "android/back/desktop";
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                (methodCall, result) -> {
                    if (methodCall.method.equals("backDesktop")) {
                        result.success(true);
                        moveTaskToBack(false);
                    }
                }
        );
    }

//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        GeneratedPluginRegistrant.registerWith(this);
//        activity = this;
//        FlutterStarrySkyPlugin.registerWith(this.registrarFor("flutter_starry_sky"));
//        //通讯名称,回到手机桌面
//
//    }






    @Override
    protected void onDestroy() {
        super.onDestroy();
    }
}
