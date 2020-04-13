import 'package:bujuan/entity/search_hot_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchAction { action, doSearch }

class SearchActionCreator {
  static Action onAction(List<SearchHotData> list) {
    return Action(SearchAction.action, payload: list);
  }

  static Action doSearch(String searchContent) {
    return Action(SearchAction.doSearch, payload: searchContent);
  }
}
