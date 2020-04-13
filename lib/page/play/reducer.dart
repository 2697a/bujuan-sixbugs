import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlayViewState> buildReducer() {
  return asReducer(
    <Object, Reducer<PlayViewState>>{
      PlayViewAction.getLyric: _getLyric,
      PlayViewAction.changeLikeState: _geLikeOrUnLike,
      PlayViewAction.changeTickerProvider: _getChangeTickerProvider,
      PlayViewAction.changerDrr: _getChangerDrr,
    },
  );
}

PlayViewState _getLyric(PlayViewState state, Action action) {
  final PlayViewState newState = state.clone();
  newState.lyric = action.payload;
  return newState;
}

PlayViewState _geLikeOrUnLike(PlayViewState state, Action action) {
  final PlayViewState newState = state.clone();
  var _like = !state.currSong.like;
  newState.currSong.like = _like;
  return newState;
}

PlayViewState _getChangerDrr(PlayViewState state, Action action) {
  final PlayViewState newState = state.clone();
  newState.showSelect = action.payload;
  return newState;
}

PlayViewState _getChangeTickerProvider(PlayViewState state, Action action) {
  final PlayViewState newState = state.clone();
  newState.lyricController = action.payload;
  newState.lyricController
    ..addListener(() {
      //如果拖动歌词则显示选择器
      if (newState.showSelect != newState.lyricController.isDragging) {
        newState.showSelect = newState.lyricController.isDragging;
      }
    });
  return newState;
}
