import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SettingState> buildEffect() {
  return combineEffects(<Object, Effect<SettingState>>{
    SettingAction.miniPlay: _onAction,
    SettingAction.isHigh: _onIsHigh,
    SettingAction.changeBlur: _onChangeBlur
  });
}

void _onAction(Action action, Context<SettingState> ctx) {
  SpUtil.putBool(MINI_PLAY, !ctx.state.miniPlay);
  ctx.dispatch(SettingActionCreator.onMiniPlayState(!ctx.state.miniPlay));
}

void _onIsHigh(Action action, Context<SettingState> ctx) {
  SpUtil.putBool(HIGH, !ctx.state.isHigh);
  ctx.dispatch(SettingActionCreator.onHighState(!ctx.state.isHigh));
}

void _onChangeBlur(Action action, Context<SettingState> ctx) {
  ctx.state.isBack = true;
  ctx.dispatch(SettingActionCreator.onChangeBlur(true));
}