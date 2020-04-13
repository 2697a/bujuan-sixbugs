import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum LocalSingerAction { action }

class LocalSingerActionCreator {
  static Action onAction() {
    return const Action(LocalSingerAction.action);
  }
}
