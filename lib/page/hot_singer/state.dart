import 'package:bujuan/entity/singer_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class HotSingerState implements Cloneable<HotSingerState> {
  List<SingerArtist> artists;
  bool showLoading;
  int page;
  @override
  HotSingerState clone() {
    return HotSingerState()..showLoading = showLoading..artists = artists..page= page;
  }
}

HotSingerState initState(Map<String, dynamic> args) {
  var hotSingerState = HotSingerState();
  hotSingerState.showLoading = true;
  hotSingerState.artists = [];
  hotSingerState.page=0;
  return hotSingerState;
}
