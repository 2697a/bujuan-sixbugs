import 'package:fish_redux/fish_redux.dart';
import 'package:flutterstarrysky/song_info.dart';

//TODO replace with your own action
enum HistoryAction { getHistoryData,playSong}

class HistoryActionCreator {
  static Action getHistoryData(List<SongInfo> list) {
    return  Action(HistoryAction.getHistoryData,payload: list);
  }

  static Action playSong(int index) {
    return  Action(HistoryAction.playSong,payload: index);
  }
}
