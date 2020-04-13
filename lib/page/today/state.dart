import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/entity/today_song_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class TodayState implements Cloneable<TodayState> {
  List<SongBeanEntity> list;
  bool isShowLoading;

  @override
  TodayState clone() {
    return TodayState()..list = list;
  }
}

TodayState initState(Map<String, dynamic> args) {
  var todayState = TodayState();
  todayState.isShowLoading = true;
  return todayState;
}
