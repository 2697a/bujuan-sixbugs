import 'package:bujuan/entity/highquality_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class SheetSquareDetailsState implements Cloneable<SheetSquareDetailsState> {
  bool showLoading;
  String type;
  List<HighqualityPlaylist> playlists;
  int page;

  @override
  SheetSquareDetailsState clone() {
    return SheetSquareDetailsState()
      ..showLoading = showLoading
      ..playlists = playlists
      ..page = page
      ..type = type;
  }
}

SheetSquareDetailsState initState(Map<String, dynamic> args) {
  var sheetSquareDetailsState = SheetSquareDetailsState();
  sheetSquareDetailsState.showLoading = true;
  sheetSquareDetailsState.page = 0;
  sheetSquareDetailsState.playlists = [];
  sheetSquareDetailsState.type = args['type'];
  return sheetSquareDetailsState;
}
