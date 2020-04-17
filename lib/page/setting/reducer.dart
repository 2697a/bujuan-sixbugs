import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SettingState> buildReducer() {
  return asReducer(
    <Object, Reducer<SettingState>>{
      SettingAction.miniPlayState: _onAction,
      SettingAction.changeBlur: _omChangeBlur
    },
  );
}

SettingState _onAction(SettingState state, Action action) {
  final SettingState newState = state.clone();
  newState.miniPlay = action.payload;
  return newState;
}
SettingState _omChangeBlur(SettingState state, Action action) {
  final SettingState newState = state.clone();
  BuJuanUtil.showToast('msg');
  newState.blur = action.payload;
  return newState;
}