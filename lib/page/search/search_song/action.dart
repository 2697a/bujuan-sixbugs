import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchSongAction { playSong }

class SearchSongActionCreator {
  static Action playSong(int index) {
    return  Action(SearchSongAction.playSong,payload: index);
  }
}
