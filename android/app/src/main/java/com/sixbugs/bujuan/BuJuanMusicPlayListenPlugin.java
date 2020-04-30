package com.sixbugs.bujuan;

import android.app.Activity;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;

public class BuJuanMusicPlayListenPlugin implements EventChannel.StreamHandler  {

    public static String CHANNEL = "com.sixbugs.bujuan/music_play";

    static EventChannel channel;

    public EventChannel.EventSink event;

    private Activity activity;

    private BuJuanMusicPlayListenPlugin(Activity activity) {
        this.activity = activity;
    }

    public static BuJuanMusicPlayListenPlugin  registerWith(PluginRegistry.Registrar registrar) {
        channel = new EventChannel(registrar.messenger(), CHANNEL);
        BuJuanMusicPlayListenPlugin instance = new BuJuanMusicPlayListenPlugin(registrar.activity());
        channel.setStreamHandler(instance);
        return  instance;
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        this.event = eventSink;
    }

    @Override
    public void onCancel(Object o) {

    }
}
