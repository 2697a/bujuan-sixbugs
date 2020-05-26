import 'dart:async';
import 'dart:convert';

import 'package:bujuan/plugin/song_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum PlayState{
  START,PAUSE,STOP,ERROR
}
class FlutterStarrySky {
  static const MethodChannel _channel = const MethodChannel('flutter_starry_sky');
  static ValueNotifier<PlayState> state = ValueNotifier<PlayState>(PlayState.STOP);
  //初始化音乐监听
  static Future<String> init() async {
    final String init = await _channel.invokeMethod('init');
    _channel.setMethodCallHandler((call) => _platformCallHandler(call));
    return init;
  }
  static Future<dynamic> _platformCallHandler(MethodCall call) async {
    print('object==========${call.method}======${call.arguments.toString()}');
  }
  //更新播放列表并播放
  static Future<int> setPlayListAndPlay(List<SongInfo> playList) async {
    var songData = jsonEncode(playList);
    return await _channel.invokeMethod('setPlayList', songData);
  }

  //更新播放列表
  static Future<int> setPlayList(List<SongInfo> playList) async {
    var songData = jsonEncode(playList);
    return await _channel.invokeMethod('setPlayList', songData);
  }

  //根据id播放歌曲
  static Future<int> playSongById(id) async {
    return await _channel.invokeMethod('playSongById', id);
  }

  //根据songInfo播放歌曲
  static Future<int> playSongByData(SongInfo data) async {
    return await _channel.invokeMethod('playSongByData', data);
  }

  //获取播放列表
  static Future<List<SongInfo>> getPlayList() async {
    var playListStr = await _channel.invokeMethod('getPlayList');
    var songList = jsonDecode(playListStr);
    List<SongInfo> infos = [];
    await Future.forEach(songList, (song) => infos.add(SongInfo.fromJson(song)));
    return infos;
  }

  //下一首
  static Future<int> next() async {
    return await _channel.invokeMethod('next');
  }
  //上一首
  static Future<int> previous() async {
    return await _channel.invokeMethod('previous');
  }
  //暂停
  static Future<int> pause() async {
    return await _channel.invokeMethod('pause');
  }
  //播放
  static Future<int> restore() async {
    return await _channel.invokeMethod('restore');
  }
  //停止
  static Future<int> stop() async {
    return await _channel.invokeMethod('stop');
  }
  //跳转播放进度

  static Future<void> dispose() async {
    await _channel.invokeMethod('dispose');
  }
}
