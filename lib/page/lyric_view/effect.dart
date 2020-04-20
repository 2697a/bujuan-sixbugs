import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<playListState> buildEffect() {
  return combineEffects(<Object, Effect<playListState>>{
    playListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<playListState> ctx) {
}
