import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';

class MineState implements Cloneable<MineState> {
  bool isLogin;
  bool isShowLoad;
  UserProfileEntity userProfileEntity;
  List<UserOrderPlaylist> createOrderList;
  List<UserOrderPlaylist> orderList;
  bool isOpen;
  bool isCreateOpen;

  @override
  MineState clone() {
    return MineState()
      ..isLogin = isLogin
      ..userProfileEntity = userProfileEntity
      ..isShowLoad = isShowLoad
      ..createOrderList = createOrderList
      ..isOpen = isOpen
      ..isCreateOpen = isCreateOpen
      ..orderList = orderList;
  }
}

MineState initState(Map<String, dynamic> args) {
  var mineState = MineState();
  var cookie = SpUtil.getInt(USER_ID, defValue: -1);
  mineState.isLogin = cookie != -1;
  mineState.isShowLoad = true;
  mineState.isCreateOpen = true;
  mineState.isOpen = true;
  return mineState;
}
