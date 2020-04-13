import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AlbumDetailsAction { action }

class AlbumDetailsActionCreator {
  static Action onAction() {
    return const Action(AlbumDetailsAction.action);
  }
}
