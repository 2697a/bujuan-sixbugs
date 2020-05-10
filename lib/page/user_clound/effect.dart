import 'dart:convert';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/api/netease_cloud_music.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/cloud_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/log.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import '../../bujuan_music.dart';
import 'action.dart';
import 'state.dart';

Effect<CloundPageState> buildEffect() {
  return combineEffects(<Object, Effect<CloundPageState>>{
    CloundPageAction.playSong: _onPlaySong,
    Lifecycle.initState: _onAction
  });
}
void _onPlaySong(Action action, Context<CloundPageState> ctx) async {
  SpUtil.putBool(ISFM, false);
  var index2 = action.payload;
  var list2 = ctx.state.list;
  GlobalStore.store.dispatch(GlobalActionCreator.changeCurrSong(list2[index2]));
  SpUtil.putObjectList(playSongListHistory, list2);
  var jsonEncode2 = jsonEncode(list2);
  await BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: index2);
}

void _onAction(Action action, Context<CloundPageState> ctx) async {
  var cloud = await _getUserCloud();
  ctx.dispatch(CloundPageActionCreator.onGetCloud(cloud));
}

Future _getUserCloud() async {
  var answer = await user_cloud({}, await BuJuanUtil.getCookie());
  List<SongBeanEntity> songs = List();
  if (answer.status == 200) {
    var body = answer.body;
    CloudEntity cloudEntity = CloudEntity.fromJson(body);
    if (cloudEntity.code == 200) {
      Future.forEach(cloudEntity.data, (CloudData d) async {
        SongBeanEntity songBeanEntity = SongBeanEntity();
        songBeanEntity.id = d.songId.toString();
        songBeanEntity.name = d.songName;
        songBeanEntity.picUrl = d.simpleSong.al.picUrl;
        songBeanEntity.singer = d.simpleSong.ar[0].name;
        songs.add(songBeanEntity);
      });
    }
    return songs;
  }
}
