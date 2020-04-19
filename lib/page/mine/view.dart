import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/page/mine/action.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

import 'state.dart';

Widget buildView(MineState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: state.isLogin
        ? _loginView(state, dispatch, viewService)
        : _unLoginView(dispatch, viewService),
  );
}

//未登录的页面
Widget _unLoginView(dispatch, ViewService viewService) {
  var width = MediaQuery.of(viewService.context).size.width;
  return Center(
    child: Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        Container(
          width: width,
          child: Image.asset(
            'assets/images/logo.png',
            height: Screens.setHeight(60),
          ),
        ),
//        Container(
//          width: width,
//          child: Text(
//            '登录您的账号,体验更多功能',
//            textAlign: TextAlign.center,
//            style: TextStyle(fontSize: Screens.text14),
//          ),
//          padding: EdgeInsets.only(top: 20, bottom: 20),
//        ),
        InkWell(
          child: Container(
            width: width - 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              child: Text(
                '点我立即登录',
                textAlign: TextAlign.center,
              ),
              width: Screens.setWidth(120),
            ),
            padding: EdgeInsets.only(top: 10, bottom: 10),
          ),
          onTap: () {
            dispatch(MineActionCreator.onLogin());
          },
        ),
      ],
    ),
  );
}

//已登陆的界面
//Widget _loginView(MineState state, Dispatch dispatch, ViewService viewService) {
//  return !state.isShowLoad
//      ? Container(
//    padding: EdgeInsets.symmetric(horizontal: Screens.width5),
//    child: Column(
//      children: <Widget>[
//        Expanded(
//            child: EasyRefresh.custom(
//              header: TaurusHeader(),
//              slivers: <Widget>[
//                SliverToBoxAdapter(child: Wrap(
//                  children: <Widget>[
//                    Container(
//                      padding: EdgeInsets.only(
//                          top: 10.0, bottom: 10.0, left: 5),
//                      alignment: Alignment.topLeft,
//                      child: Row(
//                        children: <Widget>[
//                          ImageHelper.getImage(
//                              state.userProfileEntity.profile
//                                  .avatarUrl +
//                                  "?param=180y180",
//                              height: Screens.setHeight(60),
//                              isRound: true),
//                          Padding(
//                              padding: EdgeInsets.only(
//                                  right: Screens.setWidth(20))),
//                          Expanded(
//                              child: Wrap(
//                                direction: Axis.vertical,
//                                children: <Widget>[
//                                  Container(
//                                    height: Screens.height30,
//                                    child: Text(
//                                      state.userProfileEntity.profile
//                                          .nickname,
//                                      style: TextStyle(
//                                          fontSize: Screens.text16),
//                                    ),
//                                    alignment: Alignment.centerLeft,
//                                  ),
//                                  Container(
//                                    height: Screens.height30,
//                                    child: Text(
//                                      '暂无个性签名',
//                                      style: TextStyle(
//                                          fontSize: Screens.text12),
//                                    ),
//                                    alignment: Alignment.centerLeft,
//                                  ),
//                                ],
//                              )),
//                          IconButton(
//                              icon: Icon(
//                                Icons.exit_to_app,
//                                size: Screens.text22,
//                              ),
//                              onPressed: () {
//                                showDialog(
//                                  context: viewService.context,
//                                  builder: (context) =>
//                                      AlertDialog(
//                                          shape: RoundedRectangleBorder(
//                                              borderRadius:
//                                              BorderRadius.circular(
//                                                  5)),
//                                          title: Text("退出登录"),
//                                          content: Text("确定要退出登录吗？"),
//                                          actions: <Widget>[
//                                            InkWell(
//                                              child: Container(
//                                                padding:
//                                                EdgeInsets.symmetric(
//                                                    horizontal: 10,
//                                                    vertical: 5),
//                                                child: Text('确认'),
//                                              ),
//                                              onTap: () {
//                                                dispatch(MineActionCreator
//                                                    .exit());
//                                              },
//                                            )
//                                          ]),
//                                );
//                              })
//                        ],
//                      ),
//                    ),
//                    Row(
//                      mainAxisAlignment:
//                      MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        IconButton(
//                            icon: Icon(
//                              Icons.history,
//                              size: Screens.text22,
//                            ),
//                            onPressed: () {
//                              Navigator.of(viewService.context)
//                                  .pushNamed('history',
//                                  arguments: null);
//                            }),
//                        IconButton(
//                            icon: Icon(
//                              Icons.cloud,
//                              size: Screens.text22,
//                            ),
//                            onPressed: () {}),
//                        IconButton(
//                            icon: Icon(
//                              Icons.people,
//                              size: Screens.text22,
//                            ),
//                            onPressed: () {}),
//                        IconButton(
//                            icon: Icon(
//                              Icons.store_mall_directory,
//                              size: Screens.text22,
//                            ),
//                            onPressed: () {}),
//                      ],
//                    )
//                  ],
//                )),
//                SliverToBoxAdapter(
//                  child: Container(
//                      child: Text(
//                        '我创建的歌单 (${state.createOrderList.length})',
//                        style: TextStyle(
//                            fontSize: Screens.text14,
//                            fontWeight: FontWeight.bold),
//                      ),
//                      alignment: Alignment.centerLeft,
//                      padding: EdgeInsets.only(
//                          left: Screens.width5,
//                          top: Screens.setHeight(20),
//                          bottom: Screens.setHeight(10))),
//                ),
//                SliverToBoxAdapter(
//                  child: Container(
//                    height: Screens.setHeight(150),
//                    padding: EdgeInsets.only(top: 5, left: 5, right: 5),
//                    child: ListView.builder(
//                      scrollDirection: Axis.horizontal,
//                      itemBuilder: (context, index) {
//                        return InkWell(
//                          child: Wrap(
//                            direction: Axis.vertical,
//                            children: <Widget>[
//                              Container(
//                                padding:
//                                EdgeInsets.only(right: Screens.width15),
//                                child: ImageHelper.getImage(
//                                    state.createOrderList[index].coverImgUrl +
//                                        "?param=280y280",
//                                    height: Screens.setHeight(100)),
//                              ),
//                              Container(
//                                height: Screens.setHeight(40),
//                                constraints: BoxConstraints(
//                                    maxWidth: Screens.setHeight(95)),
//                                alignment: Alignment.centerLeft,
//                                child: Text(
//                                  state.createOrderList[index].name,
//                                  style: TextStyle(fontSize: Screens.text12),
//                                  textAlign: TextAlign.center,
//                                  maxLines: 2,
//                                  overflow: TextOverflow.ellipsis,
//                                ),
//                              )
//                            ],
//                          ),
//                          onTap: () {
//                            Navigator.of(viewService.context)
//                                .pushNamed('sheet_details', arguments: {
//                              'sheetId': state.createOrderList[index].id
//                            }); //注意
//                          },
//                        );
//                      },
//                      itemCount: state.createOrderList.length,
//                    ),
//                  ),
//                ),
//                SliverToBoxAdapter(
//                  child: InkWell(
//                    child: Container(
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Text(
//                              '我收藏的歌单 (${state.orderList.length})',
//                              style: TextStyle(
//                                  fontSize: Screens.text14,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                            Icon(state.isOpen
//                                ? Icons.keyboard_arrow_down
//                                : Icons.keyboard_arrow_right)
//                          ],
//                        ),
//                        alignment: Alignment.centerLeft,
//                        padding: EdgeInsets.only(
//                            left: Screens.width5,
//                            top: Screens.setHeight(10),
//                            bottom: Screens.setHeight(10))),
//                    onTap: () {
//                      dispatch(MineActionCreator.setOPen());
//                    },
//                  ),
//                ),
//                state.isOpen
//                    ? SliverList(
//                  delegate: SliverChildBuilderDelegate(
//                        (BuildContext context, int index) {
//                      return _orderItem(
//                          state.orderList[index], viewService);
//                    },
//                    childCount: state.orderList.length,
//                  ),
//                )
//                    : SliverToBoxAdapter(),
//              ],
//              onRefresh: () => dispatch(MineActionCreator.getRefresh()),
//            ))
//      ],
//    ),
//  )
//      : LoadingPage();
//}

//已登陆的界面
Widget _loginView(MineState state, Dispatch dispatch, ViewService viewService) {
  return !state.isShowLoad
      ? Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: Screens.width5),
          child: EasyRefresh(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
//                      Container(
//                        padding:
//                            EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5),
//                        alignment: Alignment.topLeft,
//                        child: Row(
//                          children: <Widget>[
//                            ImageHelper.getImage(
//                                state.userProfileEntity.profile.avatarUrl +
//                                    "?param=180y180",
//                                height: Screens.setHeight(60),
//                                isRound: true),
//                            Padding(
//                                padding: EdgeInsets.only(
//                                    right: Screens.setWidth(20))),
//                            Expanded(
//                                child: Wrap(
//                              direction: Axis.vertical,
//                              children: <Widget>[
//                                Container(
//                                  height: Screens.height30,
//                                  child: Text(
//                                    state.userProfileEntity.profile.nickname,
//                                    style: TextStyle(fontSize: Screens.text16),
//                                  ),
//                                  alignment: Alignment.centerLeft,
//                                ),
//                                Container(
//                                  height: Screens.height30,
//                                  child: Text(
//                                    '暂无个性签名',
//                                    style: TextStyle(fontSize: Screens.text12),
//                                  ),
//                                  alignment: Alignment.centerLeft,
//                                ),
//                              ],
//                            )),
//                            IconButton(
//                                icon: Icon(
//                                  Icons.exit_to_app,
//                                  size: Screens.text22,
//                                ),
//                                onPressed: () {
//                                  showDialog(
//                                    context: viewService.context,
//                                    builder: (context) => AlertDialog(
//                                        shape: RoundedRectangleBorder(
//                                            borderRadius:
//                                                BorderRadius.circular(5)),
//                                        title: Text("退出登录"),
//                                        content: Text("确定要退出登录吗？"),
//                                        actions: <Widget>[
//                                          InkWell(
//                                            child: Container(
//                                              padding: EdgeInsets.symmetric(
//                                                  horizontal: 10, vertical: 5),
//                                              child: Text('确认'),
//                                            ),
//                                            onTap: () {
//                                              dispatch(
//                                                  MineActionCreator.exit());
//                                            },
//                                          )
//                                        ]),
//                                  );
//                                })
//                          ],
//                        ),
//                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.history,
                              ),
                              onPressed: () {
                                Navigator.of(viewService.context)
                                    .pushNamed('history', arguments: null);
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.cloud,
                              ),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(
                                Icons.people,
                              ),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(
                                Icons.store_mall_directory,
                              ),
                              onPressed: () {}),
                        ],
                      )
                    ],
                  ),
                  Container(
                      child: Text(
                        '我创建的歌单 (${state.createOrderList.length})',
                        style: TextStyle(
                            fontSize: Screens.text14,
                            fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: Screens.width5,
                          top: Screens.setHeight(20),
                          bottom: Screens.setHeight(10))),
                  ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        _orderItem(state.createOrderList[index], viewService),
                    itemCount: state.createOrderList.length,
                  ),
                  InkWell(
                    child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '我收藏的歌单 (${state.orderList.length})',
                              style: TextStyle(
                                  fontSize: Screens.text14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(state.isOpen
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_right)
                          ],
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            left: Screens.width5,
                            top: Screens.setHeight(10),
                            bottom: Screens.setHeight(10))),
                    onTap: () {
                      dispatch(MineActionCreator.setOPen());
                    },
                  ),
                  state.isOpen
                      ? ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              _orderItem(state.orderList[index], viewService),
                          itemCount: state.orderList.length,
                        )
                      : Container()
                ],
              ),
            ),
            onRefresh: () => dispatch(MineActionCreator.getRefresh()),
            header: MaterialHeader(valueColor: AlwaysStoppedAnimation(Color.fromRGBO(213, 15, 37, .6))),
          ))
      : LoadingPage();
}

