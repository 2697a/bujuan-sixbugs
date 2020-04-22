import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlayView2State> buildReducer() {
  return asReducer(
    <Object, Reducer<PlayView2State>>{
      PlayView2Action.changeLikeState: _geLikeOrUnLike,
      PlayView2Action.changerDrr: _getChangerDrr,
    },
  );
}


PlayView2State _geLikeOrUnLike(PlayView2State state, Action action) {
  final PlayView2State newState = state.clone();
  var _like = !state.currSong.like;
  newState.currSong.like = _like;
  return newState;
}

PlayView2State _getChangerDrr(PlayView2State state, Action action) {
  final PlayView2State newState = state.clone();
  newState.showSelect = action.payload;
  return newState;
}

