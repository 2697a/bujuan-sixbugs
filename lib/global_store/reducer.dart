import 'dart:convert';
import 'dart:ui';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/theme.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeThemeColor: _onchangeThemeColor,
      GlobalAction.changePlayState: _onchangePlayState,
      GlobalAction.changeCurrSong: _onchangeCurrSong,
      GlobalAction.changeSongPos: _onchangeSongPos,
      GlobalAction.changeSongAllPos: _onchangeSongAllPos,
      GlobalAction.changeLyric: _onchangeLyric,
      GlobalAction.changePlayMode: _changePlayMode,
      GlobalAction.changeBack: _changeBack,
      GlobalAction.changeBlur: _changeBlur
    },
  );
}

List<Color> _colors = <Color>[
  Colors.green,
  Colors.red,
  Colors.black,
  Colors.blue
];

GlobalState _onchangeThemeColor(GlobalState state, Action action) {
  AppTheme appTheme = AppTheme.getInstance(action.payload);
  if (action.payload) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.grey[850],
        systemNavigationBarIconBrightness: Brightness.light));
  }else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));
  }
  return state.clone()..appTheme = appTheme;
}

GlobalState _onchangePlayState(GlobalState state, Action action) {
  return state.clone()..playStateType = action.payload;
}

GlobalState _onchangeCurrSong(GlobalState state, Action action) {
  var clone = state.clone();
  SongBeanEntity payload = action.payload;
  SpUtil.putString(playSongHistory, jsonEncode(payload));
  var stringList = SpUtil.getStringList(LIKE_SONGS, defValue: []);
  payload.like = stringList.contains(payload.id);
  return clone..currSong = payload;
}

GlobalState _onchangeSongPos(GlobalState state, Action action) {
  return state.clone()..currSongPos = action.payload;
}

GlobalState _changeBack(GlobalState state, Action action) {
  var clone = state.clone();
  SpUtil.putString(USER_BACKGROUND, action.payload);
  return clone..backPath = action.payload;
}

GlobalState _changeBlur(GlobalState state, Action action) {
  var clone = state.clone();
  SpUtil.putDouble(BLUR, action.payload);
  return clone..blur = action.payload;
}

GlobalState _onchangeSongAllPos(GlobalState state, Action action) {
  return state.clone()..currSongAllPos = action.payload;
}

GlobalState _onchangeLyric(GlobalState state, Action action) {
  return state.clone()..lyric = action.payload;
}

GlobalState _changePlayMode(GlobalState state, Action action) {
  PlayModeType playModeType = state.playModeType;
  switch (playModeType) {
    case PlayModeType.REPEAT:
      playModeType = PlayModeType.REPEAT_ONE;
      break;
    case PlayModeType.REPEAT_ONE:
      playModeType = PlayModeType.SHUFFLE;
      break;
    case PlayModeType.SHUFFLE:
      playModeType = PlayModeType.REPEAT;
      break;
  }
  return state.clone()..playModeType = playModeType;
}
