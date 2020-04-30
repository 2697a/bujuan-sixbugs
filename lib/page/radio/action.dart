import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum RadioAction { action }

class RadioActionCreator {
  static Action onAction() {
    return const Action(RadioAction.action);
  }
}
