import 'dart:ui';

import 'package:bujuan/constant/Screens.dart';
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
Widget buildView(
    EntranceState state, Dispatch dispatch, ViewService viewService) {
  return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
//        appBar: AppBar(
//          elevation: 0,
//          backgroundColor: Colors.transparent,
//          leading: Builder(builder: (context) {
//            return IconButton(
//                padding: EdgeInsets.all(0),
//                icon: ImageHelper.getImage(
//                    SpUtil.getString('head',
//                        defValue:
//                        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588014709572&di=019dc384d533dd0fe890ec9d4e26beeb&imgtype=0&src=http%3A%2F%2Fp1.qhimgs4.com%2Ft01a30c675c53e713c2.jpg'),
//                    height: 32,
//                    isRound: true),
//                onPressed: () {
//                  Scaffold.of(context).openDrawer();
//                });
//          }),
//          title: Text('归山深浅去，须尽丘壑美。'),
////          bottom: _navBar(state, dispatch),
//          centerTitle: true,
//          actions: <Widget>[
//            IconButton(
//              padding: EdgeInsets.all(0),
//              icon: Icon(
//                Icons.search,
//                size: 28,
//              ),
//              onPressed: () {
//                Navigator.of(viewService.context)
//                    .pushNamed('search', arguments: null);
//              },
//            )
//          ],
//        ),
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
                          icon: ImageHelper.getImage(
                              SpUtil.getString('head',
                                  defValue:
                                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588014709572&di=019dc384d533dd0fe890ec9d4e26beeb&imgtype=0&src=http%3A%2F%2Fp1.qhimgs4.com%2Ft01a30c675c53e713c2.jpg'),
                              height: 32,
                              isRound: true),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          });
                    }),
                    title: Text('归山深浅去，须尽丘壑美。'),
                    centerTitle: true,
                    actions: <Widget>[
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.search,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.of(viewService.context)
                              .pushNamed('search', arguments: null);
                        },
                      )
                    ],
                  ),
                  TabBar(tabs: state.tabs,controller: state.tabController,indicatorWeight: 1,
                    indicatorSize: TabBarIndicatorSize.tab,
                    isScrollable: true,
                    indicatorPadding: EdgeInsets.only(bottom: 0.0),
                    labelPadding: EdgeInsets.only(left: 0),),
                  Expanded(child: TabBarView(
                    controller: state.tabController,
                    children: state.pages,
                  )),
//                  _navBar(state, dispatch),
//                  Expanded(
//                    child: PageView.builder(
//                      physics: BouncingScrollPhysics(),
//                      itemBuilder: (context, index) {
//                        return state.pages[index];
//                      },
//                      itemCount: state.pages.length,
//                      controller: state.pageController,
//                      onPageChanged: (index) {
//                        dispatch(EntranceActionCreator.onPageChange(index));
//                      },
//                    ),
//                  )
                ],
              ),
            ),
            PlayBarPage().buildPage(null)
          ],
        ),
//        floatingActionButton: PlayBarPage().buildPage(null),
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
              BottomMiniNavyBarItem(
                  activeColor: const Color.fromRGBO(238, 178, 17, 1)),
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
