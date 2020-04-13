import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

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
  final List<SongBeanEntity> today =
      action.payload ?? <SongBeanEntity>[];
  final TodayState newState = state.clone();
  newState.list = today;
  newState.isShowLoading = false;
  return newState;
}
