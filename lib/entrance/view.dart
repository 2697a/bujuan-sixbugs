import 'dart:ui';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/bujuan_drawer.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/left_page.dart';
import 'package:bujuan/widget/mini_nav_bar.dart';
import 'package:bujuan/widget/nav_bar.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_point_tab_bar/pointTabIndicator.dart';

import '../android_back_desktop.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(EntranceState state, Dispatch dispatch, ViewService viewService) {
  return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: Constants.bottomHeight),
              child: Column(
                children: [
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: Builder(builder: (context) {
                      return IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.menu,size: 26,),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          });
                    }),
                    title: Text('Drink and love money'),
                    centerTitle: true,
                    actions: <Widget>[
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.search,
                          size: 26,
                        ),
                        onPressed: () {
                          Navigator.of(viewService.context).pushNamed('search', arguments: null);
                        },
                      )
                    ],
                  ),
                  TabBar(
//                    isScrollable: true,
                    controller: state.tabController,
                    indicator: PointTabIndicator(
                      position: PointTabIndicatorPosition.bottom,
                      color: Colors.blue.withOpacity(.6),
                      insets: EdgeInsets.only(bottom: 8),
                    ),
                    tabs: state.tabList.map((item) {
                      return Tab(
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(viewService.context).size.width / 4,
                          child: Text(
                            item,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Expanded(
                      child: TabBarView(
                    controller: state.tabController,
                    children: state.pages,
                  )),
                ],
              ),
            ),
            PlayBarPage().buildPage(null)
          ],
        ),
        drawer: BujuanDrawer(
          child: LeftPage(),
        ),
      ),
      onWillPop: () async {
//        if (state.panelController.isPanelOpen) {
//          state.panelController.close();
//        } else {
        AndroidBackTop.backDeskTop(); //设置为返回不退出app
//        }
        return false;
      });
}

///导航栏
Widget _navBar(EntranceState state, dispatch) {
  return state.miniNav
      ? MinNiNavBar(
          items: [
              BottomMiniNavyBarItem(
                activeColor: const Color.fromRGBO(213, 15, 37, 1),
              ),
              BottomMiniNavyBarItem(activeColor: const Color.fromRGBO(238, 178, 17, 1)),
              BottomMiniNavyBarItem(
                activeColor: const Color.fromRGBO(0, 153, 37, 1),
              ),
            ],
          showElevation: false,
          selectedIndex: state.selectIndex,
          onItemSelected: (index) {
            dispatch(EntranceActionCreator.onBottomBarTap(index));
          })
      : NavBar(
          showElevation: false,
          items: [
            BottomNavyBarItem(
              icon: Icon(
                IconData(0xe6c8, fontFamily: 'iconfont'),
                size: 24,
              ),
              title: Text(
                'Me',
                style: TextStyle(fontSize: 14),
              ),
              activeColor: const Color.fromRGBO(213, 15, 37, 1),
            ),
            BottomNavyBarItem(
                icon: Icon(
                  IconData(0xe620, fontFamily: 'iconfont'),
                  size: 24,
                ),
                title: Text(
                  'Find',
                  style: TextStyle(fontSize: 14),
                ),
                activeColor: const Color.fromRGBO(238, 178, 17, 1)),
            BottomNavyBarItem(
              icon: Icon(
                IconData(0xe67b, fontFamily: 'iconfont'),
                size: 24,
              ),
              title: Text(
                'Top',
                style: TextStyle(fontSize: 14),
              ),
              activeColor: const Color.fromRGBO(0, 153, 37, 1),
            ),
          ],
          selectedIndex: state.selectIndex,
          onItemSelected: (index) {
            dispatch(EntranceActionCreator.onBottomBarTap(index));
          });
}
