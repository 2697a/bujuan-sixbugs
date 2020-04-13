import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/singer_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/entity/top_mv_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TopPageAction { topMvs,topSinger, topData, getRef, openDetail }

class TopPageActionCreator {
  static Action onGetTop(List<SongBeanEntity> list, TopType topType) {
    return Action(TopPageAction.topData,
        payload: {'type': topType, 'data': list});
  }

  static Action onGetRef() {
    return Action(TopPageAction.getRef);
  }

  static Action onGetSinger(List<SingerArtist> artists) {
    return Action(TopPageAction.topSinger,payload: artists);
  }

  static Action onGetMv(List<TopMvData> mvs) {
    return Action(TopPageAction.topMvs,payload: mvs);
  }

  static Action onOpenDetail( id) {
    return Action(TopPageAction.openDetail, payload: {'id': id});
  }
}
