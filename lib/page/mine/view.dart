import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/page/mine/action.dart';
import 'package:bujuan/utils/bujuan_util.dart';
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
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        child: Image.asset(
          'assets/images/local.jpg',
          height: Screens.setHeight(160),
        ),
      ),
      Container(
        width: MediaQuery.of(viewService.context).size.width * 0.6,
        child: MaterialButton(
          onPressed: () {
            dispatch(MineActionCreator.onLogin());
          },
          child: Text('点我去登录'),
        ),
      ),
    ],
  );
}

Widget _loginView(MineState state, Dispatch dispatch, ViewService viewService) {
  return !state.isShowLoad
      ? Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: Screens.width5),
          child: EasyRefresh(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(0),
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                      Expanded(
                          child: Wrap(
                        direction: Axis.vertical,
                        children: <Widget>[
                          Container(
                            height: Screens.height30,
                            child: Text(
                              state.userProfileEntity.profile.nickname,
                              style: TextStyle(fontSize: Screens.text18),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Container(
                            height: Screens.height30,
                            child: Text(
                              state.userProfileEntity != null
                                  ? '${state.userProfileEntity.profile.signature}'
                                  : '暂无个性签名',
                              style: TextStyle(fontSize: Screens.text14),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      )),
                      IconButton(
                          icon: Icon(
                            Icons.exit_to_app,
                            size: Screens.text22,
                          ),
                          onPressed: () {
                            showDialog(
                              context: viewService.context,
                              builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  title: Text("退出登录"),
                                  content: Text("确定要退出登录吗？"),
                                  actions: <Widget>[
                                    InkWell(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Text('确认'),
                                      ),
                                      onTap: () {
                                        dispatch(MineActionCreator.exit());
                                      },
                                    )
                                  ]),
                            );
                          }),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 4))
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8)),
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
                          onPressed: () {
                            Navigator.of(viewService.context)
                                .pushNamed('user_clound', arguments: null);
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.people,
                          ),
                          onPressed: () {
                            BuJuanUtil.showToast('暂不可用');
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.queue_music,
                          ),
                          onPressed: () {
                            Navigator.of(viewService.context)
                                .pushNamed('local_music', arguments: null);
                          }),
                    ],
                  ),
                  InkWell(
                    child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(state.isCreateOpen
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_right),
                                Padding(padding: EdgeInsets.only(right: 5)),
                                Text(
                                  '我创建的歌单 (${state.createOrderList.length})',
                                  style: TextStyle(
                                      fontSize: Screens.text14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            IconButton(icon: Icon(Icons.add), onPressed: () {}),
                          ],
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: Screens.width5,
                        )),
                    onTap: () {
                      dispatch(MineActionCreator.setCreateOpen());
                    },
                  ),
                  state.isCreateOpen
                      ? ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => _orderItem(
                              state.createOrderList[index], viewService),
                          itemCount: state.createOrderList.length,
                        )
                      : Container(),
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
            header: MaterialHeader(
                valueColor:
                    AlwaysStoppedAnimation(Color.fromRGBO(213, 15, 37, .6))),
          ))
      : LoadingPage();
}

Widget _orderItem(UserOrderPlaylist orderPlaylist, viewService) {
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
