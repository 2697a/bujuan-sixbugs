import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/page/bujuan_find/page.dart';
import 'package:bujuan/page/local_music/page.dart';
import 'package:bujuan/page/mine/page.dart';
import 'package:bujuan/page/top/page.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/left_page.dart';
import 'package:bujuan/widget/mini_nav_bar.dart';
import 'package:bujuan/widget/nav_bar.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(EntranceState state, Dispatch dispatch, ViewService viewService) {
  ScreenUtil.init(viewService.context, width: 375, height: 812, allowFontScaling: false);
  return InnerDrawer(key: state.innerDrawerKey, swipe: true, onTapClose: true, leftOffset: 0.5, leftScale: 0.95, borderRadius: 20, proportionalChildArea: false, backgroundColor: Theme.of(viewService.context).primaryColor, leftChild: _leftChild(state, dispatch, viewService), scaffold: _body(state, dispatch, viewService));
}

///body
Widget _body(EntranceState state, dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomPadding: false,
    appBar:PreferredSize(child:  AppBar(
      leading: IconButton(
          padding: EdgeInsets.all(0),
          icon: Icon(Icons.sort,size: Screens.text22),
          onPressed: () {
            state.innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
          }),
      elevation: 0.0,
      title: Text(
        '归山深浅去，须尽丘壑美。',
        style: TextStyle(fontSize: Screens.text18,fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.all(0),
          icon: Icon(Icons.search,size: Screens.text22),
          onPressed: () {
            Navigator.of(viewService.context).pushNamed('search', arguments: null);
          },
        )
      ],
    ), preferredSize: Size.fromHeight(ScreenUtil().setHeight(56))),
    body: Column(
      children: <Widget>[
        !state.navBarIsBottom ? _navBar(state, dispatch) : Container(),
        Expanded(
            child: PageView(
          children: <Widget>[
            MinePage().buildPage(null),
            NewFindPage().buildPage(null),
            TopPagePage().buildPage(null),
            LocalMusicPage().buildPage(null),
          ],
          onPageChanged: (index) {
            dispatch(EntranceActionCreator.onPageChange(index));
          },
          physics: ScrollPhysics(),
          controller: state.pageController,
        )),
        PlayBarPage().buildPage(null)
      ],
    ),
    bottomNavigationBar: state.navBarIsBottom ? _navBar(state, dispatch) : null,
  );
}

///leftChild
Widget _leftChild(EntranceState state, dispatch, ViewService viewService) {
  var string = SpUtil.getString(Constants.USER_BACKGROUND, defValue: '');
  var width = MediaQuery.of(viewService.context).size.width;
  return LeftPage(
      child: Column(
    children: <Widget>[
      Container(
        height: 210,
        width: width,
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo.png',
          height: 60,
          width: 60,
        ),
      ),
      Expanded(child: Container()),
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
