import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class LocalListState implements Cloneable<LocalListState> {
  List<SongBeanEntity> list;

  @override
  LocalListState clone() {
    return LocalListState()..list = list;
  }
}

LocalListState initState(Map<String, dynamic> args) {
  var localListState = LocalListState();
  localListState.list = args['list'];
  return localListState;
}
