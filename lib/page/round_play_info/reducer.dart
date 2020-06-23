import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RoundPlayInfoState> buildReducer() {
  return asReducer(
    <Object, Reducer<RoundPlayInfoState>>{
      RoundPlayInfoAction.action: _onAction,
    },
  );
}

RoundPlayInfoState _onAction(RoundPlayInfoState state, Action action) {
  final RoundPlayInfoState newState = state.clone();
  return newState;
}
