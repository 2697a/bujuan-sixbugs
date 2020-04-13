import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SheetSquareDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<SheetSquareDetailsState>>{
      SheetSquareDetailsAction.getList: _onGetList,
      SheetSquareDetailsAction.changePage: _onChangePage
    },
  );
}

SheetSquareDetailsState _onGetList(SheetSquareDetailsState state, Action action) {
  final SheetSquareDetailsState newState = state.clone();
  newState.playlists.addAll(action.payload);
  newState.showLoading = false;
  return newState;
}
SheetSquareDetailsState _onChangePage(SheetSquareDetailsState state, Action action) {
  final SheetSquareDetailsState newState = state.clone();
  newState.page = action.payload;
  return newState;
}
