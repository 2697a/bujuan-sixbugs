import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FmPlayViewState> buildReducer() {
  return asReducer(
    <Object, Reducer<FmPlayViewState>>{
      FmPlayViewAction.changeLikeState: _geLikeOrUnLike,
      FmPlayViewAction.changerDrr: _getChangerDrr,
    },
  );
}


FmPlayViewState _geLikeOrUnLike(FmPlayViewState state, Action action) {
  final FmPlayViewState newState = state.clone();
  var _like = !state.currSong.like;
  newState.currSong.like = _like;
  return newState;
}

FmPlayViewState _getChangerDrr(FmPlayViewState state, Action action) {
  final FmPlayViewState newState = state.clone();
  newState.showSelect = action.payload;
  return newState;
}

