import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class LocalSingerState implements Cloneable<LocalSingerState> {
  Map<String, List<SongBeanEntity>> map;

  @override
  LocalSingerState clone() {
    return LocalSingerState()..map = map;
  }
}

LocalSingerState initState(Map<String, dynamic> args) {
  var localSingerState = LocalSingerState();
  List<SongBeanEntity> songs = args['list'];
  if (songs.length == 0) {
    localSingerState.map = null;
  } else {
    Map<String, List<SongBeanEntity>> map = new Map.fromIterable(songs,
        key: (key) => key.singer,
        value: (value) {
          return songs.where((item) => item.singer == value.singer).toList();
        });
    localSingerState.map = map;
  }
  return localSingerState;
}
