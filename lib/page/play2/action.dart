import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/widget/lyric/lyric_controller.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

//TODO replace with your own action
enum PlayView2Action {
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
    return Action(PlayView2Action.skipPrevious);
  }

  static Action playOrPause() {
    return Action(PlayView2Action.playOrPause);
  }

  static Action skipNext() {
    return Action(PlayView2Action.skipNext);
  }

  static Action playSingleSong(index) {
    return Action(PlayView2Action.playSingleSong, payload: index);
  }

  static Action seekTo(seekNum) {
    return Action(PlayView2Action.seekTo, payload: seekNum);
  }

  static Action getUrl() {
    return Action(PlayView2Action.getUrl);
  }

  static Action getSongPos(int pos) {
    return Action(PlayView2Action.getSongPos, payload: pos);
  }

  static Action getSongAllPos(int allPos) {
    return Action(PlayView2Action.getSongAllPos, payload: allPos);
  }

  static Action getSongTalk(String id) {
    return Action(PlayView2Action.getTalk, payload: id);
  }

  static Action getChangePlayMode() {
    return Action(PlayView2Action.changePlayMode);
  }

  static Action getLikeOrUnLike(bool isLike) {
    return Action(PlayView2Action.likeOrUnLike,payload: isLike);
  }

  static Action getChangeLike() {
    return Action(PlayView2Action.changeLikeState);
  }
  static Action changeTickerProvider(LyricController t) {
    return Action(PlayView2Action.changeTickerProvider,payload: t);
  }
  static Action changerDrr(bool isDrr) {
    return Action(PlayView2Action.changeTickerProvider,payload: isDrr);
  }
}
