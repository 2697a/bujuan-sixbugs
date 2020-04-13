import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchSingerState> buildEffect() {
  return combineEffects(<Object, Effect<SearchSingerState>>{
    SearchSingerAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SearchSingerState> ctx) {
}
