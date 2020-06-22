import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/slide_item.dart';
import 'package:fish_redux/fish_redux.dart';

class MineState implements Cloneable<MineState> {
  bool isLogin;
  bool isShowLoad;
  UserProfileEntity userProfileEntity;
  List<UserOrderPlaylist> createOrderList;
  List<UserOrderPlaylist> orderList;
  bool isOpen;
  bool isCreateOpen;
  SlideConfig slideConfig;

  @override
  MineState clone() {
    return MineState()
      ..isLogin = isLogin
      ..userProfileEntity = userProfileEntity
      ..isShowLoad = isShowLoad
      ..createOrderList = createOrderList
      ..isOpen = isOpen
      ..isCreateOpen = isCreateOpen
      ..slideConfig = slideConfig
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
  mineState.slideConfig = SlideConfig(
    slideOpenAnimDuration: Duration(milliseconds: 200),
    slideCloseAnimDuration: Duration(milliseconds: 100),
    deleteStep1AnimDuration: Duration(milliseconds: 50),
    deleteStep2AnimDuration: Duration(milliseconds: 30),
    supportElasticity: true,
    closeOpenedItemOnTouch: false,
    slideProportion: 0.2,
  );
  return mineState;
}
