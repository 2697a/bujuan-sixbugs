
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/constant/theme.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/state.dart';
import 'package:fish_redux/fish_redux.dart';

class PlayBarState implements GlobalBaseState, Cloneable<PlayBarState> {
  @override
  PlayBarState clone() {
    return PlayBarState();
  }

  @override
  AppTheme appTheme;

  @override
  SongBeanEntity currSong;

  @override
  PlayStateType playStateType;

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
  return playBarState;
}
