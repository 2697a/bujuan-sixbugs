import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<LocalSingerState> buildEffect() {
  return combineEffects(<Object, Effect<LocalSingerState>>{
    LocalSingerAction.action: _onAction,
  });
}

void _onAction(Action action, Context<LocalSingerState> ctx) {
}
