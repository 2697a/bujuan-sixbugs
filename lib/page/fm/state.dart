import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/constant/theme.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/state.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FmPlayViewState implements GlobalBaseState, Cloneable<FmPlayViewState> {
  List<SongBeanEntity> songList;
  bool isMinni;
  bool showSelect ;
  PanelController panelController;

  @override
  FmPlayViewState clone() {
    return FmPlayViewState()
      ..currSongPos = currSongPos
      ..currSongAllPos = currSongAllPos
      ..playModeType = playModeType
      ..currSong = currSong
      ..isMinni = isMinni
      ..showSelect = showSelect
      ..panelController = panelController
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

  @override
  String backPath;

  @override
  double blur;
}

FmPlayViewState initState(Map<String, dynamic> args) {
  var playViewState = FmPlayViewState();
  var objectList = SpUtil.getObjectList(playSongListHistory);
  List<SongBeanEntity> songs = List();
  objectList.forEach((Map map) {
    songs.add(SongBeanEntity.fromJson(map));
  });
  playViewState.songList = songs;
  playViewState.isMinni = SpUtil.getBool(MINI_PLAY, defValue: false);
  playViewState.showSelect =false;
  if(args!=null)playViewState.panelController = args['panel'];
  return playViewState;
}
