import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TopDetailsAction { action ,getTopData,playSong}

class TopDetailsActionCreator {
  static Action onAction() {
    return const Action(TopDetailsAction.action);
  }

  static Action onGetTop(List<SongBeanEntity> songs) {
    return  Action(TopDetailsAction.getTopData,payload: songs);
  }


  static Action onPlaySong(int song) {
    return  Action(TopDetailsAction.playSong,payload: song);
  }
}
