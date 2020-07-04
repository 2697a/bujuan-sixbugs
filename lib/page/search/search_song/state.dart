import 'package:fish_redux/fish_redux.dart';
import 'package:flutterstarrysky/song_info.dart';

class SearchSongState implements Cloneable<SearchSongState> {
  List<SongInfo> songs;

  @override
  SearchSongState clone() {
    return SearchSongState()..songs = songs;
  }
}

SearchSongState initState(Map<String, dynamic> args) {
  var searchSongState = SearchSongState();
  searchSongState.songs = args['songs'];
  return searchSongState;
}
