import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SheetDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<SheetDetailsState>>{
      SheetDetailsAction.action: _onAction,
      SheetDetailsAction.getSheetDeList: _onGetDeList,
      SheetDetailsAction.sheetInfo: _onSheetInfo,
      SheetDetailsAction.likeState:_onLike
    },
  );
}

SheetDetailsState _onAction(SheetDetailsState state, Action action) {
  final SheetDetailsState newState = state.clone();
  newState.playlist.subscribed = !newState.playlist.subscribed;
  return newState;
}

SheetDetailsState _onGetDeList(SheetDetailsState state, Action action) {
  final List<SongBeanEntity> sheet =
      action.payload ?? <SongBeanEntity>[];
  final SheetDetailsState newState = state.clone();
  newState.list = sheet;
  return newState;
}

SheetDetailsState _onSheetInfo(SheetDetailsState state, Action action) {
  final SheetDetailsPlaylist sheet = action.payload ?? null;
  final SheetDetailsState newState = state.clone();
  newState.playlist = sheet;
  return newState;
}
SheetDetailsState _onLike(SheetDetailsState state, Action action) {
  final SheetDetailsState newState = state.clone();
  newState.playlist.subscribed = !newState.playlist.subscribed;
  return newState;
}