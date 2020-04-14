import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/page/bujuan_find/page.dart';
import 'package:bujuan/page/local_music/page.dart';
import 'package:bujuan/page/mine/page.dart';
import 'package:bujuan/page/play/page.dart';
import 'package:bujuan/page/top/page.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/bottom_drag_widget.dart';
import 'package:bujuan/widget/bujuan_background.dart';
import 'package:bujuan/widget/bujuan_bottom_sheet.dart';
import 'package:bujuan/widget/left_page.dart';
import 'package:bujuan/widget/mini_nav_bar.dart';
import 'package:bujuan/widget/nav_bar.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    EntranceState state, Dispatch dispatch, ViewService viewService) {
  ScreenUtil.init(viewService.context,
      width: 375, height: 812, allowFontScaling: false);
  return _body(state, dispatch, viewService);
}

///body
Widget _body(EntranceState state, dispatch, ViewService viewService) {
  return BujuanBack.back(
      Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SlidingUpPanel(
          controller: state.panelController,
          minHeight: Screens.setHeight(60),
          maxHeight: MediaQuery.of(viewService.context).size.height,
          panel: Container(
            child: PlayViewPage().buildPage(null),
          ),
          collapsed: InkWell(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Screens.width5),
              child: PlayBarPage().buildPage(null),
            ),
            onTap: () {
              state.panelController.open();
            },
          ),
          body: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.sort, size: Screens.text22),
                    onPressed: () {
                      showBujuanBottomSheet(
                          context: viewService.context,
                          builder: (context) {
                            return Container(
                              height: MediaQuery.of(viewService.context)
                                      .size
                                      .height *
                                  0.8,
                              child: BujuanBack.back(
                                  ListView(
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('設置'),
                                        onTap: () {
                                          dispatch(
                                              EntranceActionCreator.openPage(
                                                  OpenType.SETTING));
                                        },
                                      ),
                                      ListTile(
                                        title: Text('關於'),
                                        onTap: () {
                                          dispatch(
                                              EntranceActionCreator.openPage(
                                                  OpenType.ABOUT));
                                        },
                                      ),
                                      ListTile(
                                        title: Text('捐贈'),
                                        onTap: () {
                                          dispatch(
                                              EntranceActionCreator.openPage(
                                                  OpenType.DONATION));
                                        },
                                      ),
                                      SwitchListTile(
                                          title: Text('底部导航栏'),
                                          value: state.navBarIsBottom,
                                          onChanged: (value) {
                                            dispatch(EntranceActionCreator
                                                .onNavBarSwitch());
                                          }),
                                      SwitchListTile(
                                          title: Text('迷你导航栏'),
                                          value: state.miniNav,
                                          onChanged: (value) {
                                            dispatch(EntranceActionCreator
                                                .onMiniNavBarSwitch());
                                          }),
                                    ],
                                  ),
                                  viewService.context),
                            );
                          });
                    }),
                elevation: 0.0,
                title: Text(
                  '归山深浅去，须尽丘壑美。',
                  style: TextStyle(
                      fontSize: Screens.text18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.search, size: Screens.text22),
                    onPressed: () {
                      Navigator.of(viewService.context)
                          .pushNamed('search', arguments: null);
                    },
                  )
                ],
              ),
              !state.navBarIsBottom ? _navBar(state, dispatch) : Container(),
              Expanded(
                  child: PageView(
                      controller: state.pageController,
                      onPageChanged: (index) {
                        dispatch(EntranceActionCreator.onPageChange(index));
                      },
                      children: <Widget>[
                    MinePage().buildPage(null),
                    NewFindPage().buildPage(null),
                    TopPagePage().buildPage(null),
                    LocalMusicPage().buildPage(null),
                  ])),
              Padding(padding: EdgeInsets.only(bottom: Screens.setHeight(75)),)
            ],
          ),
        ),
      ),
      viewService.context,
      isDark: state.appTheme.dark);
}

///leftChild
Widget _leftChild(EntranceState state, dispatch, ViewService viewService) {
  var string = SpUtil.getString(Constants.USER_BACKGROUND, defValue: '');
  var width = MediaQuery.of(viewService.context).size.width;
  return LeftPage(
      child: Column(
    children: <Widget>[
      ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            title: Text('設置'),
            onTap: () {
              dispatch(EntranceActionCreator.openPage(OpenType.SETTING));
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
          SwitchListTile(
              title: Text('底部导航栏'),
              value: state.navBarIsBottom,
              onChanged: (value) {
                dispatch(EntranceActionCreator.onNavBarSwitch());
              }),
          SwitchListTile(
              title: Text('迷你导航栏'),
              value: state.miniNav,
              onChanged: (value) {
                dispatch(EntranceActionCreator.onMiniNavBarSwitch());
              }),
        ],
      )
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
              BottomMiniNavyBarItem(
                icon: Icon(Icons.music_video),
                title: Text('Local'),
                activeColor: const Color.fromRGBO(51, 105, 232, 1),
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
                IconData(0xe67a, fontFamily: 'iconfont'),
              ),
              title: Text('Me'),
              activeColor: const Color.fromRGBO(213, 15, 37, 1),
            ),
            BottomNavyBarItem(
                icon: Icon(
                  IconData(0xe65d, fontFamily: 'iconfont'),
                ),
                title: Text('Find'),
                activeColor: const Color.fromRGBO(238, 178, 17, 1)),
            BottomNavyBarItem(
              icon: Icon(
                Icons.multiline_chart,
              ),
              title: Text('Top'),
              activeColor: const Color.fromRGBO(0, 153, 37, 1),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.photo_filter),
              title: Text('Local'),
              activeColor: const Color.fromRGBO(51, 105, 232, 1),
            ),
          ],
          selectedIndex: state.selectIndex,
          onItemSelected: (index) {
            dispatch(EntranceActionCreator.onBottomBarTap(index));
          });
}
