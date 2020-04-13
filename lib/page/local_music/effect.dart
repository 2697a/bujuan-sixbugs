import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import '../../bujuan_music.dart';
import 'action.dart';
import 'state.dart';

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
  BujuanMusic.local().then((local) {
    List responseJson = json.decode(local);
    List<SongBeanEntity> songs =
        responseJson.map((m) => new SongBeanEntity.fromJson(m)).toList();
    Future.delayed(Duration(milliseconds: 200), () {
      ctx.dispatch(LocalMusicActionCreator.getLocalMusic(songs));
    });
  });

}

void _onChangeIndex(Action action, Context<LocalMusicState> ctx) {
  if (action.payload != ctx.state.index) {
    ctx.state.pageController.jumpToPage(action.payload);
    ctx.dispatch(LocalMusicActionCreator.changeIndexState(action.payload));
  }
}
