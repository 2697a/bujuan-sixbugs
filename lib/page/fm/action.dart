import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/widget/lyric/lyric_controller.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

//TODO replace with your own action
enum FmPlayViewAction {
  skipPrevious,
  playOrPause,
  skipNext,
  playSingleSong,
  seekTo,
  getUrl,
  getSongPos,
  getSongAllPos,
  getTalk,
  changePlayMode,
  likeOrUnLike,
  changeLikeState,
  changeTickerProvider,
  changerDrr,
}

class PlayViewActionCreator {
  static Action skipPrevious() {
    return Action(FmPlayViewAction.skipPrevious);
  }

  static Action playOrPause() {
    return Action(FmPlayViewAction.playOrPause);
  }

  static Action skipNext() {
    return Action(FmPlayViewAction.skipNext);
  }

  static Action playSingleSong(index) {
    return Action(FmPlayViewAction.playSingleSong, payload: index);
  }

  static Action seekTo(seekNum) {
    return Action(FmPlayViewAction.seekTo, payload: seekNum);
  }

  static Action getUrl() {
    return Action(FmPlayViewAction.getUrl);
  }

  static Action getSongPos(int pos) {
    return Action(FmPlayViewAction.getSongPos, payload: pos);
  }

  static Action getSongAllPos(int allPos) {
    return Action(FmPlayViewAction.getSongAllPos, payload: allPos);
  }

  static Action getSongTalk(String id) {
    return Action(FmPlayViewAction.getTalk, payload: id);
  }

  static Action getChangePlayMode() {
    return Action(FmPlayViewAction.changePlayMode);
  }

  static Action getLikeOrUnLike(bool isLike) {
    return Action(FmPlayViewAction.likeOrUnLike,payload: isLike);
  }

  static Action getChangeLike() {
    return Action(FmPlayViewAction.changeLikeState);
  }
  static Action changeTickerProvider(LyricController t) {
    return Action(FmPlayViewAction.changeTickerProvider,payload: t);
  }
  static Action changerDrr(bool isDrr) {
    return Action(FmPlayViewAction.changeTickerProvider,payload: isDrr);
  }
}
