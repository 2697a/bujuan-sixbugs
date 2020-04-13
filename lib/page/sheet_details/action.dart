import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SheetDetailsAction { action ,getSheetDeList,sheetInfo,play,infoPage,like,likeState}

class SheetDetailsActionCreator {
  static Action onAction() {
    return const Action(SheetDetailsAction.action);
  }

  static Action getSheetDeList( List<SongBeanEntity>  sheets) {
    return Action(SheetDetailsAction.getSheetDeList,payload: sheets);
  }

  static Action sheetInfo(SheetDetailsPlaylist playlist) {
    return Action(SheetDetailsAction.sheetInfo,payload: playlist);
  }

  static Action play(int index) {
    return Action(SheetDetailsAction.play,payload: index);
  }

  static Action infoPage(){
    return Action(SheetDetailsAction.infoPage);
  }
  static Action like(){
    return Action(SheetDetailsAction.like);
  }

  static Action likeState(){
    return Action(SheetDetailsAction.likeState);
  }
}
