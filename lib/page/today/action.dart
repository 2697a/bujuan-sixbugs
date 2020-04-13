import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/entity/today_song_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TodayAction { action, getTodayList,play }

class TodayActionCreator {
  static Action onAction() {
    return const Action(TodayAction.action);
  }

  static Action getSheetDeList(List<SongBeanEntity> sheets) {
    return Action(TodayAction.getTodayList, payload: sheets);
  }
  static Action play(int index) {
    return Action(TodayAction.play, payload: index);
  }
}
