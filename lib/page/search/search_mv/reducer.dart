import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchMvState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchMvState>>{
      SearchMvAction.action: _onAction,
    },
  );
}

SearchMvState _onAction(SearchMvState state, Action action) {
  final SearchMvState newState = state.clone();
  return newState;
}
