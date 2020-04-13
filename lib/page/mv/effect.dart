import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<MvState> buildEffect() {
  return combineEffects(<Object, Effect<MvState>>{
    MvAction.changeTag: _onAction,
  });
}

void _onAction(Action action, Context<MvState> ctx) {
}
