import 'dart:convert';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/entity/top_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import '../../../bujuan_music.dart';
import 'action.dart';
import 'state.dart';

Effect<TopDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<TopDetailsState>>{
    TopDetailsAction.playSong: _onPlaySong,
    Lifecycle.initState: _init
  });
}

void _onPlaySong(Action action, Context<TopDetailsState> ctx) {
  SpUtil.putBool(ISFM, false);
  var index2 = action.payload;
  var list2 = ctx.state.list;
  GlobalStore.store.dispatch(GlobalActionCreator.changeCurrSong(list2[index2]));
  SpUtil.putObjectList(playSongListHistory, list2);
  var jsonEncode2 = jsonEncode(list2);
  BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: index2);
}

void _init(Action action, Context<TopDetailsState> ctx) {
  _getTopData(ctx.state.id).then((top) {
    ctx.dispatch(TopDetailsActionCreator.onGetTop(_changeType(top)));
  });
}

List<SongBeanEntity> _changeType(TopEntity topEntity) {
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
    songBeanEntity.mv = song.mv;
    list.add(songBeanEntity);
  });
  return list;
}

Future<TopEntity> _getTopData(id) async {
  var answer = await top_list({'idx': id},await BuJuanUtil.getCookie());
//  Response top = await HttpUtil().get('/top/list', data: {'idx': id});
//  var data2 = top.data;
//  var jsonDecode2 = jsonDecode(data2);
  return TopEntity.fromJson(answer.body);
}
