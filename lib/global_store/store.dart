import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/constant/theme.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';
import 'package:flutterstarrysky/song_info.dart';
import 'reducer.dart';
import 'state.dart';

class GlobalStore {
  static Store<GlobalState> globalStore;

  static Store<GlobalState> get store {
    var appTheme = AppTheme.getInstance(Constants.dark);
    var playState = PlayState.STOP;
    var string = SpUtil.getString(playSongHistory, defValue: null);
    var mode = SpUtil.getInt(PLAY_MODE, defValue: PlayModeType.REPEAT.index);
    var backPath = SpUtil.getString(USER_BACKGROUND, defValue: null);
    SongInfo songBeanEntity = SongInfo(
        songName: '暂无播放歌曲',
        artist: '暂无歌手信息',
        duration: 100,
        songCover:
            'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3974834430,2578081919&fm=26&gp=0.jpg');
//    if (string != null) {
//      songBeanEntity = SongBeanEntity.fromJson(jsonDecode(string));
//    }
    return globalStore ??= createStore<GlobalState>(
        GlobalState()
          ..appTheme = appTheme
          ..playState = playState
          ..currSong = songBeanEntity
          ..currSongPos = 0
          ..lyric = null
          ..blur = SpUtil.getDouble(BLUR, defValue: 2)
          ..backPath = backPath
          ..playModeType = PlayModeType.values[mode]
          ..currSongAllPos = 100,
        buildReducer());
  }
}
