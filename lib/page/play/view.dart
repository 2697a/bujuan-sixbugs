import 'dart:ui';

import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/page/play/action.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/bujuan_background.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/color_loaed.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    PlayViewState state, Dispatch dispatch, ViewService viewService) {
  return _body(state, viewService, dispatch);
}

Widget _body(PlayViewState state, viewService, dispatch) {
  var width2 = MediaQuery.of(viewService.context).size.width;
  var d = state.currSongPos / state.currSongAllPos * 100;
  return BujuanBack.back(
      Scaffold(
        body: Container(
          margin: EdgeInsets.only(
              left: Screens.setWidth(10),
              right: Screens.setWidth(10),
              top: state.isMinni
                  ? 0
                  : MediaQueryData.fromWindow(window).padding.top + 45),
          child: Column(
            children: <Widget>[
//              Container(
//                child: Column(
//                  children: <Widget>[
//                    Container(
//                      alignment: Alignment.center,
//                      padding: EdgeInsets.only(top: Screens.height5),
//                      child: Text(state.currSong.name,
//                          maxLines: 1,
//                          overflow: TextOverflow.ellipsis,
//                          style: TextStyle(
//                              fontSize: Screens.text14,
//                              fontWeight: FontWeight.bold,
//                              wordSpacing: 2)),
//                    ),
//                    Container(
//                      padding: EdgeInsets.only(
//                          top: Screens.setHeight(8), bottom: Screens.height10),
//                      alignment: Alignment.center,
//                      child: Text(state.currSong.singer,
//                          style: TextStyle(
//                              fontSize: Screens.text12,
//                              color: Colors.grey,
//                              wordSpacing: 2)),
//                    ),
//                  ],
//                ),
//              ),
              Padding(padding: EdgeInsets.only(top: Screens.setHeight(72))),
//              Stack(
//                children: <Widget>[
//                  InkWell(
//                    child: Container(
//                      width: width2,
//                      child: ImageHelper.getImage(
//                          state.currSong.picUrl + "?param=500y500",
//                          height: width2 * 0.8,
//                          isRound: true),
//                    ),
//                    onTap: () {},
//                  ),
//                ],
//              ),
              ImageHelper.getImage(
                  state.currSong.picUrl + "?param=500y500",
                  height: width2 * 0.85,
                  isRound: true),
              Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8)),
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
                            onChangeEnd: (d) {
//                          state.lyricController.progress = Duration(milliseconds: (d * state.currSongAllPos ~/ 100));
                            },
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
                                    size: Screens.setSp(20),
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    size: Screens.setSp(20),
                                  ),
                            onPressed: () {
                              dispatch(PlayViewActionCreator.getLikeOrUnLike(
                                  !state.currSong.like));
                            })
                        : IconButton(
                            icon: Icon(Icons.favorite_border,
                                size: Screens.setSp(20)),
                            onPressed: () {}),
                    IconButton(
                        icon:
                            Icon(Icons.skip_previous, size: Screens.setSp(20)),
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
                                  size: Screens.setSp(20),
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.pause,
                                  size: Screens.setSp(20),
                                  color: Colors.white,
                                ),
                          onPressed: () {
                            ///操作
                            dispatch(PlayViewActionCreator.playOrPause());
                          }),
                    ),
                    IconButton(
                        icon: Icon(Icons.skip_next, size: Screens.setSp(20)),
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
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.keyboard_arrow_down),
                        onPressed: () {
                          Navigator.pop(viewService.context);
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.message,
                          size: 20,
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
      ),
      viewService.context);
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
