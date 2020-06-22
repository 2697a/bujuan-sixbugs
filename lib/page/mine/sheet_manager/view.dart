import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/page/mine/sheet_manager/action.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/slide_item.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(SheetManagerState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(title: Text('歌单管理')),
    body: Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                title: Text(
                  '创建的歌单',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Checkbox(value: false, onChanged: (value) {}),
              ),
            ),
          ),
          _list(state.createOrderList, state, viewService, true, dispatch),
          SliverToBoxAdapter(
            child: Container(
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                title: Text(
                  '收藏的歌单',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Checkbox(value: false, onChanged: (value) {}),
              ),
            ),
          ),
          _list(state.orderList, state, viewService, false, dispatch)
        ],
      ),
    ),
  );
}

Widget _list(List<UserOrderPlaylist> list, SheetManagerState state, ViewService viewService, bool isCreate, Dispatch dispatch) {
  return SlideConfiguration(
    config: state.slideConfig,
    child: SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, int index) {
          return SlideItem(
            slidable: true,
            indexInList: index + 1,
            leftActions: isCreate
                ? [
                    SlideAction(
                      actionWidget: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '编辑歌单',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                      tapCallback: (_) async {
                        _.close();
                      },
                    ),
                  ]
                : [],
            actions: [
              SlideAction(
                isDeleteButton: true,
                actionWidget: Container(
                  alignment: Alignment.center,
                  child: Text(
                    isCreate ? '删除歌单' : '取消收藏',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                ),
                tapCallback: (_) async {
                  await dispatch(SheetManagerActionCreator.onSub(index));
                  _.close();
                },
              )
            ],
            child: _orderItem(list[index], viewService, state, dispatch),
          );
        },
        childCount: list.length,
      ),
    ),
  );
}

Widget _orderItem(UserOrderPlaylist orderPlaylist, viewService, SheetManagerState state, Dispatch dispatch) {
  return Container(
    color: Constants.dark ? Colors.grey[850] : Colors.white,
    child: ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      leading: ImageHelper.getImage(orderPlaylist.coverImgUrl + "?param=150y150", height: Screens.setHeight(32), isRound: true),
      title: Text(
        orderPlaylist.name,
        style: TextStyle(
          fontSize: Screens.text14,
          decoration: state.ids.length > 0 && state.ids.contains('${orderPlaylist.id}') ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
//      subtitle: Text('${state.ids.length} 首单曲', style: TextStyle(fontSize: Screens.text12)),
//    trailing: state.ids.length>0&&state.ids.contains('${orderPlaylist.id}')?Icon(Icons.select_all):Container(),
      onTap: () {
        dispatch(SheetManagerActionCreator.onSelect('${orderPlaylist.id.toString()}'));
      },
    ),
  );
}
