import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'song_info.dart';

enum PlayState { START, PAUSE, STOP, ERROR }

typedef Future<String> GetSongUrl (String id);

class SongUrl {
  GetSongUrl getSongUrl;

  SongUrl({this.getSongUrl});
}

class FlutterStarrySky {
  static MethodChannel _channel;
  static String playListId = '';
  static final FlutterStarrySky _netUtils = FlutterStarrySky._internal(); //1
  factory FlutterStarrySky() {
    if (_channel == null) _channel = const MethodChannel('flutter_starry_sky');
    return _netUtils;
  }

  FlutterStarrySky._internal();

  //歌曲播放状态
  final StreamController<PlayState> _playerStateController = StreamController<
      PlayState>.broadcast();

  Stream<PlayState> get onPlayerStateChanged => _playerStateController.stream;

  //当前播放歌曲
  final StreamController<SongInfo> _playerSongController = StreamController<
      SongInfo>.broadcast();

  Stream<SongInfo> get onPlayerSongChanged => _playerSongController.stream;

  //当前播放進度
  final StreamController<int> _playerSongPositionController = StreamController<
      int>.broadcast();

  Stream<int> get onPlayerSongPositionChanged => _playerSongPositionController.stream;

  SongUrl songUrl;

  MethodChannel getChannel() {
    return _channel;
  }


  String getPlayListId() {
    return playListId;
  }

  //初始化音乐监听
  Future<String> init({SongUrl songUrl}) async {
    this.songUrl = songUrl;
    final String init = await _channel.invokeMethod('init');
    _channel.setMethodCallHandler((call) => _platformCallHandler(call));
    return init;
  }

  Future<dynamic> _platformCallHandler(MethodCall call) async {
    var method = call.method;
    var arguments = call.arguments;
    if (method == 'currSong') {
      var songInfo = SongInfo.fromJson(jsonDecode(arguments));
      _playerSongController.add(songInfo);
    } else if (method == 'getUrl') {
      return songUrl?.getSongUrl(arguments);
    } else if (method == 'state') {
      if (arguments == 'start') {
        _playerStateController.add(PlayState.START);
      } else if (arguments == 'stop') {
        _playerStateController.add(PlayState.STOP);
      } else if (arguments == 'pause' || arguments == 'completion') {
        _playerStateController.add(PlayState.PAUSE);
      }
    }else if(method=='playPosition'){
      _playerSongPositionController.add(arguments);
//      print('獲取當前播放進度===========$arguments');
    }
  }

  //更新播放列表并播放
  Future<void> setPlayListAndPlayById(List<SongInfo> playList, int index,
      String id) async {
    if (playList != null && playList.length > 0) {
      if (playListId == id) {
        await _playSongByIndex(index);
        print('object====该歌单正在播放中，直接_playSongById');
      } else {
        print('object====该歌单未播放，先_setPlayList再_playSongById');
        await _setPlayListAndPlayByIndex(playList);
        await _playSongByIndex(index);
        playListId = id;
      }
    }
  }

  //更新播放列表
  Future<int> _setPlayListAndPlayByIndex(List<SongInfo> playList) async {
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

//根据id播放歌曲
  Future<int> _playSongByIndex(index) async {
    //返回當前狀態
    print('======根据id播放');
    var state = await _channel.invokeMethod('playSongByIndex', index);
    return state;
  }

  //根据songInfo播放歌曲
  Future<int> playSongByData(SongInfo data) async {
    return await _channel.invokeMethod('playSongByData', data);
  }

  //获取播放列表
  Future<List<SongInfo>> getPlayList() async {
    var playListStr = await _channel.invokeMethod('getPlayList');
    if (playListStr == '') {
      return null;
    } else {
      var songList = jsonDecode(playListStr);
      List<SongInfo> infos = [];
      await Future.forEach(
          songList, (song) => infos.add(SongInfo.fromJson(song)));
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
