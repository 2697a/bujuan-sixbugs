import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AboutAction { action }

class AboutActionCreator {
  static Action onAction() {
    return const Action(AboutAction.action);
  }
}
