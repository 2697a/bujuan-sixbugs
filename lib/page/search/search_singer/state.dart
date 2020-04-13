import 'package:bujuan/entity/search_singer_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class SearchSingerState implements Cloneable<SearchSingerState> {
  List<SearchSingerResultArtist> artists;
  @override
  SearchSingerState clone() {
    return SearchSingerState()..artists = artists;
  }
}

SearchSingerState initState(Map<String, dynamic> args) {
  var searchSingerState = SearchSingerState();
  searchSingerState.artists = args['singers'];
  return searchSingerState;
}
