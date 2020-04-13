import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum NewSongAction { play }

class NewSongActionCreator {
  static Action onPlay(int index) {
    return  Action(NewSongAction.play,payload: index);
  }
}
