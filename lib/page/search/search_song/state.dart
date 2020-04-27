import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class SearchSongState implements Cloneable<SearchSongState> {
  List<SongBeanEntity> songs;

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
