import 'dart:convert';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/entity/today_song_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/net/http_util.dart';
import 'package:bujuan/net/net_utils.dart';
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
  var today = await NetUtils().getTodaySongs();
  var list = await BuJuanUtil.todayToSongInfo(today.recommend);
  ctx.dispatch(TodayActionCreator.getSheetDeList(list));
}

Future<TodaySongEntity> _getToday() async {
//  Response sheet = await HttpUtil().get('/recommend/songs');
//  var data = sheet.data;
//  var jsonDecode2 = jsonDecode(data);
//  return TodaySongEntity.fromJson(jsonDecode2);
return await NetUtils().getTodaySongs();
}

void _onPlay(Action action, Context<TodayState> ctx) async{
  var list2 = ctx.state.list;
  await NetUtils().setPlayListAndPlayById(list2, list2[action.payload??0], 'today');
}
