import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MvState> buildReducer() {
  return asReducer(
    <Object, Reducer<MvState>>{
      MvAction.changeTag: _onAction,
    },
  );
}

MvState _onAction(MvState state, Action action) {
  final MvState newState = state.clone();
  newState.tag = action.payload;
  return newState;
}
