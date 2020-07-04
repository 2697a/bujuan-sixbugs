import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/constant/theme.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';

import 'package:flutterstarrysky/song_info.dart';

abstract class GlobalBaseState {
  AppTheme get appTheme;

  SongInfo get currSong;

  PlayState get playState;

  LyricEntity get lyric;

  int get currSongPos;

  int get currSongAllPos;

  String get backPath;

  double get blur;

  PlayModeType get playModeType;

  set appTheme(AppTheme appTheme);

  set currSong(SongInfo currSong);

  set playState(PlayState playState);

  set currSongPos(int currSongPos);

  set currSongAllPos(int currSongAllPos);

  set lyric(LyricEntity lyric);

  set playModeType(PlayModeType  playModeType);

  set backPath(String backPath);

  set blur(double blur);
}

class GlobalState extends GlobalBaseState implements Cloneable<GlobalState> {
  @override
  GlobalState clone() {
    print("GlobalState clone");
    return GlobalState()
      ..appTheme = appTheme
      ..playState = playState
      ..currSong = currSong
      ..currSongPos = currSongPos
      ..lyric = lyric
      ..blur = blur
      ..backPath = backPath
      ..playModeType = playModeType
      ..currSongAllPos = currSongAllPos;
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
