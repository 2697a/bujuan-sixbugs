import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum RoundPlayInfoAction { action }

class RoundPlayInfoActionCreator {
  static Action onAction() {
    return const Action(RoundPlayInfoAction.action);
  }
}
