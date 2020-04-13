import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LocalSingerState> buildReducer() {
  return asReducer(
    <Object, Reducer<LocalSingerState>>{
      LocalSingerAction.action: _onAction,
    },
  );
}

LocalSingerState _onAction(LocalSingerState state, Action action) {
  final LocalSingerState newState = state.clone();
  return newState;
}
