import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class SheetDetailsState implements Cloneable<SheetDetailsState> {
  bool isShowLoading;
  SheetDetailsPlaylist playlist;
  List<SongBeanEntity> list;
  int sheetId;
  bool sub;
  @override
  SheetDetailsState clone() {
    return SheetDetailsState()..playlist =playlist..isShowLoading = isShowLoading..list = list..sub = sub;
  }
}

SheetDetailsState initState(Map<String, dynamic> args) {
  var sheetDetailsState = SheetDetailsState();
  sheetDetailsState.sheetId = args['sheetId'];
  sheetDetailsState.isShowLoading = true;
  return sheetDetailsState;
}
