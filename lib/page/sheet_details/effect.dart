
import 'package:bujuan/api/module.dart';
import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/page/sheet_info/page.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:bujuan/widget/bujuan_bottom_sheet.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
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

//播放歌曲
void _onPlay(Action action, Context<SheetDetailsState> ctx) async{
  var list = ctx.state.list;
  var index = action.payload??0;
   NetUtils().setPlayListAndPlayById(list, index, '${ctx.state.playlist.id}');
}

///playlist/subscribe"
void _onLike(Action action, Context<SheetDetailsState> ctx) async {
  ctx.dispatch(SheetDetailsActionCreator.likeState());
  var subscribed2 = ctx.state.playlist.subscribed;
  var answer = await playlist_subscribe(
      {'t': subscribed2 ? 1 : 0, 'id': ctx.state.playlist.id},
      await BuJuanUtil.getCookie());
  print("");
}

Future _onInit(Action action, Context<SheetDetailsState> ctx) async {
  SheetDetailsEntity sheetDetailsEntity = await NetUtils().getPlayListDetails(ctx.state.sheetId);
  var playlist = sheetDetailsEntity.playlist;
  if(playlist.trackIds.length>0){
    var songToSongInfo = await BuJuanUtil.songToSongInfo(playlist.tracks);
    await ctx.dispatch(SheetDetailsActionCreator.getSheetDeList(songToSongInfo));
  }else{
    await ctx.dispatch(SheetDetailsActionCreator.getSheetDeList([]));
  }
  await ctx.dispatch(SheetDetailsActionCreator.sheetInfo(playlist));
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
