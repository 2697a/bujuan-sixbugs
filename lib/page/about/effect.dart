import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AboutState> buildEffect() {
  return combineEffects(<Object, Effect<AboutState>>{
    AboutAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AboutState> ctx) {
}
