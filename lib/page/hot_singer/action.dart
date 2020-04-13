import 'package:bujuan/entity/singer_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HotSingerAction { getSinger ,onLoad,changePage}

class HotSingerActionCreator {
  static Action getSinger(List<SingerArtist> artists) {
    return Action(HotSingerAction.getSinger,payload: artists);
  }
  static Action onLoad() {
    return Action(HotSingerAction.onLoad);
  }
  static Action changePage() {
    return Action(HotSingerAction.changePage);
  }
}
