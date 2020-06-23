import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/constant/theme.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/global_store/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutterstarrysky/song_info.dart';

class RoundPlayInfoState implements GlobalBaseState, Cloneable<RoundPlayInfoState> {
  @override
  RoundPlayInfoState clone() {
    return RoundPlayInfoState()
      ..playModeType = playModeType
      ..currSong = currSong;
  }

  @override
  AppTheme appTheme;

  @override
  String backPath;

  @override
  double blur;

  @override
  SongInfo currSong;

  @override
  int currSongAllPos;

  @override
  int currSongPos;

  @override
  LyricEntity lyric;

  @override
  PlayModeType playModeType;

  @override
  PlayStateType playStateType;
}

RoundPlayInfoState initState(Map<String, dynamic> args) {
  return RoundPlayInfoState();
}
