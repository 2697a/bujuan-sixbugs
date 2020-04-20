import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<playListState> buildReducer() {
  return asReducer(
    <Object, Reducer<playListState>>{
      playListAction.action: _onAction,
    },
  );
}

playListState _onAction(playListState state, Action action) {
  final playListState newState = state.clone();
  return newState;
}
