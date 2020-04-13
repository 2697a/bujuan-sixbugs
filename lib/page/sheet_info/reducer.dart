import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SheetInfoState> buildReducer() {
  return asReducer(
    <Object, Reducer<SheetInfoState>>{
      SheetInfoAction.action: _onAction,
    },
  );
}

SheetInfoState _onAction(SheetInfoState state, Action action) {
  final SheetInfoState newState = state.clone();
  return newState;
}
