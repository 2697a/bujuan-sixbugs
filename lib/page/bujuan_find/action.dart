import 'package:bujuan/page/bujuan_find/new_song/state.dart';
import 'package:bujuan/page/bujuan_find/sheet/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'banner/state.dart';

//TODO replace with your own action
enum NewFindAction { getBanner,getSheet,getNewSong,getHotSinger,getRefresh }

class NewFindActionCreator {
  static Action onGetBanner(NewBannerState banner) {
    return  Action(NewFindAction.getBanner,payload:banner );
  }

  static Action onGetSheet(SheetViewState result){
    return Action(NewFindAction.getSheet,payload: result);
  }
  static Action onGetNewSong(NewSongState newSongState){
    return Action(NewFindAction.getNewSong,payload: newSongState);
  }
  static Action onGetRefresh(){
    return Action(NewFindAction.getRefresh);
  }
}
