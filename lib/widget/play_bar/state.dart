
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/constant/theme.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/global_store/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';

import 'package:flutterstarrysky/song_info.dart';

class PlayBarState implements GlobalBaseState, Cloneable<PlayBarState> {
  bool isMini;
  @override
  PlayBarState clone() {
    return PlayBarState()..isMini=isMini..currSong = currSong..playState = playState;
  }

  @override
  AppTheme appTheme;

  @override
  SongInfo currSong;

  @override
  PlayState playState;

  @override
  int currSongAllPos;

  @override
  int currSongPos;
  @override
  LyricEntity lyric;

  @override
  PlayModeType playModeType;

  @override
  String backPath;

  @override
  double blur;
}

PlayBarState initState(Map<String, dynamic> args) {
  var playBarState = PlayBarState();
  if(args!=null){

  }
  playBarState.isMini = true;
  return playBarState;
}
