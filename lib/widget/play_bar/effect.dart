
import 'package:bujuan/page/play2/page.dart';
import 'package:bujuan/widget/bujuan_bottom_sheet.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:flutterstarrysky/flutter_starry_sky.dart';
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
  Navigator.of(ctx.context)
      .pushNamed('play_view', arguments: null); //注意2
//  if (ctx.state.playState != PlayState.STOP) {
//    showBujuanBottomSheet(
//      context: ctx.context,
//      builder: (BuildContext context) {
//        var width = MediaQuery.of(context).size.height;
//        return Container(
//          height: width,
//          child: PlayView2Page().buildPage(null),
//        );
//      },
//    );
//  } else {
//    openPlayViewAndSendHistory(ctx, action);
//  }
}

void _onTask(Action action, Context<PlayBarState> ctx) async{
  var playStateType = ctx.state.playState;
  if (playStateType != PlayState.STOP)
    if(playStateType == PlayState.START)
    await FlutterStarrySky().pause();
    else
      await FlutterStarrySky().restore();
  else {
    openPlayViewAndSendHistory(ctx, action);
  }
}

void _onNext(Action action, Context<PlayBarState> ctx) async{
  if (ctx.state.playState != PlayState.STOP)
   await FlutterStarrySky().next();
  else {
    openPlayViewAndSendHistory(ctx, action);
  }
}

void openPlayViewAndSendHistory(Context<PlayBarState> ctx, Action action) {
}
