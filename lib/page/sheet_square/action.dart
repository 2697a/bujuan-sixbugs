import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SheetSquareAction { action }

class SheetSquareActionCreator {
  static Action onAction() {
    return const Action(SheetSquareAction.action);
  }
}
