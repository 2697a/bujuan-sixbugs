import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MineState> buildReducer() {
  return asReducer(
    <Object, Reducer<MineState>>{
      MineAction.action: _onAction,
      MineAction.loginResult: _onLoginResult,
      MineAction.getUserProfile: _onUserProfile,
      MineAction.getOrderList: _onOrderList,
      MineAction.getCreateOrderList: _onCreateOrderList,
      MineAction.setOPen: _onSetOpen,
      MineAction.setCreateOpen: _onSetCreateOpen,
      MineAction.changeLoginState: _changeLoginState
    },
  );
}

MineState _onAction(MineState state, Action action) {
  final MineState newState = state.clone();
  return newState;
}
MineState _changeLoginState(MineState state, Action action) {
  final MineState newState = state.clone();
  newState.isLogin = false;
  return newState;
}
MineState _onLoginResult(MineState state, Action action) {
  bool isLogin = action.payload;
  final MineState newState = state.clone();
  newState.isLogin = isLogin;
  return newState;
}

MineState _onUserProfile(MineState state, Action action) {
  UserProfileEntity userProfileEntity = action.payload;
  final MineState newState = state.clone();
  newState.userProfileEntity = userProfileEntity;
  return newState;
}

MineState _onOrderList(MineState state, Action action) {
  List<UserOrderPlaylist> orderList = action.payload;
  final MineState newState = state.clone();
  newState.orderList = orderList;
  newState.isShowLoad = false;
  return newState;
}

MineState _onCreateOrderList(MineState state, Action action) {
  List<UserOrderPlaylist> orderList = action.payload;
  final MineState newState = state.clone();
  newState.createOrderList = orderList;
  return newState;
}

MineState _onSetOpen(MineState state, Action action) {
  final bool isOpen = !state.isOpen;
  final MineState newState = state.clone();
  newState.isOpen = isOpen;
  return newState;
}

MineState _onSetCreateOpen(MineState state, Action action) {
  final bool isOpen = !state.isCreateOpen;
  final MineState newState = state.clone();
  newState.isCreateOpen = isOpen;
  return newState;
}