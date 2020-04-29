import 'dart:ui';

import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/bujuan_background.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/left_page.dart';
import 'package:bujuan/widget/mini_nav_bar.dart';
import 'package:bujuan/widget/nav_bar.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../android_back_desktop.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    EntranceState state, Dispatch dispatch, ViewService viewService) {
//  ScreenUtil.init(viewService.context,
//      width: 375, height: 812, allowFontScaling: false);
//  return _body(state, dispatch, viewService);
  return WillPopScope(
      child: Scaffold(
        body: SlidingUpPanel(
          color: Colors.transparent,
          controller: state.panelController,
          minHeight: Screens.setHeight(56),
          maxHeight: MediaQuery.of(viewService.context).size.height,
          boxShadow: null,
          panel: _leftChild(state, dispatch, viewService),
          collapsed: PlayBarPage().buildPage(null),
          body: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                leading: InkWell(
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      icon: ImageHelper.getImage(
                          SpUtil.getString('head',
                              defValue:
                                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588014709572&di=019dc384d533dd0fe890ec9d4e26beeb&imgtype=0&src=http%3A%2F%2Fp1.qhimgs4.com%2Ft01a30c675c53e713c2.jpg'),
                          height: 32,
                          isRound: true),
                      onPressed: () {
                        state.panelController.isPanelOpen
                            ? state.panelController.close()
                            : state.panelController.open();
                      }),
                  onLongPress: () {
                    BuJuanUtil.showToast('msg');
                  },
                ),
                elevation: 0.0,
                title: _navBar(state, dispatch),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.search,
                    ),
                    onPressed: () {
                      Navigator.of(viewService.context)
                          .pushNamed('search', arguments: null);
                    },
                  )
                ],
              ),
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return state.pages[index];
                  },
                  itemCount: state.pages.length,
                  controller: state.pageController,
                  onPageChanged: (index) {
                    dispatch(EntranceActionCreator.onPageChange(index));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: Screens.setHeight(56)),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        if (state.panelController.isPanelOpen) {
          state.panelController.close();
        } else {
          AndroidBackTop.backDeskTop(); //设置为返回不退出app
        }
        return false;
      });
}

///body
Widget _body(EntranceState state, dispatch, ViewService viewService) {
  return SlidingUpPanel(
    color: Colors.transparent,
    controller: state.panelController,
    minHeight: Screens.setHeight(56),
    maxHeight: MediaQuery.of(viewService.context).size.height,
    boxShadow: null,
    panel: _leftChild(state, dispatch, viewService),
    collapsed: PlayBarPage().buildPage(null),
    body: Column(
      children: <Widget>[
        AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            child: IconButton(
                padding: EdgeInsets.all(0),
                icon: ImageHelper.getImage(
                    SpUtil.getString('head',
                        defValue:
                            'https: //ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3974834430,2578081919&fm=26&gp=0.jpg'),
                    height: 30,
                    isRound: true),
                onPressed: () {
                  state.panelController.isPanelOpen
                      ? state.panelController.close()
                      : state.panelController.open();
                }),
            onLongPress: () {
              BuJuanUtil.showToast('msg');
            },
          ),
          elevation: 0.0,
          title: _navBar(state, dispatch),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                IconData(0xe606, fontFamily: 'iconfont'),
              ),
              onPressed: () {
                Navigator.of(viewService.context)
                    .pushNamed('search', arguments: null);
              },
            )
          ],
        ),
        Expanded(
          child: PageView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return state.pages[index];
            },
            itemCount: state.pages.length,
            controller: state.pageController,
            onPageChanged: (index) {
              dispatch(EntranceActionCreator.onPageChange(index));
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: Screens.setHeight(56)),
        )
      ],
    ),
  );
}

///leftChild
Widget _leftChild(EntranceState state, dispatch, ViewService viewService) {
  return LeftPage(
      child: Column(
    children: <Widget>[
      Expanded(child: Container()),
      ListTile(
        title: Text('設置'),
        onTap: () async {
//          dispatch(EntranceActionCreator.openPage(OpenType.SETTING));
          await Navigator.of(viewService.context)
              .pushNamed('setting', arguments: null);
          state.panelController?.close(); //注意2
        },
      ),
      ListTile(
        title: Text('關於'),
        onTap: () {
          dispatch(EntranceActionCreator.openPage(OpenType.ABOUT));
        },
      ),
      ListTile(
        title: Text('捐贈'),
        onTap: () {
          dispatch(EntranceActionCreator.openPage(OpenType.DONATION));
        },
      ),
//      SwitchListTile(
//          title: Text('底部导航栏'),
//          value: state.navBarIsBottom,
//          onChanged: (value) {
//            dispatch(EntranceActionCreator.onNavBarSwitch());
//          }),
      SwitchListTile(
          title: Text('迷你导航栏'),
          value: state.miniNav,
          onChanged: (value) {
            dispatch(EntranceActionCreator.onMiniNavBarSwitch());
          }),
    ],
  ));
}

///导航栏
Widget _navBar(EntranceState state, dispatch) {
  return state.miniNav
      ? MinNiNavBar(
          items: [
              BottomMiniNavyBarItem(
                icon: Icon(
                  IconData(0xe67a, fontFamily: 'iconfont'),
                ),
                title: Text('Me'),
                activeColor: const Color.fromRGBO(213, 15, 37, 1),
              ),
              BottomMiniNavyBarItem(
                  icon: Icon(
                    IconData(0xe65d, fontFamily: 'iconfont'),
                  ),
                  title: Text('Find'),
                  activeColor: const Color.fromRGBO(238, 178, 17, 1)),
              BottomMiniNavyBarItem(
                icon: Icon(
                  Icons.whatshot,
                ),
                title: Text('Top'),
                activeColor: const Color.fromRGBO(0, 153, 37, 1),
              ),
//              BottomMiniNavyBarItem(
//                icon: Icon(Icons.music_video),
//                title: Text('Local'),
//                activeColor: const Color.fromRGBO(51, 105, 232, 1),
//              ),
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
                size: 22,
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
                  size: 22,
                ),
                title: Text(
                  'Find',
                  style: TextStyle(fontSize: 14),
                ),
                activeColor: const Color.fromRGBO(238, 178, 17, 1)),
            BottomNavyBarItem(
              icon: Icon(
                IconData(0xe67b, fontFamily: 'iconfont'),
                size: 22,
              ),
              title: Text(
                'Top',
                style: TextStyle(fontSize: 14),
              ),
              activeColor: const Color.fromRGBO(0, 153, 37, 1),
            ),
//            BottomNavyBarItem(
//              icon: Icon(Icons.photo_filter),
//              title: Text('Local'),
//              activeColor: const Color.fromRGBO(51, 105, 232, 1),
//            ),
          ],
          selectedIndex: state.selectIndex,
          onItemSelected: (index) {
            dispatch(EntranceActionCreator.onBottomBarTap(index));
          });
}
