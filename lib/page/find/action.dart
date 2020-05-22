import 'package:bujuan/entity/banner_entity.dart';
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FindAction { getBanner,getSheet,getNewSong,getRefresh }

class FindActionCreator {
  static Action onGetBanner(List<BannerBanner> banner) {
    return  Action(FindAction.getBanner,payload:banner );
  }

  static Action onGetSheet(List<PersonalResult>  result){
    return Action(FindAction.getSheet,payload: result);
  }
  static Action onGetNewSong(List<SongBeanEntity>  newSongState){
    return Action(FindAction.getNewSong,payload: newSongState);
  }
  static Action onGetRefresh(){
    return Action(FindAction.getRefresh);
  }
}
