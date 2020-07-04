import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';
import 'package:flutterstarrysky/song_info.dart';
import 'package:fish_redux/fish_redux.dart';

import '../constant/theme.dart';
import '../global_store/state.dart';

class MainState implements GlobalBaseState, Cloneable<MainState> {
  @override
  MainState clone() {
    return MainState();
  }

  @override
  AppTheme appTheme;

  @override
  SongInfo currSong;

  @override
  PlayState playState;


  @override
  int currSongPos;

  @override
  int currSongAllPos;
  @override
  LyricEntity lyric;

  @override
  PlayModeType playModeType;

  @override
  String backPath;

  @override
  double blur;
}

MainState initState(Map<String, dynamic> args) {
  return MainState();
}
