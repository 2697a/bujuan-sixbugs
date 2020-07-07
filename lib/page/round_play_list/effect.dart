import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<RoundPlayState> buildEffect() {
  return combineEffects(<Object, Effect<RoundPlayState>>{
    RoundPlayAction.action: _onAction,
  });
}

void _onAction(Action action, Context<RoundPlayState> ctx) {
}
