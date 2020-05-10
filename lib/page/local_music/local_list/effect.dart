import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import '../../../bujuan_music.dart';
import 'action.dart';
import 'state.dart';

Effect<LocalListState> buildEffect() {
  return combineEffects(<Object, Effect<LocalListState>>{
    LocalListAction.action: _onAction,
    LocalListAction.playLocal: _onPlayMusic
  });
}

void _onAction(Action action, Context<LocalListState> ctx) {
}
void _onPlayMusic(Action action, Context<LocalListState> ctx) {
  SpUtil.putBool(ISFM, false);
  var index2 = action.payload;
  GlobalStore.store
      .dispatch(GlobalActionCreator.changeCurrSong(ctx.state.list[index2]));
  SpUtil.putObjectList(playSongListHistory, ctx.state.list);
  var jsonEncode2 = jsonEncode(ctx.state.list);
  print('播放=====$jsonEncode2');
  BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: index2);
}
