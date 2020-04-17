import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/constant/theme.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

abstract class GlobalBaseState {
  AppTheme get appTheme;

  SongBeanEntity get currSong;

  PlayStateType get playStateType;

  LyricEntity get lyric;

  int get currSongPos;

  int get currSongAllPos;

  String get backPath;

  double get blur;

  PlayModeType get playModeType;

  set appTheme(AppTheme appTheme);

  set currSong(SongBeanEntity currSong);

  set playStateType(PlayStateType playStateType);

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
      ..playStateType = playStateType
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
  SongBeanEntity currSong;

  @override
  PlayStateType playStateType;

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
