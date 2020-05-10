import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import '../../../bujuan_music.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchSongState> buildEffect() {
  return combineEffects(<Object, Effect<SearchSongState>>{
    SearchSongAction.playSong: _playSong,
  });
}

void _playSong(Action action, Context<SearchSongState> ctx) {
  SpUtil.putBool(ISFM, false);
  var index2 = action.payload;
//  GlobalStore.store.dispatch(GlobalActionCreator.changeCurrSong(ctx.state.songs[index2]));
  SpUtil.putObjectList(playSongListHistory, ctx.state.songs);
  var jsonEncode2 = jsonEncode(ctx.state.songs);
  BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: index2);
}
