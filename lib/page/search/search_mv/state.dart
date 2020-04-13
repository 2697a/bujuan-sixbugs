import 'package:bujuan/api/module.dart';
import 'package:bujuan/entity/search_mv_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class SearchMvState implements Cloneable<SearchMvState> {
  List<SearchMvResultMv> mvs;
  @override
  SearchMvState clone() {
    return SearchMvState()..mvs = mvs;
  }
}

SearchMvState initState(Map<String, dynamic> args) {
  var searchMvState = SearchMvState();
  searchMvState.mvs = args['mvs'];
  return searchMvState;
}
