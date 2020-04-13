import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SheetInfoState> buildEffect() {
  return combineEffects(<Object, Effect<SheetInfoState>>{
    SheetInfoAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SheetInfoState> ctx) {
}
