import 'package:fish_redux/fish_redux.dart';
import 'package:flutterstarrysky/song_info.dart';

class TodayState implements Cloneable<TodayState> {
  List<SongInfo> list;
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
