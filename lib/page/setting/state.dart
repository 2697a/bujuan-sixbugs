import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';

class SettingState implements Cloneable<SettingState> {
  bool miniPlay;
  bool isHigh;
  double blur;
  bool isBack;
  @override
  SettingState clone() {
    return SettingState()..miniPlay = miniPlay..blur=blur..isHigh=isHigh;
  }
}

SettingState initState(Map<String, dynamic> args) {
  var settingState = SettingState();
  settingState.miniPlay = SpUtil.getBool(MINI_PLAY, defValue: false);
  settingState.isBack = SpUtil.getString(USER_BACKGROUND,defValue: null)!=null;
  settingState.blur = 2;
  settingState.isHigh = SpUtil.getBool(HIGH, defValue: false);
  return settingState;
}
