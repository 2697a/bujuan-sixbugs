import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/constant/theme.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/state.dart';
import 'package:bujuan/page/bujuan_find/page.dart';
import 'package:bujuan/page/local_music/page.dart';
import 'package:bujuan/page/mine/page.dart';
import 'package:bujuan/page/top/page.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EntranceState implements Cloneable<EntranceState> {
  int selectIndex;
  PageController pageController;
  bool val;
  bool miniNav;
  PanelController panelController;
  List<Widget> pages;
  bool isDra;

  @override
  EntranceState clone() {
    return EntranceState()
      ..pages = pages
      ..selectIndex = selectIndex
      ..pageController = pageController
      ..panelController = panelController
      ..isDra = isDra
      ..miniNav = miniNav;
  }
}

EntranceState initState(Map<String, dynamic> args) {
  final EntranceState state = EntranceState();
  state.selectIndex = 1;
  state.pageController =
      PageController(initialPage: state.selectIndex, viewportFraction: 1);
  state.miniNav = SpUtil.getBool(MINI_NAV, defValue: false);
  state.panelController = PanelController();
  state.isDra = false;
  state.val = false;
  state.pages = [
    MinePage().buildPage(null),
    NewFindPage().buildPage(null),
    TopPagePage().buildPage(null),
//    LocalMusicPage().buildPage(null),
  ];
  return state;
}
