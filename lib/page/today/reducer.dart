import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutterstarrysky/song_info.dart';

import 'action.dart';
import 'state.dart';

Reducer<TodayState> buildReducer() {
  return asReducer(
    <Object, Reducer<TodayState>>{
      TodayAction.action: _onAction,
      TodayAction.getTodayList: _onGetDeList,
    },
  );
}

TodayState _onAction(TodayState state, Action action) {
  final TodayState newState = state.clone();
  return newState;
}
TodayState _onGetDeList(TodayState state, Action action) {
  final List<SongInfo> today =
      action.payload ?? <SongInfo>[];
  final TodayState newState = state.clone();
  newState.list = today;
  newState.isShowLoading = false;
  return newState;
}
