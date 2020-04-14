import 'dart:async';

import 'package:flutter/services.dart';

class BujuanMusic {
  static const MethodChannel _channel = const MethodChannel('music_plugin');
//  com.sixbugs.bujuan/music_play
//  static const counterPlugin = const EventChannel('com.sixbugs.bujuan/music');

//  static const playPlugin = const EventChannel('com.sixbugs.bujuan/music_play');

//  url_fm_plugin

//  static Stream getStream() {
//    Stream stream;
//    if (stream == null) {
//      stream = counterPlugin.receiveBroadcastStream();
//    }
//    return stream;
//  }
//  static Stream getPlayStream() {
//    Stream stream;
//    if (stream == null) {
//      stream = playPlugin.receiveBroadcastStream();
//    }
//    return stream;
//  }
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future sendSongInfo({String songInfo, int index}) async {
    return await _channel
        .invokeMethod("songInfo", {'readList': songInfo, 'playIndex': index});
  }

  static Future control({String task}) async {
    return await _channel.invokeMethod("control", {'task': task});
  }

  static Future setMode(int mode) async {
    return await _channel.invokeMethod("playMode", {'mode': mode});
  }
  static Future<String> local() async {
    return await _channel.invokeMethod("local_music");
  }
  static Future seekTo(seekNum) async{
    return await _channel.invokeMethod("seekTo", {'seekNum': seekNum});
  }
  static Future playSingleSong({int index}) async {
    return await _channel.invokeMethod("playSingleSong", {'index': index});
  }

}
