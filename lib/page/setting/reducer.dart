import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SettingState> buildReducer() {
  return asReducer(
    <Object, Reducer<SettingState>>{
      SettingAction.miniPlayState: _onAction,
      SettingAction.changeBlur: _omChangeBlur,
      SettingAction.onHighState: _onHigh
    },
  );
}

SettingState _onAction(SettingState state, Action action) {
  final SettingState newState = state.clone();
  newState.miniPlay = action.payload;
  return newState;
}

SettingState _onHigh(SettingState state, Action action) {
  final SettingState newState = state.clone();
  newState.isHigh = action.payload;
  return newState;
}
SettingState _omChangeBlur(SettingState state, Action action) {
  final SettingState newState = state.clone();
  newState.isBack = action.payload;
  return newState;
}