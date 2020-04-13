import 'package:fish_redux/fish_redux.dart';

enum MainAction { action }

class MainActionCreator {
  static Action onAction() {
    return const Action(MainAction.action);
  }
}
