import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/constant/theme.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/state.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EntranceState implements GlobalBaseState, Cloneable<EntranceState> {
  int selectIndex;
  PageController pageController;
  bool navBarIsBottom;
  bool val;
  bool miniNav;
  PanelController panelController;

  @override
  EntranceState clone() {
    return EntranceState()
      ..selectIndex = selectIndex
      ..pageController = pageController
      ..navBarIsBottom = navBarIsBottom
      ..appTheme = appTheme
      ..currSong = currSong
      ..panelController = panelController
      ..miniNav = miniNav
      ..playStateType = playStateType;
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

EntranceState initState(Map<String, dynamic> args) {
  final EntranceState state = EntranceState();
  state.selectIndex = 1;
  state.navBarIsBottom = SpUtil.getBool(Constants.BOTTOM_NAV, defValue: false);
  state.pageController =
      PageController(initialPage: state.selectIndex, viewportFraction: 0.99);
  state.miniNav = SpUtil.getBool(Constants.MINI_NAV, defValue: true);
  state.panelController = PanelController();
  state.val = false;
  return state;
}
