import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MvPlayViewState> buildReducer() {
  return asReducer(
    <Object, Reducer<MvPlayViewState>>{
      MvPlayViewAction.action: _onAction,
      MvPlayViewAction.getMvData: _onGetMvData
    },
  );
}

MvPlayViewState _onAction(MvPlayViewState state, Action action) {
  final MvPlayViewState newState = state.clone();
  return newState;
}

MvPlayViewState _onGetMvData(MvPlayViewState state, Action action) {
  final MvPlayViewState newState = state.clone();
  newState.mvData = action.payload;
  newState.showLoading = false;
//  newState.player
//      .setDataSource(newState.mvData.data.brs['720'], autoPlay: true);
  return newState;
}
