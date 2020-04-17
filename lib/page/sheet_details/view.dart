import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:bujuan/widget/bujuan_background.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SheetDetailsState state, Dispatch dispatch, ViewService viewService) {
  return BujuanBack.back(
      Scaffold(
        appBar: BujuanAppBar.norAppBar(viewService.context,
            state.isShowLoading ? '' : state.playlist.name),
        body: state.isShowLoading
            ? LoadingPage()
            : Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          _sheetTop(state, dispatch),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => _sheetItem(
                                state.list[index],
                                dispatch,
                                index,
                                viewService),
                            itemCount: state.list.length,
                          )
                        ],
                      ),
                    ),
                  ),
                  PlayBarPage().buildPage(null)
                ],
              ),
      ),
      viewService.context);
}

Widget _sheetTop(SheetDetailsState state, dispatch) {
  var subscribedCount2 = state.playlist.subscribedCount;
  String scount = subscribedCount2 / 10000 > 1
      ? '${subscribedCount2 ~/ 10000}w'
      : '$subscribedCount2';
  return InkWell(
    child: Container(
//          margin: EdgeInsets.only(top: 5),
      height: Screens.setHeight(120),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: Screens.setHeight(120),
                  padding: EdgeInsets.all(3),
                  child: ImageHelper.getImage(
                      state.playlist.coverImgUrl + "?param=250y250",
                      height: Screens.setHeight(120)),
                ),
                Expanded(
                    child: Column(
                  children: <Widget>[
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 0, bottom: 0, top: 5),
                      leading: ImageHelper.getImage(
                          state.playlist.creator.avatarUrl + "?param=100y100",
                          height: Screens.setHeight(35),
                          isRound: true),
                      title: Text(state.playlist.creator.nickname),
                      onTap: () {},
                    ),
                    Expanded(
                        child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: state.playlist.subscribed
                              ? Icon(
                                  Icons.favorite,
                                  size: Screens.text18,
                                  color: Colors.red,
                                )
                              : Icon(Icons.favorite_border,
                                  size: Screens.text18),
                          onPressed: () {
                            dispatch(SheetDetailsActionCreator.like());
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.message,
                            size: Screens.text18,
                          ),
                          onPressed: () {},
                        ),
                        Container(
                          child: Text(
                            '$scount 收藏',
                            style: TextStyle(fontSize: Screens.text12),
                          ),
                          padding: EdgeInsets.only(left: 5, right: 5),
                        ),
                      ],
                    ))
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      dispatch(SheetDetailsActionCreator.infoPage());
    },
  );
}

Widget _sheetItem(SongBeanEntity track, Dispatch dispatch, index, viewService) {
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
//    leading: ImageHelper.getImage('${track.picUrl ?? ''}?param=100y100',
//        height: Screens.setHeight(45), isRound: true),
    title: Row(
      children: <Widget>[
        Text(
          '${index + 1}. ',
          style: TextStyle(
              color: Colors.blue,
              fontSize: Screens.text14,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
            child: Text(
          track.name,
          style: TextStyle(fontSize: Screens.text12),
          maxLines: 1,
        ))
      ],
    ),
    subtitle: Text(
      track.singer,
      style: TextStyle(fontSize: Screens.text12),
      maxLines: 1,
    ),
    trailing: track.mv == 0
        ? Container(
            width: 0,
          )
        : IconButton(
            icon: Icon(
              Icons.videocam,
              size: Screens.text18,
            ),
            onPressed: () {
              Navigator.of(viewService.context)
                  .pushNamed('mv_play', arguments: {'mvId': track.mv}); //注意2
            }),
    onTap: () {
      dispatch(SheetDetailsActionCreator.play(index));
    },
  );
}
