import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:bujuan/widget/back_widget.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';
import 'package:flutterstarrysky/song_info.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SheetDetailsState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: BujuanAppBar.norAppBar(viewService.context,
        state.isShowLoading ? '' : state.playlist.name),
    body: Widgets.blackWidget(Constants.dark, state.isShowLoading
        ? LoadingPage()
        :Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _sheetTop(state, dispatch),
              ListView.builder(
                padding: EdgeInsets.only(bottom: Constants.bottomHeight),
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
        PlayBarPage().buildPage(null)
      ],
    )),
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

Widget _sheetItem(SongInfo track, Dispatch dispatch, index, viewService) {
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
          track.songName,
          style: TextStyle(fontSize: Screens.text14),
          maxLines: 1,
        ))
      ],
    ),
    subtitle: Text(
      track.artist,
      style: TextStyle(fontSize: Screens.text12),
      maxLines: 1,
    ),
    onTap: () {
      dispatch(SheetDetailsActionCreator.play(index));
    },
  );
}

Widget _currSong(SheetDetailsState state){
  return Offstage(
    offstage: FlutterStarrySky().getPlayListId()!='${state.playlist.id}',
//    child: Container(child: Text('当前播放：${state.currSong.songName}'),),
  );
}
