import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FindState> buildReducer() {
  return asReducer(
    <Object, Reducer<FindState>>{
      FindAction.getBanner: _onGetBanner,
      FindAction.getSheet: _onGetSheet,
      FindAction.getNewSong: _onGetNewSong
    },
  );
}

FindState _onGetBanner(FindState state, Action action) {
  FindState newState = state.clone();
  newState.banners = action.payload;
  return newState;
}

FindState _onGetSheet(FindState state, Action action) {
  FindState newState = state.clone();
  newState.sheets = action.payload;
  return newState;
}

FindState _onGetNewSong(FindState state, Action action) {
  FindState newState = state.clone();
  newState.newSongs = action.payload;
  return newState;
}
