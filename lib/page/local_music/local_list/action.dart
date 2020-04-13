import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum LocalListAction { action, playLocal }

class LocalListActionCreator {
  static Action onAction() {
    return const Action(LocalListAction.action);
  }

  static Action playLocal(int index) {
    return Action(LocalListAction.playLocal, payload: index);
  }
}
