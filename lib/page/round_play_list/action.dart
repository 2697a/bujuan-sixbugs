import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum RoundPlayAction { action }

class RoundPlayActionCreator {
  static Action onAction() {
    return const Action(RoundPlayAction.action);
  }
}
