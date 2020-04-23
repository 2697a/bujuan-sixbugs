import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CloundPageAction { getCloud,playSong }

class CloundPageActionCreator {
  static Action onGetCloud(List<SongBeanEntity> songs) {
    return  Action(CloundPageAction.getCloud,payload: songs);
  }
  static Action onPlaySong(index) {
    return  Action(CloundPageAction.playSong,payload: index);
  }
}
