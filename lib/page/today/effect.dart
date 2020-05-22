import 'dart:convert';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/entity/today_song_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/net/http_util.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import '../../bujuan_music.dart';
import 'action.dart';
import 'state.dart';

Effect<TodayState> buildEffect() {
  return combineEffects(<Object, Effect<TodayState>>{
    Lifecycle.initState: _onAction,
    TodayAction.play: _onPlay,
  });
}

void _onAction(Action action, Context<TodayState> ctx) async{
  var today = await _getToday();
  List<SongBeanEntity> newList = List();
  Future.forEach(today.recommend, (details)async{
    var singerStr = '';
    var ar = details.artists;
    ar.forEach((singer) {
      singerStr += ' ${singer.name} ';
    });
    SongBeanEntity songBeanEntity = SongBeanEntity(
        name: details.name,
        id: details.id.toString(),
        picUrl: details.album.picUrl,
        singer: singerStr,
        mv: details.mvid);
    newList.add(songBeanEntity);
  });
  ctx.dispatch(TodayActionCreator.getSheetDeList(newList));
}

Future<TodaySongEntity> _getToday() async {
  Response sheet = await HttpUtil().get('/recommend/songs');
  var data = sheet.data;
  var jsonDecode2 = jsonDecode(data);
  return TodaySongEntity.fromJson(jsonDecode2);
}

void _onPlay(Action action, Context<TodayState> ctx) {
  SpUtil.putBool(ISFM, false);
  var index2 = action.payload;
  var list2 = ctx.state.list;
  GlobalStore.store.dispatch(GlobalActionCreator.changeCurrSong(list2[index2]));
  SpUtil.putObjectList( playSongListHistory, list2);
  var jsonEncode2 = jsonEncode(list2);
  BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: index2);
}
