import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchSingerAction { action }

class SearchSingerActionCreator {
  static Action onAction() {
    return const Action(SearchSingerAction.action);
  }
}
