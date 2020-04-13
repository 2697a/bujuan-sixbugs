import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TopDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<TopDetailsState>>{
      TopDetailsAction.getTopData: _onGetTopData,
    },
  );
}

TopDetailsState _onGetTopData(TopDetailsState state, Action action) {
  final TopDetailsState newState = state.clone();
  newState.list = action.payload;
  newState.showLoading = false;
  return newState;
}
