import 'dart:convert';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/page/sheet_info/page.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/bujuan_bottom_sheet.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import '../../bujuan_music.dart';
import 'action.dart';
import 'state.dart';

Effect<SheetDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<SheetDetailsState>>{
    SheetDetailsAction.play: _onPlay,
    Lifecycle.initState: _onInit,
    SheetDetailsAction.infoPage: _openInfo,
    SheetDetailsAction.like: _onLike,
    Lifecycle.dispose: _onDispose
  });
}

void _onPlay(Action action, Context<SheetDetailsState> ctx) async{
  SpUtil.putBool(ISFM, false);
  var index2 = action.payload;
  GlobalStore.store
      .dispatch(GlobalActionCreator.changeCurrSong(ctx.state.list[index2]));
  SpUtil.putObjectList(playSongListHistory, ctx.state.list);

  var jsonEncode2 = jsonEncode( ctx.state.list);
  await BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: index2);
}

///playlist/subscribe"
void _onLike(Action action, Context<SheetDetailsState> ctx) async {
  ctx.dispatch(SheetDetailsActionCreator.likeState());
  var subscribed2 = ctx.state.playlist.subscribed;
  var answer = await playlist_subscribe(
      {'t': subscribed2 ? 1 : 0, 'id': ctx.state.playlist.id},
      await BuJuanUtil.getCookie());
}

Future _onInit(Action action, Context<SheetDetailsState> ctx) async {
  var answer =
      await playlist_detail({'id': ctx.state.sheetId},await BuJuanUtil.getCookie());
  SheetDetailsEntity sheetDetailsEntity =
      SheetDetailsEntity.fromJson(Map<String, dynamic>.from(answer.body));
  var playlist = sheetDetailsEntity.playlist;
  List<SongBeanEntity> newList = List();
  Future.forEach(playlist.tracks, (details)async{
    var singerStr = '';
    var ar = details.ar;
    ar.forEach((singer) {
      singerStr += ' ${singer.name} ';
    });
    SongBeanEntity songBeanEntity = SongBeanEntity(
        name: details.name,
        id: details.id.toString(),
        picUrl: details.al.picUrl,
        singer: singerStr,
        mv: details.mv);
    newList.add(songBeanEntity);
  });
  await ctx.dispatch(SheetDetailsActionCreator.sheetInfo(playlist));
  await ctx.dispatch(SheetDetailsActionCreator.getSheetDeList(newList));
  ctx.state.isShowLoading = false;
}
void _onDispose(Action action, Context<SheetDetailsState> ctx){
}
void _openInfo(Action action, Context<SheetDetailsState> ctx) {
//  var i = SpUtil.getInt(Constants.USER_ID, defValue: -1);
//  var userId2 = ctx.state.playlist.creator.userId;
//  if (userId2 != i) {
  showBujuanBottomSheet(
    context: ctx.context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    builder: (BuildContext context) {
      var width = MediaQuery.of(context).size.height / 1.1;
      return Container(
        height: width,
        child: SheetInfoPage().buildPage({'playlist': ctx.state.playlist}),
      );
    },
  );
//  }
}
