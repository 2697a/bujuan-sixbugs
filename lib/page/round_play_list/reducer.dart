import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RoundPlayState> buildReducer() {
  return asReducer(
    <Object, Reducer<RoundPlayState>>{
      RoundPlayAction.action: _onAction,
    },
  );
}

RoundPlayState _onAction(RoundPlayState state, Action action) {
  final RoundPlayState newState = state.clone();
  return newState;
}
