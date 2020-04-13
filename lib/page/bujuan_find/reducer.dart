import 'package:bujuan/page/bujuan_find/banner/state.dart';
import 'package:bujuan/page/bujuan_find/new_song/state.dart';
import 'package:bujuan/page/bujuan_find/sheet/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<NewFindState> buildReducer() {
  return asReducer(
    <Object, Reducer<NewFindState>>{
      NewFindAction.getBanner: _onGetBanner,
      NewFindAction.getSheet: _onGetSheet,
      NewFindAction.getNewSong: _onGetNewSong
    },
  );
}

NewFindState _onGetBanner(NewFindState state, Action action) {
  NewBannerState newBannerState = action.payload;
  final NewFindState newState = state.clone();
  newState.bannerState = newBannerState;
  return newState;
}

NewFindState _onGetSheet(NewFindState state, Action action) {
  SheetViewState sheetViewState = action.payload;
  final NewFindState newState = state.clone();
  newState.sheetViewState = sheetViewState;
  return newState;
}

NewFindState _onGetNewSong(NewFindState state, Action action) {
  NewSongState newSongState = action.payload;
  final NewFindState newState = state.clone();
  newState.newSongState = newSongState;
  newState.isShowLoad = false;
  return newState;
}
