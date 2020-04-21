import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SingerDetailsAction { action }

class SingerDetailsActionCreator {
  static Action onAction() {
    return const Action(SingerDetailsAction.action);
  }
}
