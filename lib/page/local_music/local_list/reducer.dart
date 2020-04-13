import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LocalListState> buildReducer() {
  return asReducer(
    <Object, Reducer<LocalListState>>{
      LocalListAction.action: _onAction,
    },
  );
}

LocalListState _onAction(LocalListState state, Action action) {
  final LocalListState newState = state.clone();
  return newState;
}
