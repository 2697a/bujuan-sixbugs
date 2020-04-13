import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<NewBannerState> buildReducer() {
  return asReducer(
    <Object, Reducer<NewBannerState>>{
//      NewBannerAction.action: _onAction,
    },
  );
}

NewBannerState _onAction(NewBannerState state, Action action) {
  final NewBannerState newState = state.clone();
  return newState;
}
