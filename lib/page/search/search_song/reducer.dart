import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchSongState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchSongState>>{
    },
  );
}

SearchSongState _onAction(SearchSongState state, Action action) {
  final SearchSongState newState = state.clone();
  return newState;
}
