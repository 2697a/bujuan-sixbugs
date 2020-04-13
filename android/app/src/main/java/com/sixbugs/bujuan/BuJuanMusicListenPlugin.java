package com.sixbugs.bujuan;

import android.app.Activity;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;

public class BuJuanMusicListenPlugin implements EventChannel.StreamHandler {

    public static String CHANNEL = "com.sixbugs.bujuan/music";

    static EventChannel channel;

    public EventChannel.EventSink eventSink;

    private Activity activity;

    private BuJuanMusicListenPlugin(Activity activity) {
        this.activity = activity;
    }

    public static BuJuanMusicListenPlugin registerWith(PluginRegistry.Registrar registrar) {
        channel = new EventChannel(registrar.messenger(), CHANNEL);
        BuJuanMusicListenPlugin instance = new BuJuanMusicListenPlugin(registrar.activity());
        channel.setStreamHandler(instance);
        return  instance;
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        this.eventSink = eventSink;
    }

    @Override
    public void onCancel(Object o) {

    }
}
