import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchSheetState> buildEffect() {
  return combineEffects(<Object, Effect<SearchSheetState>>{
    SearchSheetAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SearchSheetState> ctx) {
}
