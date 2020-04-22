import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CloundPageAction { action }

class CloundPageActionCreator {
  static Action onAction() {
    return const Action(CloundPageAction.action);
  }
}
