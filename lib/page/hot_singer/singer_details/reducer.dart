import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SingerDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<SingerDetailsState>>{
      SingerDetailsAction.action: _onAction,
    },
  );
}

SingerDetailsState _onAction(SingerDetailsState state, Action action) {
  final SingerDetailsState newState = state.clone();
  return newState;
}
