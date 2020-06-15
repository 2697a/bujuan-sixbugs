import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'song_info.dart';

enum PlayState{
  START,PAUSE,STOP,ERROR
}
class FlutterStarrySky {
  static  MethodChannel _channel;
  static String playListId = '';
  static final FlutterStarrySky _netUtils = FlutterStarrySky._internal(); //1
  factory FlutterStarrySky() {
    if(_channel==null)_channel = const MethodChannel('flutter_starry_sky');
    return _netUtils;
  }
  FlutterStarrySky._internal();

  ValueNotifier<PlayState> state = ValueNotifier<PlayState>(PlayState.STOP);

  MethodChannel getChannel(){
    return _channel;
  }
  String getPlayListId(){
    return playListId;
  }
  //初始化音乐监听
  Future<String> init() async {
    final String init = await _channel.invokeMethod('init');
    return init;
  }


  //更新播放列表并播放
  Future<void> setPlayListAndPlayById(List<SongInfo> playList,SongInfo songInfo,String id) async {
    if(playList!=null&&playList.length>0){
        if(playListId==id) {
          await _playSongById(songInfo);
          print('object====该歌单正在播放中，直接_playSongById');
        } else{
          print('object====该歌单未播放，先_setPlayList再_playSongById');
          await _setPlayList(playList);
          await _playSongById(songInfo);
          playListId = id;
        }
    }
  }

  //更新播放列表
  Future<int> _setPlayList(List<SongInfo> playList) async {
    var songData = jsonEncode(playList);
    return await _channel.invokeMethod('setPlayList', songData);
  }

  //根据id播放歌曲
  Future<int> _playSongById(SongInfo songInfo) async {
    //返回當前狀態
    print('======根据id播放');
    var state = await _channel.invokeMethod('playSongById', songInfo.songId);
    return state;
  }

  //根据songInfo播放歌曲
  Future<int> playSongByData(SongInfo data) async {
    return await _channel.invokeMethod('playSongByData', data);
  }

  //获取播放列表
  Future<List<SongInfo>> getPlayList() async {
    var playListStr = await _channel.invokeMethod('getPlayList');
    if(playListStr==''){
      return null;
    }else{
      var songList = jsonDecode(playListStr);
      List<SongInfo> infos = [];
      await Future.forEach(songList, (song) => infos.add(SongInfo.fromJson(song)));
      return infos;
    }
  }

  //下一首
  Future<int> next() async {
    return await _channel.invokeMethod('next');
  }
  //上一首
  Future<int> previous() async {
    return await _channel.invokeMethod('previous');
  }
  //暂停
  Future<int> pause() async {
    return await _channel.invokeMethod('pause');
  }
  //播放
  Future<int> restore() async {
    return await _channel.invokeMethod('restore');
  }
  //停止
  Future<int> stop() async {
    return await _channel.invokeMethod('stop');
  }
  //跳转播放进度

  Future<void> dispose() async {
    await _channel.invokeMethod('dispose');
  }
}
