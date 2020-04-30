import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<RadioState> buildEffect() {
  return combineEffects(<Object, Effect<RadioState>>{
    RadioAction.action: _onAction,
  });
}

void _onAction(Action action, Context<RadioState> ctx) {
}