Widget _orderItem(UserOrderPlaylist orderPlaylist, viewService) {
//  return InkWell(
//    child: Container(
//      padding: EdgeInsets.symmetric(
//          vertical: Screens.height10, horizontal: Screens.width5),
//      child: Row(
//        children: <Widget>[
//          ImageHelper.getImage(orderPlaylist.coverImgUrl + "?param=100y100",
//              height: Screens.setHeight(42), isRound: true),
//          Padding(padding: EdgeInsets.only(right: Screens.width10)),
//          Expanded(
//              child: Column(
//            children: <Widget>[
//              Container(
//                  alignment: Alignment.centerLeft,
//                  height: Screens.setHeight(20),
//                  child: Text(orderPlaylist.name,
//                      style: TextStyle(fontSize: Screens.text12))),
//              Container(
//                  alignment: Alignment.centerLeft,
//                  height: Screens.setHeight(20),
//                  child: Text('${orderPlaylist.trackCount} 首单曲',
//                      style: TextStyle(
//                          fontSize: Screens.text10, color: Colors.grey)))
//            ],
//          ))
//        ],
//      ),
//    ),
//    onTap: () => Navigator.of(viewService.context)
//        .pushNamed('sheet_details', arguments: {'sheetId': orderPlaylist.id}),
//  );
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 2),
    leading: ImageHelper.getImage(orderPlaylist.coverImgUrl + "?param=150y150",
        height: Screens.setHeight(42), isRound: true),
    title: Text(
      orderPlaylist.name,
      style: TextStyle(fontSize: Screens.text14),
    ),
    subtitle: Text('${orderPlaylist.trackCount} 首单曲',
        style: TextStyle(fontSize: Screens.text12)),
    onTap: () {
      Navigator.of(viewService.context).pushNamed('sheet_details',
          arguments: {'sheetId': orderPlaylist.id}); //注意
    },
  );
}
