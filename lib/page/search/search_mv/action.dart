import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchMvAction { action }

class SearchMvActionCreator {
  static Action onAction() {
    return const Action(SearchMvAction.action);
  }
}
