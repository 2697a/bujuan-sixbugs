import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AboutState> buildReducer() {
  return asReducer(
    <Object, Reducer<AboutState>>{
      AboutAction.action: _onAction,
    },
  );
}

AboutState _onAction(AboutState state, Action action) {
  final AboutState newState = state.clone();
  return newState;
}
