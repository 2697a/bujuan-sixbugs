import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HistoryAction { getHistoryData,playSong}

class HistoryActionCreator {
  static Action getHistoryData(List<SongBeanEntity> list) {
    return  Action(HistoryAction.getHistoryData,payload: list);
  }

  static Action playSong(int index) {
    return  Action(HistoryAction.playSong,payload: index);
  }
}
