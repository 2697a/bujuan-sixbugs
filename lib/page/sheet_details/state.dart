import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SheetDetailsState implements Cloneable<SheetDetailsState> {
  bool isShowLoading;
  SheetDetailsPlaylist playlist;
  List<SongBeanEntity> list;
  int sheetId;
  bool sub;
  PanelController panelController;

  @override
  SheetDetailsState clone() {
    return SheetDetailsState()
      ..playlist = playlist
      ..isShowLoading = isShowLoading
      ..list = list
      ..sub = sub
      ..panelController = panelController;
  }
}

SheetDetailsState initState(Map<String, dynamic> args) {
  var sheetDetailsState = SheetDetailsState();
  sheetDetailsState.sheetId = args['sheetId'];
  sheetDetailsState.isShowLoading = true;
  sheetDetailsState.panelController = PanelController();
  return sheetDetailsState;
}
