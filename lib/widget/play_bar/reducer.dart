import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlayBarState> buildReducer() {
  return asReducer(
    <Object, Reducer<PlayBarState>>{
//      PlayBarAction.action: _onAction,
//      PlayBarAction.changePlayState: _changePlayState,
//      PlayBarAction.changeCurrSong:_changeCurrSong,
    },
  );
}

//PlayBarState _onAction(PlayBarState state, Action action) {
//  final PlayBarState newState = state.clone();
//  return newState;
//}
//PlayBarState _changePlayState(PlayBarState state, Action action) {
//  PlayStateType playStateType = action.payload;
//  return state.clone()..playStateType = playStateType;
//}
//
//PlayBarState _changeCurrSong(PlayBarState state, Action action) {
//  final SongBeanEntity songBeanEntity = SongBeanEntity.fromJson(jsonDecode(action.payload));
//  Constants.songBeanEntity = songBeanEntity;
//  return state.clone();
//}