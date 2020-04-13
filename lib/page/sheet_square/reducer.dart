import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SheetSquareState> buildReducer() {
  return asReducer(
    <Object, Reducer<SheetSquareState>>{
      SheetSquareAction.action: _onAction,
    },
  );
}

SheetSquareState _onAction(SheetSquareState state, Action action) {
  final SheetSquareState newState = state.clone();
  return newState;
}
