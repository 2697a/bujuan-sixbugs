import 'dart:convert';

import 'package:bujuan/bujuan_music.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/page/fm/page.dart';
import 'package:bujuan/page/play/page.dart';
import 'package:bujuan/page/play2/page.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/bujuan_bottom_sheet.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<PlayBarState> buildEffect() {
  return combineEffects(<Object, Effect<PlayBarState>>{
    PlayBarAction.action: _onAction,
    PlayBarAction.openPlayPage: _onOpenPlay,
    PlayBarAction.sendTask: _onTask,
    PlayBarAction.nextSong: _onNext,
  });
}

void _onAction(Action action, Context<PlayBarState> ctx) {}

void _onOpenPlay(Action action, Context<PlayBarState> ctx) {
  if (ctx.state.playStateType != PlayStateType.Stop) {
    var miniPlay = SpUtil.getBool(MINI_PLAY, defValue: false);
    var isFm = SpUtil.getBool(ISFM, defValue: false);
    showBujuanBottomSheet(
      context: ctx.context,
      builder: (BuildContext context) {
        var width = MediaQuery.of(context).size.height;
//        if (miniPlay) width = width / 1.15;
        return Container(
          height: width,
          child: isFm
              ? FmPlayViewPage().buildPage(null)
              : miniPlay
                  ? PlayViewPage().buildPage(null)
                  : PlayView2Page().buildPage(null),
        );
      },
    );
  } else {
    openPlayViewAndSendHistory(ctx, action);
  }
}

void _onTask(Action action, Context<PlayBarState> ctx) {
  if (ctx.state.playStateType != PlayStateType.Stop)
    BujuanMusic.control(
        task: ctx.state.playStateType == PlayStateType.Playing
            ? 'pause'
            : 'play');
  else {
    openPlayViewAndSendHistory(ctx, action);
  }
}

void _onNext(Action action, Context<PlayBarState> ctx) {
  if (ctx.state.playStateType != PlayStateType.Stop)
    BujuanMusic.control(task: 'next');
  else {
    openPlayViewAndSendHistory(ctx, action);
  }
}

void openPlayViewAndSendHistory(Context<PlayBarState> ctx, Action action) {
  var objectList = SpUtil.getObjectList(playSongListHistory);
  List<SongBeanEntity> songs = List();
  objectList.forEach((Map map) {
    songs.add(SongBeanEntity.fromJson(map));
  });
//  SpUtil.putObjectList(Constants.playSongListHistory, songs);
  var element = ctx.state.currSong;
  var indexWhere = songs.indexWhere((item) => item.id == element.id);
  GlobalStore.store.dispatch(GlobalActionCreator.changeCurrSong(element));
  BujuanMusic.sendSongInfo(songInfo: jsonEncode(songs), index: indexWhere);
}
