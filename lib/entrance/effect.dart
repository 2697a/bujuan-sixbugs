import 'dart:convert';

import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/net/http_util.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

const urlFMPlugin = const BasicMessageChannel('url_fm_plugin', StandardMessageCodec());

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
        builder: (context) => AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), title: Text("检测更新"), content: Text("发现新版本\n$versionInfo"), actions: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text('去github下载'),
            ),
            onTap: () async {
              if (Navigator.canPop(context)) Navigator.pop(context);
              await launch('https://github.com/2697a/bujuan-sixbugs/releases');
            },
          )
        ]),
      );
    } else {
      showDialog(
        context: ctx.context,
        builder: (context) => AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), title: Text("检测更新"), content: Text("当前已是最新版本"), actions: <Widget>[
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


void _onInit(Action action, Context<EntranceState> ctx) async {
  TickerProvider t = (ctx.stfState) as TickerProvider;
  ctx.state.tabController = TabController(length:ctx.state.pages.length,vsync: t,initialIndex: 1);
  FlutterStarrySky().onPlayerStateChanged.listen((PlayState playState) {
    GlobalStore.store.dispatch(GlobalActionCreator.changePlayState(playState));
  });

  FlutterStarrySky().onPlayerSongChanged.listen((event) {
    GlobalStore.store.dispatch(GlobalActionCreator.changeCurrSong(event));
  });

  FlutterStarrySky().onPlayerSongPositionChanged.listen((event) {
    GlobalStore.store.dispatch(GlobalActionCreator.changeSongPos(event));
  });
}

//页面销毁时
void _onDispose(Action action, Context<EntranceState> ctx) {
  ctx.state.pageController?.dispose();
}
