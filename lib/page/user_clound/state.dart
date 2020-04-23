import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class CloundPageState implements Cloneable<CloundPageState> {
  List<SongBeanEntity> list;
  bool isShowLoading;
  @override
  CloundPageState clone() {
    return CloundPageState()..list = list..isShowLoading = isShowLoading;
  }
}

CloundPageState initState(Map<String, dynamic> args) {
  var cloundPageState = CloundPageState();
  cloundPageState.isShowLoading = true;
  return cloundPageState;
}
