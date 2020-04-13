import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchMvState> buildEffect() {
  return combineEffects(<Object, Effect<SearchMvState>>{
    SearchMvAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SearchMvState> ctx) {
}
