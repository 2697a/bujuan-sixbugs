import 'package:bujuan/utils/bujuan_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'action.dart';
import 'state.dart';

Effect<MainState> buildEffect() {
  return combineEffects(<Object, Effect<MainState>>{
    MainAction.action: _onAction,
    Lifecycle.initState: _init,
    Lifecycle.didChangeAppLifecycleState: _ress
  });
}

void _onAction(Action action, Context<MainState> ctx) {}

void _init(Action action, Context<MainState> ctx) {}

void _ress(Action action, Context<MainState> ctx) {
  if (!ctx.state.appTheme.dark) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));
  }
}
