import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/constant/theme.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/state.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';

class PlayViewState implements GlobalBaseState, Cloneable<PlayViewState> {
  List<SongBeanEntity> songList;
  bool isMinni;
  bool showSelect ;

  @override
  PlayViewState clone() {
    return PlayViewState()
      ..currSongPos = currSongPos
      ..currSongAllPos = currSongAllPos
      ..playModeType = playModeType
      ..currSong = currSong
      ..isMinni = isMinni
      ..showSelect = showSelect
      ..songList = songList;
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
}

PlayViewState initState(Map<String, dynamic> args) {
  var playViewState = PlayViewState();
  var objectList = SpUtil.getObjectList(Constants.playSongListHistory);
  List<SongBeanEntity> songs = List();
  objectList.forEach((Map map) {
    songs.add(SongBeanEntity.fromJson(map));
  });
  playViewState.songList = songs;
  playViewState.isMinni = SpUtil.getBool(Constants.MINI_PLAY, defValue: false);
  playViewState.showSelect =false;
  return playViewState;
}
