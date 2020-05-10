import 'dart:async';
import 'dart:io';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/page/play2/action.dart';
import 'package:bujuan/page/talk/page.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/bujuan_bottom_sheet.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../../bujuan_music.dart';
import 'state.dart';

StreamSubscription listen;
const playPlugin = const EventChannel('com.sixbugs.bujuan/music_play');
Effect<PlayView2State> buildEffect() {
  return combineEffects(<Object, Effect<PlayView2State>>{
    Lifecycle.initState: _onInit,
    PlayView2Action.playOrPause: _onTask,
    PlayView2Action.skipPrevious: _onPrevious,
    PlayView2Action.skipNext: _onNext,
    PlayView2Action.seekTo: _onSeekTo,
    PlayView2Action.playSingleSong: _onPlaySingleSong,
    PlayView2Action.getTalk: _onGetTalk,
    PlayView2Action.changePlayMode: _onPlayMode,
    PlayView2Action.likeOrUnLike: _onLike,
    PlayView2Action.getUrl:_onGetUrl,
    Lifecycle.dispose: _dispose,
  });
}

void _onInit(Action action, Context<PlayView2State> ctx)  {
  TickerProvider t = (ctx.stfState) as TickerProvider;
//  var lyricController = LyricController(vsync: t);
//   ctx.dispatch(PlayViewActionCreator.changeTickerProvider(lyricController));
//  if (ctx.state.lyric == null)
//    _getLyric(ctx.state.currSong.id).then((lyric) {
//      GlobalStore.store.dispatch(GlobalActionCreator.changeLyric(lyric));
//    });
  Stream stream = playPlugin.receiveBroadcastStream();
  listen = stream.listen((_) {
    _onEvent(_, ctx);
  }, onError: _onError);
}

void _dispose(Action action, Context<PlayView2State> ctx) {
  listen?.cancel();
}

void _onPlayMode(Action action, Context<PlayView2State> ctx) {
  PlayModeType playModeType2 = ctx.state.playModeType;
  GlobalStore.store.dispatch(GlobalActionCreator.getChangePlayMode());
  switch (playModeType2) {
    case PlayModeType.REPEAT:
      BujuanMusic.setMode(PlayModeType.REPEAT_ONE.index);
      SpUtil.putInt(PLAY_MODE, PlayModeType.REPEAT_ONE.index);
      break;
    case PlayModeType.REPEAT_ONE:
      BujuanMusic.setMode(PlayModeType.SHUFFLE.index);
      SpUtil.putInt(PLAY_MODE, PlayModeType.SHUFFLE.index);
      break;
    case PlayModeType.SHUFFLE:
      BujuanMusic.setMode(PlayModeType.REPEAT.index);
      SpUtil.putInt(PLAY_MODE, PlayModeType.REPEAT.index);
      break;
  }
}


void _onEvent(Object event, Context<PlayView2State> ctx) {
  Map<String, dynamic> tag = Map<String, dynamic>.from(event);
  var pos = tag['currSongPos'];
  var allPos = tag['currSongAllPos'];

  ///歌曲进度
  if (pos != null) {
    GlobalStore.store.dispatch(GlobalActionCreator.changeSongPos(int.parse(pos)));
  }

  if (allPos != null) {
    GlobalStore.store.dispatch(GlobalActionCreator.changeSongAllPos(int.parse(allPos)));
  }
}

void _onError(Object error) {
  print('===_onError=========================$error');
}

//控制播放或暂停
void _onTask(Action action, Context<PlayView2State> ctx) {
  if (ctx.state.playStateType != PlayStateType.Stop) BujuanMusic.control(task: ctx.state.playStateType == PlayStateType.Playing ? 'pause' : 'play');
}

//下一首
void _onNext(Action action, Context<PlayView2State> ctx) {
  if (ctx.state.playStateType != PlayStateType.Stop) {
    BujuanMusic.control(task: 'next');
  }
}

//上一首
void _onPrevious(Action action, Context<PlayView2State> ctx) {
  if (ctx.state.playStateType != PlayStateType.Stop) {
    BujuanMusic.control(task: 'previous');
  }
}

//改变播放进度
void _onSeekTo(Action action, Context<PlayView2State> ctx) {
  BujuanMusic.seekTo(action.payload);
}

//播放单手音乐
void _onPlaySingleSong(Action action, Context<PlayView2State> ctx) {
  BujuanMusic.playIndex(index: action.payload);
}

void _onGetTalk(Action action, Context<PlayView2State> ctx) {
  showBujuanBottomSheet(
    context: ctx.context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    builder: (BuildContext context) {
      var width = MediaQuery
          .of(context)
          .size
          .height;
      return Container(
        height: width / 1.1,
        child: TalkPage().buildPage({'id': action.payload}),
      );
    },
  );
}

void _onGetUrl(Action action, Context<PlayView2State> ctx) async {
//  var url = await _getUrl(ctx.state.currSong.id);
//  var _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
//
//  final savedDir = Directory(_localPath);
//  bool hasExisted = await savedDir.exists();
//  if (!hasExisted) {
//    savedDir.create();
//  }
//  final taskId = await FlutterDownloader.enqueue(
//    url: url,
//    fileName: '${ctx.state.currSong.name}.mp3',
//    savedDir: _localPath,
//    showNotification: true, // show download progress in status bar (for Android)
//    openFileFromNotification: false, // click on notification to open downloaded file (for Android)
//  );
}

Future<String> _findLocalPath() async {
  final directory = await getExternalStorageDirectory();
  return directory.path;
}
//获取播放地址
Future<String> _getUrl(id) async{
  var answer = await song_url({'id':id,'br':'320000'},await BuJuanUtil.getCookie());
  if (answer.status == 200 && answer.body != null) {
    var body = answer.body['data'][0]['url'];
    return body;
  } else
    return null;
}
void _onLike(Action action, Context<PlayView2State> ctx) async {
  ctx.dispatch(PlayViewActionCreator.getChangeLike());
  var answer = await like_song({'id': ctx.state.currSong.id, 'like': '${action.payload}'},await BuJuanUtil.getCookie());
//  Response data = await HttpUtil().post('/like',
//      data: {'id': ctx.state.currSong.id, 'like': '${action.payload}'});
  if (answer.status == 200) {
    var stringList = SpUtil.getStringList(LIKE_SONGS, defValue: []);
    if (!action.payload) {
      stringList.add(ctx.state.currSong.id);
    } else {
      stringList.remove(ctx.state.currSong.id);
    }
    SpUtil.putStringList(LIKE_SONGS, stringList);
  }
}

Future<LyricEntity> _getLyric(id) async {
  var answer = await lyric({'id': id},await BuJuanUtil.getCookie());
//  Response sheet = await HttpUtil().get('/lyric', data: {'id': id});
//  var data = sheet.data;
//  var jsonDecode2 = jsonDecode(data);q
  if (answer.status == 200 && answer.body != null) {
    return LyricEntity.fromJson(answer.body);
  } else
    return null;
}
