import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HotSingerState> buildReducer() {
  return asReducer(
    <Object, Reducer<HotSingerState>>{
      HotSingerAction.getSinger: _onGetSinger,
    },
  );
}

HotSingerState _onGetSinger(HotSingerState state, Action action) {
  final HotSingerState newState = state.clone();
  newState.artists.addAll(action.payload);
  newState.showLoading= false;
  newState.page = newState.page+1;
  return newState;
}
