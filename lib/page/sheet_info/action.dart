import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SheetInfoAction { action }

class SheetInfoActionCreator {
  static Action onAction() {
    return const Action(SheetInfoAction.action);
  }
}
