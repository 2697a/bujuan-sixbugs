import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LocalSheetListState> buildReducer() {
  return asReducer(
    <Object, Reducer<LocalSheetListState>>{
      LocalSheetListAction.changList:_onChangeList
    },
  );
}

LocalSheetListState _onChangeList(LocalSheetListState state, Action action) {
  final LocalSheetListState newState = state.clone();
  newState.list = action.payload;
  return newState;
}