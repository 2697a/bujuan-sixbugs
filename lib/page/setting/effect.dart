import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SettingState> buildEffect() {
  return combineEffects(<Object, Effect<SettingState>>{
    SettingAction.miniPlay: _onAction,
  });
}

void _onAction(Action action, Context<SettingState> ctx) {
  SpUtil.putBool(Constants.MINI_PLAY, !ctx.state.miniPlay);
  ctx.dispatch(SettingActionCreator.onMiniPlayState(!ctx.state.miniPlay));
}
