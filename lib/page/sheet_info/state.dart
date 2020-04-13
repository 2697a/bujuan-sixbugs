import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class SheetInfoState implements Cloneable<SheetInfoState> {
  SheetDetailsPlaylist playlist;
  @override
  SheetInfoState clone() {
    return SheetInfoState()..playlist = playlist;
  }
}

SheetInfoState initState(Map<String, dynamic> args) {
  var sheetInfoState = SheetInfoState();
  sheetInfoState.playlist = args['playlist'];
  return sheetInfoState;
}
