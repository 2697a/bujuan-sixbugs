import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchSheetAction { action }

class SearchSheetActionCreator {
  static Action onAction() {
    return const Action(SearchSheetAction.action);
  }
}
