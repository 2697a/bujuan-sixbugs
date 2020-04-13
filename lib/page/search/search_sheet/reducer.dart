import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchSheetState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchSheetState>>{
      SearchSheetAction.action: _onAction,
    },
  );
}

SearchSheetState _onAction(SearchSheetState state, Action action) {
  final SearchSheetState newState = state.clone();
  return newState;
}
