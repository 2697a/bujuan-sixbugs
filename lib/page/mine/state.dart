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

  @override
  MineState clone() {
    return MineState()
      ..isLogin = isLogin
      ..userProfileEntity = userProfileEntity
      ..isShowLoad = isShowLoad
      ..createOrderList = createOrderList
      ..isOpen = isOpen
      ..orderList = orderList;
  }
}

MineState initState(Map<String, dynamic> args) {
  var mineState = MineState();
  var cookie = SpUtil.getInt(Constants.USER_ID, defValue: -1);
  mineState.isLogin = cookie != -1;
  mineState.isShowLoad = true;
  var profile = SpUtil.getString('profile', defValue: null);
  var create = SpUtil.getString('create', defValue: null);
  var coll = SpUtil.getString('coll', defValue: null);
  if (profile != null && create != null && coll != null) {
    var responseJson = json.decode(profile);
    mineState.userProfileEntity = UserProfileEntity.fromJson(responseJson);
    List createList = json.decode(create);
    mineState.createOrderList = createList.map((m) => new UserOrderPlaylist.fromJson(m)).toList();
    List collList = json.decode(coll);
    mineState.orderList = collList.map((m) => new UserOrderPlaylist.fromJson(m)).toList();
    mineState.isShowLoad = false;
  }
  mineState.isOpen = true;
  return mineState;
}
