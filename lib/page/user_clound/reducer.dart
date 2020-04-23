import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CloundPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<CloundPageState>>{
      CloundPageAction.getCloud: _onAction,
    },
  );
}

CloundPageState _onAction(CloundPageState state, Action action) {
  final CloundPageState newState = state.clone();
  newState.list = action.payload;
  newState.isShowLoading = false;
  return newState;
}
