import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<NewSongState> buildReducer() {
  return asReducer(
    <Object, Reducer<NewSongState>>{
      NewSongAction.play: _onAction,
    },
  );
}

NewSongState _onAction(NewSongState state, Action action) {
  final NewSongState newState = state.clone();
  return newState;
}
