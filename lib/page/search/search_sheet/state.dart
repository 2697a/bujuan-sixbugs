import 'package:bujuan/entity/search_sheet_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class SearchSheetState implements Cloneable<SearchSheetState> {
  List<SearchSheetResultPlaylist> playlists;
  @override
  SearchSheetState clone() {
    return SearchSheetState()..playlists = playlists;
  }
}

SearchSheetState initState(Map<String, dynamic> args) {
  var searchSheetState = SearchSheetState();
  searchSheetState.playlists = args['sheets'];
  return searchSheetState;
}
