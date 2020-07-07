import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import '../../../bujuan_music.dart';
import 'action.dart';
import 'state.dart';

Effect<NewSongState> buildEffect() {
  return combineEffects(<Object, Effect<NewSongState>>{
    NewSongAction.play: _onAction,
  });
}

void _onAction(Action action, Context<NewSongState> ctx) {
}
