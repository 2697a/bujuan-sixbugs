import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SettingAction { miniPlay,miniPlayState }

class SettingActionCreator {
  static Action onMiniPlay() {
    return Action(SettingAction.miniPlay);
  }

  static Action onMiniPlayState(bool mini) {
    return Action(SettingAction.miniPlayState,payload: mini);
  }
}
