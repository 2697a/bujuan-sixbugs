import 'dart:ui';

import 'package:bujuan/bujuan_music.dart';
import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/page/play/action.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/bujuan_background.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/color_loaed.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'state.dart';

Widget buildView(
    PlayViewState state, Dispatch dispatch, ViewService viewService) {
  return _body(state, viewService, dispatch);
}

Widget _body(PlayViewState state, viewService, dispatch) {
  var width2 = MediaQuery.of(viewService.context).size.width;
  var d = state.currSongPos / state.currSongAllPos * 100;
  return Scaffold(
    body: SlidingUpPanel(
      color: Constants.dark?Colors.grey[850]:Colors.white,
      minHeight: Screens.setHeight(130),
      maxHeight: MediaQuery.of(viewService.context).size.height*0.8,
      borderRadius: BorderRadius.circular(10),
//      border: Border.all(color: Colors.grey,width: 0.1),
      boxShadow: null,
      backdropOpacity: 0,
      panelBuilder: (ScrollController sc) => ListView.separated(
        controller: sc,
        itemCount: state.songList.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            dense: true,
            title: Text('${index+1}. ${state.songList[index].name} -- ${state.songList[index].singer}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: Screens.text12),),
          );
        },
        separatorBuilder: (BuildContext context, int index){
          return Divider();
        },
      ),
//      panel: Container(
//      ),
      collapsed: Container(
        color: Constants.dark?Colors.grey[850]:Colors.white,
        padding: EdgeInsets.symmetric(horizontal: Screens.width10),
        height: Screens.setHeight(130),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                state.currSong.name,
                style: TextStyle(
                    fontSize: Screens.text14, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              height: Screens.setHeight(42),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                state.currSong.singer,
                style: TextStyle(fontSize: Screens.text12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              height: Screens.setHeight(42),
            ),
            Container(
              height: Screens.setHeight(45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onPressed: () {
                        if (state.panelController != null)
                          state.panelController.close();
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.cloud_download,
                      ),
                      onPressed: () {
                        dispatch(PlayViewActionCreator.getUrl());
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.message,
                      ),
                      onPressed: () {
                        dispatch(PlayViewActionCreator.getSongTalk(
                            state.currSong.id.toString()));
                      })
                ],
              ),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
            left: Screens.setWidth(10),
            right: Screens.setWidth(10),
            bottom: Screens.setHeight(85),
            top: state.isMinni
                ? 0
                : MediaQueryData.fromWindow(window).padding.top +
                    Screens.setHeight(36)),
        child: Column(
          children: <Widget>[
            InkWell(
              child: ImageHelper.getImage(
                  state.currSong.picUrl + "?param=500y500",
                  height: width2 * 0.85,
                  isRound: true),
              onTap: () async =>
                  await BujuanMusic.lyric(Constants.dark ? '1' : '0'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Text(
                    '${BuJuanUtil.unix2Time(state.currSongPos)}',
                    style: TextStyle(fontSize: 12),
                  ),
                  Expanded(
                      child: Slider(
                          value: d >= 0 && d <= 100 ? d : 0,
                          max: 100,
                          min: 0,
                          onChangeEnd: (d) {},
                          onChanged: (value) {
                            dispatch(PlayViewActionCreator.seekTo(
                                (value * state.currSongAllPos ~/ 100)
                                    .toString()));
                          })),
                  Text(
                    '${BuJuanUtil.unix2Time(state.currSongAllPos)}',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: Screens.setHeight(15),
                  horizontal: Screens.setWidth(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  state.currSong.like != null
                      ? IconButton(
                          icon: state.currSong.like
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                ),
                          onPressed: () {
                            dispatch(PlayViewActionCreator.getLikeOrUnLike(
                                !state.currSong.like));
                          })
                      : IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.skip_previous),
                      onPressed: () {
                        dispatch(PlayViewActionCreator.skipPrevious());
                      }),
                  Container(
                    width: Screens.setWidth(50),
                    height: Screens.setWidth(50),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius:
                            BorderRadius.circular(Screens.setWidth(50))),
                    child: IconButton(
                        icon: state.playStateType == PlayStateType.Stop ||
                                state.playStateType == PlayStateType.Pause
                            ? Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.pause,
                                color: Colors.white,
                              ),
                        onPressed: () {
                          ///操作
                          dispatch(PlayViewActionCreator.playOrPause());
                        }),
                  ),
                  IconButton(
                      icon: Icon(Icons.skip_next),
                      onPressed: () {
                        dispatch(PlayViewActionCreator.skipNext());
                      }),
                  IconButton(
                      icon: BuJuanUtil.getPlayMode(state.playModeType),
                      onPressed: () {
                        dispatch(PlayViewActionCreator.getChangePlayMode());
                      }),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    ),
  );
}

Widget _leftChild(PlayViewState state, dispatch, viewService) {
  var lyric2 = state.lyric;
  var width2 = MediaQuery.of(viewService.context).size.width;
  var height2 = MediaQuery.of(viewService.context).size.height;
  return Scaffold();
}

Widget _rightChild(PlayViewState state, dispatch, viewService) {
  return state.songList != null
      ? Scaffold(
          body: Container(
            padding: EdgeInsets.only(
                left: MediaQuery.of(viewService.context).size.width / 7.8,
                top: state.isMinni
                    ? 10
                    : MediaQueryData.fromWindow(window).padding.top),
            child: ListView.builder(
                itemCount: state.songList.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(
                          left: 15, top: 0, bottom: 0, right: 5),
                      trailing:
                          state.songList[index].name == state.currSong.name
                              ? ColorLoader3(
                                  radius: 10.0,
                                  dotRadius: 2.0,
                                )
                              : Text(''),
                      title: Text(state.songList[index].name,
                          overflow: TextOverflow.ellipsis),
                      subtitle: Text(state.songList[index].singer,
                          overflow: TextOverflow.ellipsis),
                      onTap: () {
                        dispatch(PlayViewActionCreator.playSingleSong(index));
                      },
                    ),
                  );
                }),
          ),
        )
      : Center();
}
