//import 'dart:async';
//import 'dart:convert';
//
//import 'package:bujuan/global_store/action.dart';
//import 'package:bujuan/global_store/store.dart';
//import 'package:bujuan/net/net_utils.dart';
//import 'package:bujuan/plugin/song_info.dart';
//import 'package:bujuan/utils/bujuan_util.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//
//enum PlayState{
//  START,PAUSE,STOP,ERROR
//}
//class FlutterStarrySky {
//  static  MethodChannel _channel;
//  static final FlutterStarrySky _netUtils = FlutterStarrySky._internal(); //1
//  factory FlutterStarrySky() {
//    if(_channel==null)_channel = const MethodChannel('flutter_starry_sky');
//    return _netUtils;
//  }
//  FlutterStarrySky._internal();
//
//   ValueNotifier<PlayState> state = ValueNotifier<PlayState>(PlayState.STOP);
//  //初始化音乐监听
//   Future<String> init() async {
//    final String init = await _channel.invokeMethod('init');
//    _channel.setMethodCallHandler((call) => _platformCallHandler(call));
//    return init;
//  }
//   Future<dynamic> _platformCallHandler(MethodCall call) async {
//     var method = call.method;
//     print('object==========${method}======${call.arguments.toString()}');
//     var arguments = call.arguments;
//     if(method=='currSong'){
//       if(arguments!=null) await GlobalStore.store
//           .dispatch(GlobalActionCreator.changeCurrSong(SongInfo.fromJson(jsonDecode(arguments))));
//     }else if(method=='getUrl'){
//       return await NetUtils().getSongUrl(arguments);
//     }
//   }
//  //更新播放列表并播放
//   Future<int> setPlayListAndPlay(List<SongInfo> playList) async {
//    var songData = jsonEncode(playList);
//    return await _channel.invokeMethod('setPlayList', songData);
//  }
//
//  //更新播放列表
//   Future<int> setPlayList(List<SongInfo> playList) async {
//    var songData = jsonEncode(playList);
//    return await _channel.invokeMethod('setPlayList', songData);
//  }
//
//  //根据id播放歌曲
//   Future<int> playSongById(SongInfo songInfo) async {
//     //返回當前狀態
//    var state = await _channel.invokeMethod('playSongById', songInfo.songId);
//    if(state==0) GlobalStore.store
//      .dispatch(GlobalActionCreator.changeCurrSong(songInfo));
//    return state;
//  }
//
//  //根据songInfo播放歌曲
//   Future<int> playSongByData(SongInfo data) async {
//    return await _channel.invokeMethod('playSongByData', data);
//  }
//
//  //获取播放列表
//   Future<List<SongInfo>> getPlayList() async {
//    var playListStr = await _channel.invokeMethod('getPlayList');
//    var songList = jsonDecode(playListStr);
//    List<SongInfo> infos = [];
//    await Future.forEach(songList, (song) => infos.add(SongInfo.fromJson(song)));
//    return infos;
//  }
//
//  //下一首
//   Future<int> next() async {
//    return await _channel.invokeMethod('next');
//  }
//  //上一首
//   Future<int> previous() async {
//    return await _channel.invokeMethod('previous');
//  }
//  //暂停
//   Future<int> pause() async {
//    return await _channel.invokeMethod('pause');
//  }
//  //播放
//   Future<int> restore() async {
//    return await _channel.invokeMethod('restore');
//  }
//  //停止
//   Future<int> stop() async {
//    return await _channel.invokeMethod('stop');
//  }
//  //跳转播放进度
//
//   Future<void> dispose() async {
//    await _channel.invokeMethod('dispose');
//  }
//}
