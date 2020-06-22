import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutterstarrysky/song_info.dart';

class HistoryState implements Cloneable<HistoryState> {

  List<SongInfo> list;
  bool showLoading;
  @override
  HistoryState clone() {
    return HistoryState()..list = list..showLoading = showLoading;
  }
}

HistoryState initState(Map<String, dynamic> args) {
  var historyState = HistoryState();
  historyState.showLoading = true;
  return historyState;
}
