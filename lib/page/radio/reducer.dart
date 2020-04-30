import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RadioState> buildReducer() {
  return asReducer(
    <Object, Reducer<RadioState>>{
      RadioAction.action: _onAction,
    },
  );
}

RadioState _onAction(RadioState state, Action action) {
  final RadioState newState = state.clone();
  return newState;
}
