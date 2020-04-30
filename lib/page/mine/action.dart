import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/main/action.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MineAction { action ,login,loginResult,getUserProfile,getOrderList,getCreateOrderList,getRefresh,setOPen,setCreateOpen,exit,changeLoginState}

class MineActionCreator {
  static Action onAction() {
    return const Action(MineAction.action);
  }

  static Action onLogin() {
    return  Action(MineAction.login);
  }

  static Action onLoginResult(bool isLogin){
    return Action(MineAction.loginResult,payload: isLogin);
  }

  static Action getUserProfile(UserProfileEntity userProfileEntity){
    return Action(MineAction.getUserProfile,payload: userProfileEntity);
  }

  static Action getOrderList(List<UserOrderPlaylist> list){
    return Action(MineAction.getOrderList,payload: list);
  }

  static Action getCreateOrderList(List<UserOrderPlaylist> list){
    return Action(MineAction.getCreateOrderList,payload: list);
  }
  static Action getRefresh(){
    return Action(MineAction.getRefresh);
  }
  static Action setOPen(){
    return Action(MineAction.setOPen);
  }
  static Action setCreateOpen(){
    return Action(MineAction.setCreateOpen);
  }
  static Action exit(){
    return Action(MineAction.exit);
  }
  static Action changeLoginState(){
    return Action(MineAction.changeLoginState);
  }
}
