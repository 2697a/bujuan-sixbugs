import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DonationState> buildReducer() {
  return asReducer(
    <Object, Reducer<DonationState>>{
      DonationAction.action: _onAction,
    },
  );
}

DonationState _onAction(DonationState state, Action action) {
  final DonationState newState = state.clone();
  return newState;
}
