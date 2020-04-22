import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CloundPageState> buildEffect() {
  return combineEffects(<Object, Effect<CloundPageState>>{
    CloundPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CloundPageState> ctx) {
}
