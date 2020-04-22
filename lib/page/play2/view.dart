import 'dart:ui';

import 'package:bujuan/bujuan_music.dart';
import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/page/play/action.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'state.dart';

Widget buildView(
    PlayView2State state, Dispatch dispatch, ViewService viewService) {
  var d = state.currSongPos / state.currSongAllPos * 100;
  var height = MediaQuery.of(viewService.context).size.height;
  return Scaffold(
    body: Container(
      child: Column(
        children: <Widget>[
          ImageHelper.getImageNoRound(state.currSong.picUrl+"?param=800y800", height: height / 1.8),
          SliderTheme(
            data: SliderTheme.of(viewService.context).copyWith(
              //已拖动的颜色
              activeTrackColor:
              Constants.dark ? Colors.white : Colors.black,
              //未拖动的颜色
              inactiveTrackColor: Colors.grey,

              //提示进度的气泡的背景色
              valueIndicatorColor: Colors.amber[0],
              //提示进度的气泡文本的颜色
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),

              //滑块中心的颜色
              thumbColor: Constants.dark ? Colors.white : Colors.black,
              trackHeight: 4,
              trackShape: RectangularSliderTrackShape(),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
              //滑块边缘的颜色
              overlayColor: Colors.white,

              //divisions对进度线分割后，断续线中间间隔的颜色
              inactiveTickMarkColor: Colors.white,
            ),
            child: Slider(
                value: d >= 0 && d <= 100 ? d : 0,
                max: 100,
                min: 0,
                onChangeEnd: (d) {},
                onChanged: (value) {
                  dispatch(PlayViewActionCreator.seekTo(
                      (value * state.currSongAllPos ~/ 100)
                          .toString()));
                }),
          )
        ],
      ),
    ),
  );
}

Widget _body(PlayView2State state, viewService, dispatch) {
  var width2 = MediaQuery.of(viewService.context).size.width;
  var d = state.currSongPos / state.currSongAllPos * 100;
  return Scaffold(
    body: SlidingUpPanel(
      color: Constants.dark ? Colors.grey[850] : Colors.white,
      minHeight: Screens.setHeight(100),
      maxHeight: MediaQuery.of(viewService.context).size.height * 0.9,
      borderRadius: BorderRadius.circular(15),
      boxShadow: null,
      backdropOpacity: 0,
      panelBuilder: (ScrollController sc) => ListView.separated(
        controller: sc,
        itemCount: state.songList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            dense: true,
            title: Text(
              '${index + 1}. ${state.songList[index].name} -- ${state.songList[index].singer}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: Screens.text12),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
      collapsed: Container(
        color: Constants.dark ? Colors.grey[850] : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: Screens.width10),
//        height: Screens.setHeight(56),
        child: Column(
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.keyboard_arrow_up),
                onPressed: () {},
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
            top: MediaQueryData.fromWindow(window).padding.top),
        child: Column(
          children: <Widget>[
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              leading: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Constants.dark ? Colors.white : Colors.black,
                  ),
                  onPressed: () => Navigator.pop(viewService.context)),
              title: Text(
                '${state.currSong.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: Screens.text18),
              ),
              subtitle: Text(
                '${state.currSong.singer}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: Screens.text14),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            InkWell(
              child: ImageHelper.getImage(
                  state.currSong.picUrl + "?param=500y500",
                  height: width2 * 0.85,
                  isRound: true),
              onTap: () async =>
                  await BujuanMusic.lyric(Constants.dark ? '1' : '0'),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
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
                          activeColor: Colors.amber.withOpacity(.6),
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
                          icon: Icon(Icons.favorite_border), onPressed: () {}),
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
