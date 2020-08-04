import 'dart:async';

import 'package:bujuan/entity/banner_entity.dart';
import 'package:bujuan/entity/new_song_entity.dart';
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/page/bujuan_find/action.dart';
import 'package:bujuan/page/bujuan_find/banner/state.dart';
import 'package:bujuan/page/bujuan_find/new_song/state.dart';
import 'package:bujuan/page/bujuan_find/sheet/state.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'state.dart';

Effect<NewFindState> buildEffect() {
  return combineEffects(<Object, Effect<NewFindState>>{
    Lifecycle.initState: _onInit,
    NewFindAction.getRefresh: _onRefresh,
  });
}

Future _onInit(Action action, Context<NewFindState> ctx) async {
//  Future.delayed(Duration(milliseconds: 300), () {
   await _onRefresh(action, ctx);
//  });
}

Future _onRefresh(Action action, Context<NewFindState> ctx) async {
  var netUtils = NetUtils();
  var wait = await Future.wait([netUtils.getBanner(), netUtils.getRecommendResource(), netUtils.getNewSongs()]);
  wait.forEach((data) {
    if (data is BannerEntity) if (data != null) {
      ctx.dispatch(NewFindActionCreator.onGetBanner(
          NewBannerState()..banners = data.banners));
    }
    if (data is PersonalEntity) if (data != null) {
      ctx.dispatch(NewFindActionCreator.onGetSheet(SheetViewState()
        ..clone()
        ..result = data.result));
    }
    if (data is NewSongEntity) if (data != null) {
      List<SongBeanEntity> songs = List();
      Future.forEach(data.result, (song){
        SongBeanEntity songBeanEntity = SongBeanEntity();
        songBeanEntity.name = song.name;
        songBeanEntity.picUrl = song.picUrl;
        songBeanEntity.id = song.id.toString();
        songBeanEntity.singer = song.song.artists[0].name;
        songs.add(songBeanEntity);
      });
      ctx.dispatch(NewFindActionCreator.onGetNewSong(NewSongState()
        ..clone()
        ..result = songs));
    }
  });
}
