import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
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
  SpUtil.putBool(ISFM, false);
  var index2 = action.payload;
  GlobalStore.store
      .dispatch(GlobalActionCreator.changeCurrSong(ctx.state.result[index2]));
  SpUtil.putObjectList(playSongListHistory, ctx.state.result);
  var jsonEncode2 = jsonEncode(ctx.state.result);
  BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: index2);
}
