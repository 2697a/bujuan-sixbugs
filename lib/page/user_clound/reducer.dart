import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CloundPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<CloundPageState>>{
      CloundPageAction.action: _onAction,
    },
  );
}

CloundPageState _onAction(CloundPageState state, Action action) {
  final CloundPageState newState = state.clone();
  return newState;
}
