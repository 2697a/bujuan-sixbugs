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
  ctx.dispatch(EntranceActionCreator.onPageChange(action.payload));
}

void _onInit(Action action, Context<EntranceState> ctx) async {
  urlFMPlugin.setMessageHandler((message) => Future<String>(() async {
        print(message);
        var s;
        Map map = new Map<String, String>.from(message);
        if (map['type'] == 'getUrl') {
          s = await _getUrl(map['id']);
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
          return  jsonEncode(t);
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
  var answer =
      await song_url({'id': id, 'br': '320000'}, BuJuanUtil.getCookie());
  if (answer.status == 200 && answer.body != null) {
    var body = answer.body['data'][0]['url'];
    return body ?? '';
  } else
    return '';
}

///personal_fm
Future<FmEntity> _getFm() async {
//  Response sheet = await HttpUtil().get('/personal_fm');
//  var data = sheet.data;
//  var jsonDecode2 = jsonDecode(data);
//  return FmEntity.fromJson(jsonDecode2);
}

Future<LyricEntity> _getLyric(id) async {
  var answer = await lyric({'id': id}, BuJuanUtil.getCookie());
  if (answer.status == 200 && answer.body != null) {
    return LyricEntity.fromJson(answer.body);
  } else
    return null;
}
