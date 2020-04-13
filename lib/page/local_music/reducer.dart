import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LocalMusicState> buildReducer() {
  return asReducer(
    <Object, Reducer<LocalMusicState>>{
      LocalMusicAction.getLocalMusic: _getLocalMusic,
      LocalMusicAction.changeIndexState: _changeIndex,
      LocalMusicAction.changeLoadState: _changeLoad,
    },
  );
}

LocalMusicState _getLocalMusic(LocalMusicState state, Action action) {
  final LocalMusicState newState = state.clone();
  newState.list = action.payload;
  newState.showLoading = false;
  return newState;
}

LocalMusicState _changeIndex(LocalMusicState state, Action action) {
  final LocalMusicState newState = state.clone();
  newState.index = action.payload;
  return newState;
}
LocalMusicState _changeLoad(LocalMusicState state, Action action) {
  final LocalMusicState newState = state.clone();
  newState.showLoading = true;
  return newState;
}