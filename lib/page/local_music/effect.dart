import 'dart:convert';

import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'action.dart';
import 'state.dart';

const urlFMPlugin =
const BasicMessageChannel('url_fm_plugin', StandardMessageCodec());
Effect<LocalMusicState> buildEffect() {
  return combineEffects(<Object, Effect<LocalMusicState>>{
    Lifecycle.initState: _initState,
    LocalMusicAction.changeIndex: _onChangeIndex,
    LocalMusicAction.ref: _ref,
  });
}

void _initState(Action action, Context<LocalMusicState> ctx) {
  _ref(action, ctx);
}

void _ref(Action action, Context<LocalMusicState> ctx) async {
  var name = await urlFMPlugin.send('local');
  var jsonDecode2 = jsonDecode(name);

  print('本地音乐$name');
  List<SongBeanEntity> songs = [];
  jsonDecode2.forEach((s){
    SongBeanEntity song =  SongBeanEntity.fromJson(s);
    songs.add(song);
  });
  ctx.dispatch(LocalMusicActionCreator.getLocalMusic(songs));
}

void _onChangeIndex(Action action, Context<LocalMusicState> ctx) {
  if (action.payload != ctx.state.index) {
    ctx.state.pageController.jumpToPage(action.payload);
    ctx.dispatch(LocalMusicActionCreator.changeIndexState(action.payload));
  }
}
