import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/widget/back_widget.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(CloundPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: Widgets.blackWidget(null, Column(
      children: <Widget>[
        Expanded(
            child: state.isShowLoading
                ? LoadingPage()
                : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: 230.0,
                  flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                          '云盘数据'),
                      centerTitle: true,
                      collapseMode: CollapseMode.pin,
                      background: Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/top_imgae.png',
                              height: 230,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Constants.dark
                                    ? Colors.grey[850].withOpacity(.3)
                                    : Colors.white.withOpacity(.3)),
                          ),
                        ],
                      )),
                  floating: false,
                  pinned: true,
                  snap: false,
                  elevation: 0,
                ),
                SliverList(
                  delegate: new SliverChildBuilderDelegate(
                        (context, index) => _item(
                        state.list[index], dispatch, index, viewService),
                    childCount: state.list.length,
                  ),
                ),
              ],
            )),
        PlayBarPage().buildPage(null)
      ],
    )),
  );
}
Widget _item(SongBeanEntity track, Dispatch dispatch, index, viewService) {
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
              color: Colors.blue,
              fontSize: Screens.text14,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
            child: Text(
              track.name,
              style: TextStyle(fontSize: Screens.text14),
            ))
      ],
    ),
    subtitle: Text(track.singer, style: TextStyle(fontSize: Screens.text12)),
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
      dispatch(CloundPageActionCreator.onPlaySong(index));
    },
  );
}