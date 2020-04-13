import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HistoryState> buildReducer() {
  return asReducer(
    <Object, Reducer<HistoryState>>{
      HistoryAction.getHistoryData: _onGetHistoryData,
    },
  );
}

HistoryState _onGetHistoryData(HistoryState state, Action action) {
  final HistoryState newState = state.clone();
  newState.list = action.payload;
  newState.showLoading = false;
  return newState;
}
