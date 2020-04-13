import 'package:bujuan/entity/highquality_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SheetSquareDetailsAction { getList, changePage, loadNextTalk }

class SheetSquareDetailsActionCreator {
  static Action onGetList(List<HighqualityPlaylist> playlists) {
    return Action(SheetSquareDetailsAction.getList, payload: playlists);
  }

  static Action changePage(int page) {
    return Action(SheetSquareDetailsAction.changePage, payload: page);
  }

  static Action loadNextTalk() {
    return Action(SheetSquareDetailsAction.loadNextTalk);
  }
}
