import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:bujuan/widget/back_widget.dart';
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
//  return Scaffold(
//    appBar: BujuanAppBar.norAppBar(viewService.context,
//        state.isShowLoading ? '' : state.playlist.name),
//    body: state.isShowLoading
//        ? LoadingPage()
//        : Column(
//      children: <Widget>[
//        Expanded(
//          child: SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                _sheetTop(state, dispatch),
//                ListView.builder(
//                  shrinkWrap: true,
//                  physics: NeverScrollableScrollPhysics(),
//                  itemBuilder: (context, index) => _sheetItem(
//                      state.list[index],
//                      dispatch,
//                      index,
//                      viewService),
//                  itemCount: state.list.length,
//                )
//              ],
//            ),
//          ),
//        ),
//        PlayBarPage().buildPage(null)
//      ],
//    ),
//  );
  var height = MediaQuery.of(viewService.context).size.height;
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
                  expandedHeight: 230,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: true,
                    title: Text(
                      state.playlist.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    background: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: ImageHelper.getImageNoRound(
                              state.playlist.coverImgUrl +
                                  "?param=500y500",
                              height: height * 0.35),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Constants.dark
                                  ? Colors.grey[850].withOpacity(.1)
                                  : Colors.white.withOpacity(.1)),
                          child: _sheetTop(state, dispatch),
                        ),
                      ],
                    ),
                  ),
                  floating: false,
                  pinned: false,
                  snap: false,
                ),
                SliverList(
                  delegate: new SliverChildBuilderDelegate(
                        (context, index) => _sheetItem(
                        state.list[index], dispatch, index, viewService),
                    childCount: state.list.length,
                  ),
                ),
              ],
            )),
        PlayBarPage().buildPage(null)
      ],
    )),
    floatingActionButton: Container(
      padding: EdgeInsets.only(bottom: 56),
      child: FloatingActionButton(onPressed: (){},child: Icon(Icons.search),),
    ),
  );
}

Widget _sheetTop(SheetDetailsState state, dispatch) {
  var subscribedCount2 = state.playlist.subscribedCount;
  String scount = subscribedCount2 / 10000 > 1
      ? '${subscribedCount2 ~/ 10000}w'
      : '$subscribedCount2';
  return InkWell(
    child: Container(
      height: Screens.setHeight(120),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
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
                      title: Text(state.playlist.creator.nickname,style: TextStyle(fontSize: 16),),
                      onTap: () {},
                    ),
                    Expanded(
                        child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: state.playlist.subscribed
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(Icons.favorite_border),
                          onPressed: () {
                            dispatch(SheetDetailsActionCreator.like());
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.message,
                          ),
                          onPressed: () {},
                        ),
                        Container(
                          child: Text(
                            '$scount 收藏',
                            style: TextStyle(fontSize: 14),
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
          style: TextStyle(fontSize: Screens.text14),
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
