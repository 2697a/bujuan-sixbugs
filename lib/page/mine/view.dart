import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/page/mine/action.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:bujuan/widget/slide_item.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

import 'state.dart';

Widget buildView(MineState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5.0),
    child: state.isLogin ? _loginView(state, dispatch, viewService) : _unLoginView(dispatch, viewService),
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
      ? EasyRefresh(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Row(
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
                            state.userProfileEntity != null ? '${state.userProfileEntity.profile.signature}' : '暂无个性签名',
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
                            builder: (context) => AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), title: Text("退出登录"), content: Text("确定要退出登录吗？"), actions: <Widget>[
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.history,
                        ),
                        onPressed: () {
                          Navigator.of(viewService.context).pushNamed('history', arguments: null);
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.cloud,
                        ),
                        onPressed: () {
                          Navigator.of(viewService.context).pushNamed('user_clound', arguments: null);
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
                          Navigator.of(viewService.context).pushNamed('local_music', arguments: null);
                        }),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                  child: InkWell(
                child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Icon(state.isCreateOpen ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right),
                            Padding(padding: EdgeInsets.only(right: 5)),
                            Text(
                              '创建的歌单 (${state.createOrderList.length})',
                              style: TextStyle(fontSize: Screens.text14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Wrap(
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.add), onPressed: () => dispatch(MineActionCreator.onCreatePlaylist())),
                            IconButton(
                                icon: Icon(Icons.more_vert),
                                onPressed: () => Navigator.of(viewService.context).pushNamed('sheet_manager', arguments: {'create_list': state.createOrderList, 'list': state.orderList}).then((value) async {
                                      await dispatch(MineActionCreator.getRefresh());
                                    })),
                          ],
                        )
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                      left: Screens.width5,
                    )),
                onTap: () {
                  dispatch(MineActionCreator.setCreateOpen());
                },
              )),
              state.isCreateOpen
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, int index) {
                          return _orderItem(state.createOrderList[index], viewService);
                        },
                        childCount: state.createOrderList.length,
                      ),
                    )
                  : SliverToBoxAdapter(),
              SliverToBoxAdapter(
                  child: InkWell(
                child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(state.isOpen ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right),
                        Padding(padding: EdgeInsets.only(right: 5)),
                        Text(
                          '收藏的歌单 (${state.orderList.length})',
                          style: TextStyle(fontSize: Screens.text14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: Screens.width5, top: Screens.setHeight(10), bottom: Screens.setHeight(10))),
                onTap: () {
                  dispatch(MineActionCreator.setOPen());
                },
              )),
              state.isOpen
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, int index) {
                          return _orderItem(state.orderList[index], viewService);
                        },
                        childCount: state.orderList.length,
                      ),
                    )
                  : SliverToBoxAdapter(),
            ],
          ),
          onRefresh: () => dispatch(MineActionCreator.getRefresh()),
          header: MaterialHeader(valueColor: AlwaysStoppedAnimation(Color.fromRGBO(213, 15, 37, .6))),
        )
      : LoadingPage();
}

Widget _orderItem(UserOrderPlaylist orderPlaylist, viewService) {
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 2),
    leading: ImageHelper.getImage(orderPlaylist.coverImgUrl + "?param=150y150", height: Screens.setHeight(42), isRound: true),
    title: Text(
      orderPlaylist.name,
      style: TextStyle(fontSize: Screens.text14),
    ),
    subtitle: Text('${orderPlaylist.trackCount} 首单曲', style: TextStyle(fontSize: Screens.text12)),
    onTap: () {
      Navigator.of(viewService.context).pushNamed('sheet_details', arguments: {'sheetId': orderPlaylist.id}); //注意
    },
  );
}
