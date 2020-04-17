import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/page/today/action.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:bujuan/widget/bujuan_background.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(TodayState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar:BujuanAppBar.norAppBar(viewService.context, '每日推荐'),
    body: state.isShowLoading
        ? LoadingPage()
        : Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _sheetItem(state.list[index], dispatch,index,viewService);
              },
              itemCount: state.list.length,
            )),
        PlayBarPage().buildPage(null)
      ],
    ),
  );
}

Widget _sheetItem(SongBeanEntity track, Dispatch dispatch,index,viewService) {
//  return InkWell(
//    child: Container(
//      padding: EdgeInsets.symmetric(vertical: Screens.height10, horizontal: Screens.width10),
//      child: Row(
//        children: <Widget>[
//          Expanded(
//              child: Column(
//                children: <Widget>[
//                  Container(
//                      alignment: Alignment.centerLeft,
//                      height: Screens.setHeight(20),
//                      child: Row(
//                        children: <Widget>[
//                          Text(
//                            '${index + 1}. ',
//                            style: TextStyle(
//                                color: Colors.blue,
//                                fontSize: Screens.text14,
//                                fontWeight: FontWeight.bold),
//                          ),
//                          Expanded(
//                              child: Text(
//                                track.name,
//                                style: TextStyle(fontSize: Screens.text12),
//                              ))
//                        ],
//                      )),
//                  Container(
//                      alignment: Alignment.centerLeft,
//                      height: Screens.setHeight(20),
//                      child: Text('${track.singer}',
//                          maxLines: 1,
//                          overflow: TextOverflow.ellipsis,
//                          style: TextStyle(fontSize: Screens.text10, color: Colors.grey)))
//                ],
//              ))
//        ],
//      ),
//    ),
//    onTap: () =>  dispatch(TodayActionCreator.play(index))
//  );
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
//    leading: ImageHelper.getImage('${track.picUrl??''}?param=100y100',
//        height: 35, isRound: true),
    title: Row(
      children: <Widget>[
        Text(
          '${index + 1}. ',
          style: TextStyle(
              color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Expanded(child: Text(track.name))
      ],
    ),
    subtitle: Text(track.singer),
    trailing: track.mv == 0
        ? Container(
      width: 0,
    )
        : IconButton(
        icon: Icon(
          Icons.videocam,
          size: 18,
        ),
        onPressed: () {
          Navigator.of(viewService.context)
              .pushNamed('mv_play', arguments: {'mvId': track.mv}); //注意2
        }),
    onTap: () {
      dispatch(TodayActionCreator.play(index));
    },
  );
}
