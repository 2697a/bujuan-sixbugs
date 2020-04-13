import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class LocalMusicState implements Cloneable<LocalMusicState> {
  List<SongBeanEntity> list;
  bool showLoading = true;
  PageController pageController;
  int index = 1;

  @override
  LocalMusicState clone() {
    return LocalMusicState()
      ..list = list
      ..showLoading = showLoading
      ..pageController = pageController
      ..index = index;
  }
}

LocalMusicState initState(Map<String, dynamic> args) {
  var localMusicState = LocalMusicState();
  localMusicState.showLoading = true;
  localMusicState.pageController = PageController(initialPage: 0);
  localMusicState.index = 0;
  return localMusicState;
}
