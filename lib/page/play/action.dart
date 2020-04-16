import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/widget/lyric/lyric_controller.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

//TODO replace with your own action
enum PlayViewAction {
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
    return Action(PlayViewAction.skipPrevious);
  }

  static Action playOrPause() {
    return Action(PlayViewAction.playOrPause);
  }

  static Action skipNext() {
    return Action(PlayViewAction.skipNext);
  }

  static Action playSingleSong(index) {
    return Action(PlayViewAction.playSingleSong, payload: index);
  }

  static Action seekTo(seekNum) {
    return Action(PlayViewAction.seekTo, payload: seekNum);
  }

  static Action getUrl() {
    return Action(PlayViewAction.getUrl);
  }

  static Action getSongPos(int pos) {
    return Action(PlayViewAction.getSongPos, payload: pos);
  }

  static Action getSongAllPos(int allPos) {
    return Action(PlayViewAction.getSongAllPos, payload: allPos);
  }

  static Action getSongTalk(String id) {
    return Action(PlayViewAction.getTalk, payload: id);
  }

  static Action getChangePlayMode() {
    return Action(PlayViewAction.changePlayMode);
  }

  static Action getLikeOrUnLike(bool isLike) {
    return Action(PlayViewAction.likeOrUnLike,payload: isLike);
  }

  static Action getChangeLike() {
    return Action(PlayViewAction.changeLikeState);
  }
  static Action changeTickerProvider(LyricController t) {
    return Action(PlayViewAction.changeTickerProvider,payload: t);
  }
  static Action changerDrr(bool isDrr) {
    return Action(PlayViewAction.changeTickerProvider,payload: isDrr);
  }
}
