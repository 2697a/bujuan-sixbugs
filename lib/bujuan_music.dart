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
  static Future<String> fm(fmSongs) async {
    return await _channel.invokeMethod("fm",{'fmList':fmSongs});
  }
  static Future seekTo(seekNum) async{
    return await _channel.invokeMethod("seekTo", {'seekNum': seekNum});
  }
  static Future playIndex({int index}) async {
    return await _channel.invokeMethod("playIndex", {'index': index});
  }
  static Future lyric(dark) async {
    return await _channel.invokeMethod("lyric", {'dark': dark});
  }

}
