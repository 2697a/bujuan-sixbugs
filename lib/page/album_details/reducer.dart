import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AlbumDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<AlbumDetailsState>>{
      AlbumDetailsAction.action: _onAction,
    },
  );
}

AlbumDetailsState _onAction(AlbumDetailsState state, Action action) {
  final AlbumDetailsState newState = state.clone();
  return newState;
}
