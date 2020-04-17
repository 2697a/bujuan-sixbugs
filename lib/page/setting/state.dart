import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';

class SettingState implements Cloneable<SettingState> {
  bool miniPlay;
  double blur;
  @override
  SettingState clone() {
    return SettingState()..miniPlay = miniPlay..blur=blur;
  }
}

SettingState initState(Map<String, dynamic> args) {
  var settingState = SettingState();
  settingState.miniPlay = SpUtil.getBool(Constants.MINI_PLAY, defValue: false);
  settingState.blur = 2;
  return settingState;
}
