import 'dart:async';
import 'dart:convert';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/entity/fm_entity.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'action.dart';
import 'state.dart';

const urlFMPlugin =
    const BasicMessageChannel('url_fm_plugin', StandardMessageCodec());

Effect<EntranceState> buildEffect() {
  return combineEffects(<Object, Effect<EntranceState>>{
    EntranceAction.bottomBarTap: _onBottomTap,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onBottomTap(Action action, Context<EntranceState> ctx) {
  ctx.state.pageController.jumpToPage(action.payload);
}

void _onInit(Action action, Context<EntranceState> ctx) async {
  urlFMPlugin.setMessageHandler((message) => Future<Object>(() async {
        print('原生来获取了====$message');
        var s;
        Map map = new Map<String, String>.from(message);
        if (map['type'] == 'getUrl') {
          var url = await _getUrl(map['id']);
          s = {'url':url};
          return s;
        } else if (map['type'] == 'currSong') {
          var currSong = map['data'];
          if (currSong != null) {
            SongBeanEntity songBeanEntity =
                SongBeanEntity.fromJson(jsonDecode(currSong));
            GlobalStore.store
                .dispatch(GlobalActionCreator.changeCurrSong(songBeanEntity));
          }
          return s;
        } else if (map['type'] == 'state') {
          var state = map['data'];
          if (state != null) {
            ///执行了暂停，播放等操作
            PlayStateType playState;
            if (state == 'start') {
              playState = PlayStateType.Playing;
            } else if (state == 'pause') {
              playState = PlayStateType.Pause;
            } else if (state == 'stop') {
              playState = PlayStateType.Stop;
            } else if (state == 'completion') {
              GlobalStore.store.dispatch(GlobalActionCreator.changeSongPos(0));
              GlobalStore.store
                  .dispatch(GlobalActionCreator.changeSongAllPos(100));
            }
            GlobalStore.store
                .dispatch(GlobalActionCreator.changePlayState(playState));
          }
          return s;
        } else if (map['type'] == 'getLyric') {
          var t = await _getLyric(map['id']);
          var data = {'lyric':jsonEncode(t)};
          return data;
        } else if (map['type'] == 'getFm') {
          var t = await _getFm();
          List<SongBeanEntity> songs = List();
          t.data.forEach((data) {
            SongBeanEntity songBeanEntity = SongBeanEntity();
            songBeanEntity.id = data.id.toString();
            songBeanEntity.name = data.name;
            songBeanEntity.singer = data.artists[0].name;
            songBeanEntity.picUrl = data.album.picUrl;
            songBeanEntity.mv = data.mvid;
            songs.add(songBeanEntity);
          });
          return {'fm':jsonEncode(songs)};
        } else {
          return s;
        }
      }));
}

//页面销毁时
void _onDispose(Action action, Context<EntranceState> ctx) {
  ctx.state.pageController?.dispose();
}

//获取播放地址
Future<String> _getUrl(id) async {
  var isHigh = SpUtil.getBool(Constants.HIGH,defValue: false);
  var answer =
      await song_url({'id': id, 'br': isHigh?'320000':'128000'}, await BuJuanUtil.getCookie());
  if (answer.status == 200 && answer.body != null) {
    var body = answer.body['data'][0]['url'];
    return body ?? '';
  } else
    return '';
}

///personal_fm
Future<FmEntity> _getFm() async {
  var answer = await personal_fm({}, await BuJuanUtil.getCookie());
  if (answer.status == 200 && answer.body != null) {
    return FmEntity.fromJson(answer.body);
  } else
    return null;
}

Future<LyricEntity> _getLyric(id) async {
  var answer = await lyric({'id': id}, await BuJuanUtil.getCookie());
  if (answer.status == 200 && answer.body != null) {
    return LyricEntity.fromJson(answer.body);
  } else
    return null;
}
