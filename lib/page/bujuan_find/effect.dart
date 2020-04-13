import 'dart:async';
import 'dart:convert';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/entity/banner_entity.dart';
import 'package:bujuan/entity/new_song_entity.dart';
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/page/bujuan_find/action.dart';
import 'package:bujuan/page/bujuan_find/banner/state.dart';
import 'package:bujuan/page/bujuan_find/new_song/state.dart';
import 'package:bujuan/page/bujuan_find/sheet/state.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'state.dart';

Effect<NewFindState> buildEffect() {
  return combineEffects(<Object, Effect<NewFindState>>{
    Lifecycle.initState: _onInit,
    NewFindAction.getRefresh: _onRefresh,
  });
}

void _onInit(Action action, Context<NewFindState> ctx) {
  _onRefresh(action, ctx);
}

void _onRefresh(Action action, Context<NewFindState> ctx) async {
  _getBanner().then((BannerEntity banner) {
    if (banner != null) {
      SpUtil.putString('banner', jsonEncode(banner));
      ctx.dispatch(NewFindActionCreator.onGetBanner(NewBannerState()..banners = banner.banners));
    }
  });

  _getSheet().then((PersonalEntity person) {
    if (person != null) {
      SpUtil.putString('sheet', jsonEncode(person));
      ctx.dispatch(NewFindActionCreator.onGetSheet(SheetViewState()
        ..clone()
        ..result = person.result));
    }
  });

  _getNewSong().then((NewSongEntity songEntity) {
    if (songEntity != null) {
      List<SongBeanEntity> songs = List();
      songEntity.result.forEach((song) {
        SongBeanEntity songBeanEntity = SongBeanEntity();
        songBeanEntity.name = song.name;
        songBeanEntity.picUrl = song.picUrl;
        songBeanEntity.id = song.id.toString();
        songBeanEntity.singer = song.song.artists[0].name;
        songs.add(songBeanEntity);
      });
      SpUtil.putString('newSong', jsonEncode(songs));
      ctx.dispatch(NewFindActionCreator.onGetNewSong(NewSongState()
        ..clone()
        ..result = songs));
    }
  });
}

Future<PersonalEntity> _getSheet() async {
  var answer = await personalized({}, BuJuanUtil.getCookie());
//  Response sheet = await HttpUtil().get('/personalized');
//  var data = sheet.data;
//  SpUtil.putString('sheet', data);
//  var jsonDecode2 = jsonDecode(data);
  return answer.status == 200 ? PersonalEntity.fromJson(answer.body) : null;
}

Future<BannerEntity> _getBanner() async {
  var answer = await banner({}, BuJuanUtil.getCookie());
//  Response banner = await HttpUtil().get('/banner', data: {'type': 1});
//  var data2 = banner.data;
//  SpUtil.putString('banner', data2);
//  var jsonDecode2 = jsonDecode(data2);
  return answer.status == 200 ? BannerEntity.fromJson(answer.body) : null;
}

Future<NewSongEntity> _getNewSong() async {
  var answer = await personalized_newsong({}, BuJuanUtil.getCookie());
//  Response newSong = await HttpUtil().get('/personalized/newsong');
//  var data2 = newSong.data;
//  SpUtil.putString('newSong', data2);
//  var jsonDecode2 = jsonDecode(data2);
  return answer.status == 200 ? NewSongEntity.fromJson(answer.body) : null;
}
