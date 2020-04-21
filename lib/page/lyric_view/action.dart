import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum playListAction { action }

class playListActionCreator {
  static Action onAction() {
    return const Action(playListAction.action);
  }
}
