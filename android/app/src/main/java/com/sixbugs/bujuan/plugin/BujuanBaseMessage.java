package com.sixbugs.bujuan.plugin;

import android.app.Activity;

import com.sixbugs.bujuan.Config;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.view.FlutterView;

public class BujuanBaseMessage implements BasicMessageChannel.MessageHandler<Object> {

    public  BasicMessageChannel<Object> messageChannel;

    public  static BujuanBaseMessage registerWith(FlutterView flutterView) {
        return new BujuanBaseMessage(flutterView);
    }

    private BujuanBaseMessage(FlutterView flutterView) {
        this.messageChannel = new BasicMessageChannel<Object>(flutterView, Config.URL_FM_CHANNEL, StandardMessageCodec.INSTANCE);
//        messageChannel.setMessageHandler(this);
    }

    @Override
    public void onMessage(Object message, BasicMessageChannel.Reply<Object> reply) {

    }


//    @Override
//    public void onMessage(String s, BasicMessageChannel.Reply<String> reply) {
//        reply.reply("BasicMessageChannelPlugin收到：" + s);
//
//    }
//
//    void send(String str, BasicMessageChannel.Reply<String> reply) {
//        messageChannel.send(str, reply);
//    }
}
