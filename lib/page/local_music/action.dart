import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum LocalMusicAction { getLocalMusic,changeIndex,changeIndexState ,ref,changeLoadState}

class LocalMusicActionCreator {
  static Action getLocalMusic(List<SongBeanEntity> local) {
    return Action(LocalMusicAction.getLocalMusic, payload: local);
  }
  static Action changeIndex(int index) {
    return Action(LocalMusicAction.changeIndex, payload: index);
  }
  static Action changeIndexState(int index) {
    return Action(LocalMusicAction.changeIndexState, payload: index);
  }
  static Action ref() {
    return Action(LocalMusicAction.changeIndexState);
  }
  static Action changeLoadState() {
    return Action(LocalMusicAction.changeLoadState);
  }
}
