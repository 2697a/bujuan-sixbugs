import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchDetailsState>>{
      SearchDetailsAction.getSong: _onGetSong,
      SearchDetailsAction.getSheet: _onGetSheet,
      SearchDetailsAction.getSinger: _onGetSinger,
      SearchDetailsAction.getMv: _onGetMv,
    },
  );
}

SearchDetailsState _onGetSong(SearchDetailsState state, Action action) {
  final SearchDetailsState newState = state.clone();
  newState.songs = action.payload;
  newState.showLoading = false;
  return newState;
}

SearchDetailsState _onGetSheet(SearchDetailsState state, Action action) {
  final SearchDetailsState newState = state.clone();
  newState.playlists = action.payload;
  return newState;
}

SearchDetailsState _onGetSinger(SearchDetailsState state, Action action) {
  final SearchDetailsState newState = state.clone();
  newState.artists = action.payload;
  return newState;
}

SearchDetailsState _onGetMv(SearchDetailsState state, Action action) {
  final SearchDetailsState newState = state.clone();
  newState.mvs = action.payload;
  return newState;
}
