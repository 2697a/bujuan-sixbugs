import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

enum GlobalAction { changeThemeColor, changePlayState, changeCurrSong, changeSongPos, changeSongAllPos,changeLyric ,changePlayMode,changeBack,changeBlur}

class GlobalActionCreator {
  static Action onchangeThemeColor(bool action) {
    return Action(GlobalAction.changeThemeColor, payload: action);
  }

  //改变播放状态
  static Action changePlayState(PlayStateType playStateType) {
    return Action(GlobalAction.changePlayState, payload: playStateType);
  }

  //改变当前播放歌曲
  static Action changeCurrSong(SongBeanEntity currSong) {
    return Action(GlobalAction.changeCurrSong, payload: currSong);
  }

  //改變播放進度條
  static Action changeSongPos(int pos) {
    return Action(GlobalAction.changeSongPos, payload: pos);
  }

  //改變播放总進度條
  static Action changeSongAllPos(int pos) {
    return Action(GlobalAction.changeSongAllPos, payload: pos);
  }

  //改變播放总進度條
  static Action changeLyric(LyricEntity lyricEntity) {
    return Action(GlobalAction.changeLyric, payload: lyricEntity);
  }
  //改變播放总進度條
  static Action changeBack(String path) {
    return Action(GlobalAction.changeBack, payload: path);
  }

  static Action changeBlur(double blur) {
    return Action(GlobalAction.changeBlur, payload: blur);
  }
  static Action getChangePlayMode() {
    return Action(GlobalAction.changePlayMode);
  }
}
