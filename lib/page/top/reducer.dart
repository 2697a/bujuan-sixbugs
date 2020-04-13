import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TopPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<TopPageState>>{
      TopPageAction.topData: _onTop,
      TopPageAction.topSinger: _onTopSinger,
      TopPageAction.topMvs: _onTopMvs,
    },
  );
}

TopPageState _onTopSinger(TopPageState state, Action action) {
  final TopPageState newState = state.clone();
  newState.artists = action.payload;
  return newState;
}


TopPageState _onTopMvs(TopPageState state, Action action) {
  final TopPageState newState = state.clone();
  newState.mvs = action.payload;
  return newState;
}
TopPageState _onTop(TopPageState state, Action action) {
  var payload = action.payload;
  TopType type = payload['type'];
  List<SongBeanEntity> data = payload['data'];
  final TopPageState newState = state.clone();
  switch (type) {
    case TopType.BS:
      newState.bsList = data;
      break;
    case TopType.NEW:
      newState.newList = data;
      break;
    case TopType.YC:
      newState.ycList = data;
      break;
    case TopType.HOT:
      newState.hotList = data;
      break;
  }
  if (newState.bsList != null &&
      newState.newList != null &&
      newState.ycList != null &&
      newState.hotList != null) newState.showLoading = false;
  return newState;
}
