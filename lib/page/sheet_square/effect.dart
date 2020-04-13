import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SheetSquareState> buildEffect() {
  return combineEffects(<Object, Effect<SheetSquareState>>{
    SheetSquareAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SheetSquareState> ctx) {
}
