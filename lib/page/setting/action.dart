import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SettingAction { miniPlay,miniPlayState ,changeBlur,isHigh,onHighState}

class SettingActionCreator {
  static Action onMiniPlay() {
    return Action(SettingAction.miniPlay);
  }
  static Action onIsHigh() {
    return Action(SettingAction.isHigh);
  }
  static Action onHighState(bool isHigh) {
    return Action(SettingAction.onHighState,payload: isHigh);
  }

  static Action onMiniPlayState(bool mini) {
    return Action(SettingAction.miniPlayState,payload: mini);
  }

  static Action onChangeBlur(isBlack) {
    return Action(SettingAction.changeBlur,payload: isBlack);
  }
}
