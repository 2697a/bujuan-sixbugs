import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlayViewState> buildReducer() {
  return asReducer(
    <Object, Reducer<PlayViewState>>{
      PlayViewAction.changeLikeState: _geLikeOrUnLike,
      PlayViewAction.changerDrr: _getChangerDrr,
    },
  );
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

