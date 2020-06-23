import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<RoundPlayInfoState> buildEffect() {
  return combineEffects(<Object, Effect<RoundPlayInfoState>>{
    RoundPlayInfoAction.action: _onAction,
  });
}

void _onAction(Action action, Context<RoundPlayInfoState> ctx) {
}
