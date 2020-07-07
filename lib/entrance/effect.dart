import 'dart:async';
import 'dart:convert';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/entity/fm_entity.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/net/http_util.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';
import 'package:flutterstarrysky/song_info.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

const urlFMPlugin =
    const BasicMessageChannel('url_fm_plugin', StandardMessageCodec());

Effect<EntranceState> buildEffect() {
  return combineEffects(<Object, Effect<EntranceState>>{
    EntranceAction.bottomBarTap: _onBottomTap,
    EntranceAction.changeUpdate: _onChangeUpdate,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onChangeUpdate(Action action, Context<EntranceState> ctx) async {
  Response data = await HttpUtil().get('/version.json');
  if (data.statusCode == 200) {
    var jsonDecode2 = jsonDecode(data.data);
    print(jsonDecode2);
    var versionCode = jsonDecode2['version_code'];
    var versionInfo = jsonDecode2['version_info'];
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //版本号
    int buildNumber = int.parse(packageInfo.buildNumber);
    if (versionCode > buildNumber) {
      showDialog(
        context: ctx.context,
        builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: Text("检测更新"),
            content: Text("发现新版本\n$versionInfo"),
            actions: <Widget>[
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text('去github下载'),
                ),
                onTap: () async {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                  await launch(
                      'https://github.com/2697a/bujuan-sixbugs/releases');
                },
              )
            ]),
      );
    } else {
      showDialog(
        context: ctx.context,
        builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: Text("检测更新"),
            content: Text("当前已是最新版本"),
            actions: <Widget>[
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text('确认'),
                ),
                onTap: () {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                },
              )
            ]),
      );
    }
    print("=$buildNumber");
  } else {
    BuJuanUtil.showToast('网络错误，请稍后重试');
  }
}

void _onBottomTap(Action action, Context<EntranceState> ctx) {
  ctx.state.pageController.jumpToPage(action.payload);
}

Future<dynamic> _platformCallHandler(MethodCall call) async {
  var method = call.method;
  print('object==========${method}======${call.arguments.toString()}');
  var arguments = call.arguments;
  if (method == 'currSong') {
    //更新当前播放的歌曲
    if (arguments != null)
      await GlobalStore.store.dispatch(GlobalActionCreator.changeCurrSong(
          SongInfo.fromJson(jsonDecode(arguments))));
  } else if (method == 'getUrl') {
    //获取歌曲url
    return await NetUtils().getSongUrl(arguments);
  } else if (method == 'state') {
    if (arguments == 'start') {
      await GlobalStore.store
          .dispatch(GlobalActionCreator.changePlayState(PlayState.START));
    } else if (arguments == 'stop') {
      await GlobalStore.store
          .dispatch(GlobalActionCreator.changePlayState(PlayState.STOP));
    } else if (arguments == 'pause' || arguments == 'completion') {
      await GlobalStore.store
          .dispatch(GlobalActionCreator.changePlayState(PlayState.PAUSE));
    }
  }
}

void _onInit(Action action, Context<EntranceState> ctx) async {
  FlutterStarrySky().onPlayerStateChanged.listen((PlayState playState) {
     GlobalStore.store
        .dispatch(GlobalActionCreator.changePlayState(playState));
  });

  FlutterStarrySky().onPlayerSongChanged.listen((event) {
    print('獲取當前總時長===========${event.duration}');
    GlobalStore.store.dispatch(GlobalActionCreator.changeCurrSong(event));
  });

  FlutterStarrySky().onPlayerSongPositionChanged.listen((event) {
    GlobalStore.store
        .dispatch(GlobalActionCreator.changeSongPos(event));
  });
}

//页面销毁时
void _onDispose(Action action, Context<EntranceState> ctx) {
  ctx.state.pageController?.dispose();
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
