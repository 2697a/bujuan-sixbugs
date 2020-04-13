import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchSingerState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchSingerState>>{
      SearchSingerAction.action: _onAction,
    },
  );
}

SearchSingerState _onAction(SearchSingerState state, Action action) {
  final SearchSingerState newState = state.clone();
  return newState;
}
