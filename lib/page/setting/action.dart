import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SettingAction { miniPlay,miniPlayState ,changeBlur}

class SettingActionCreator {
  static Action onMiniPlay() {
    return Action(SettingAction.miniPlay);
  }

  static Action onMiniPlayState(bool mini) {
    return Action(SettingAction.miniPlayState,payload: mini);
  }

  static Action onChangeBlur(double value) {
    return Action(SettingAction.changeBlur,payload: value);
  }
}
