import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/constant/theme.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/state.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayView2State implements GlobalBaseState, Cloneable<PlayView2State> {
  List<SongBeanEntity> songList;
  bool isMinni;
  bool showSelect ;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  PlayView2State clone() {
    return PlayView2State()
      ..currSongPos = currSongPos
      ..currSongAllPos = currSongAllPos
      ..playModeType = playModeType
      ..currSong = currSong
      ..isMinni = isMinni
      ..showSelect = showSelect
      ..scaffoldKey = scaffoldKey
      ..songList = songList;
  }

  @override
  AppTheme appTheme;

  @override
  SongBeanEntity currSong;

  @override
  PlayStateType playStateType;

  @override
  int currSongPos;

  @override
  int currSongAllPos;

  @override
  LyricEntity lyric;

  @override
  PlayModeType playModeType;

  @override
  String backPath;

  @override
  double blur;
}

PlayView2State initState(Map<String, dynamic> args) {
  var playViewState = PlayView2State();
  var objectList = SpUtil.getObjectList(playSongListHistory);
  List<SongBeanEntity> songs = List();
  objectList.forEach((Map map) {
    songs.add(SongBeanEntity.fromJson(map));
  });
  playViewState.songList = songs;
  playViewState.isMinni = SpUtil.getBool(MINI_PLAY, defValue: false);
  playViewState.showSelect =false;
  playViewState.scaffoldKey =  GlobalKey();
  return playViewState;
}
