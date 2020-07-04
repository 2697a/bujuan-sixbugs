import 'package:bujuan/entity/search_mv_entity.dart';
import 'package:bujuan/entity/search_sheet_entity.dart';
import 'package:bujuan/entity/search_singer_entity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutterstarrysky/song_info.dart';

class SearchDetailsState implements Cloneable<SearchDetailsState> {
  String searchContent;
  bool showLoading;
  List<SongInfo> songs;
  List<SearchSheetResultPlaylist> playlists;
  List<SearchSingerResultArtist> artists;
  List<SearchMvResultMv> mvs;

  @override
  SearchDetailsState clone() {
    return SearchDetailsState()
      ..searchContent = searchContent
      ..showLoading = showLoading
      ..songs = songs
      ..playlists = playlists
      ..mvs = mvs
      ..artists = artists;
  }
}

SearchDetailsState initState(Map<String, dynamic> args) {
  var searchDetailsState = SearchDetailsState();
  searchDetailsState.searchContent = args['searchContent'];
  searchDetailsState.showLoading = true;
  return searchDetailsState;
}
