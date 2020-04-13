import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'action.dart';
import 'state.dart';

Effect<MainState> buildEffect() {
  return combineEffects(<Object, Effect<MainState>>{
    MainAction.action: _onAction,
    Lifecycle.initState: _init
  });
}

void _onAction(Action action, Context<MainState> ctx) {
}
void _init(Action action, Context<MainState> ctx) {
}
