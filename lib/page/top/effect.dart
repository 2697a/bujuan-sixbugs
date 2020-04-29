import 'dart:convert';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/singer_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/entity/top_entity.dart';
import 'package:bujuan/entity/top_mv_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<TopPageState> buildEffect() {
  return combineEffects(<Object, Effect<TopPageState>>{
    Lifecycle.initState: _init,
    TopPageAction.getRef: _onRefresh,
    TopPageAction.openDetail: _onOpen
  });
}

void _init(Action action, Context<TopPageState> ctx) async {
   Future.delayed(Duration(milliseconds: 500),()async{
  await _onRefresh(action, ctx);
   });
}

void _onOpen(Action action, Context<TopPageState> ctx) {
  var id = action.payload['id'];
  Navigator.of(ctx.context)
      .pushNamed('top_details', arguments: {'id': id}); //注意2
}

//0: "3779629", //云音乐新歌榜
//1: "3778678", //云音乐热歌榜
//2: "2884035", //云音乐原创榜
//3: "19723756", //云音乐飙升榜
//4: "10520166", //云音乐电音榜
Future _onRefresh(Action action, Context<TopPageState> ctx) async {
  var list = await Future.wait([
    _getTopData('19723756'),
    _getTopData('3779629'),
    _getTopData('2884035'),
    _getTopData('3778678')
  ]);
  var top1 = list[0];
// SpUtil.putString('bs', jsonEncode(changeType(top)));
  ctx.dispatch(TopPageActionCreator.onGetTop(changeType(top1), TopType.BS));
  var top2 = list[1];
//  SpUtil.putString('new', jsonEncode(changeType(top)));
  ctx.dispatch(TopPageActionCreator.onGetTop(changeType(top2), TopType.NEW));
  var top3 = list[2];
//  SpUtil.putString('yc', jsonEncode(changeType(top)));
  ctx.dispatch(TopPageActionCreator.onGetTop(changeType(top3), TopType.YC));
  var top4 = list[3];
//  SpUtil.putString('hot', jsonEncode(changeType(top)));
  ctx.dispatch(TopPageActionCreator.onGetTop(changeType(top4), TopType.HOT));
}

List<SongBeanEntity> changeType(TopEntity topEntity) {
  List<SongBeanEntity> list = List();
  topEntity.playlist.tracks.forEach((song) {
    SongBeanEntity songBeanEntity = SongBeanEntity();
    songBeanEntity.id = song.id.toString();
    songBeanEntity.name = song.name;
    songBeanEntity.picUrl = song.al.picUrl;
    var singerStr = '';
    var ar = song.ar;
    ar.forEach((singer) {
      singerStr += ' ${singer.name} ';
    });
    songBeanEntity.singer = singerStr;
    list.add(songBeanEntity);
  });
  return list;
}

Future<TopEntity> _getTopData(id) async {
  var answer = await top_list({'idx': id}, await BuJuanUtil.getCookie());
//  Response top = await HttpUtil().get('/top/list', data: {'idx': id});
//  var data2 = top.data;
//  var jsonDecode2 = jsonDecode(data2);
  return TopEntity.fromJson(answer.body);
}

///top/artists
Future<SingerEntity> _getTopSinger() async {
//  Response top = await HttpUtil().get('/top/artists', data: {'limit': 10});
//  var data2 = top.data;
//  var jsonDecode2 = jsonDecode(data2);
//  return SingerEntity.fromJson(jsonDecode2);
}

///top/mv
Future<TopMvEntity> _getTopMv() async {
//  Response top = await HttpUtil().get('/top/mv', data: {'limit': 10});
//  var data2 = top.data;
//  var jsonDecode2 = jsonDecode(data2);
//  return TopMvEntity.fromJson(jsonDecode2);
}
