import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchState>>{
      SearchAction.action: _onAction,
    },
  );
}

SearchState _onAction(SearchState state, Action action) {
  final SearchState newState = state.clone();
  newState.data = action.payload;
  return newState;
}
