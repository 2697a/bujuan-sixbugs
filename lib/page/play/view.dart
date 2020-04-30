import 'dart:ui';

import 'package:bujuan/bujuan_music.dart';
import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/page/play/action.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/color_loaed.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'state.dart';

Widget buildView(
    PlayViewState state, Dispatch dispatch, ViewService viewService) {
  var d = state.currSongPos / state.currSongAllPos * 100;
  return Scaffold(
    key: state.scaffoldKey,
    body: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.symmetric(vertical: MediaQueryData.fromWindow(window).padding.top)),
                IconButton(
                  icon:ImageHelper.getImage(
                      state.currSong.picUrl + "?param=500y500"),
                  iconSize: MediaQuery.of(viewService.context).size.width / 1.4,
                  onPressed: () async =>
                  await BujuanMusic.lyric(Constants.dark ? '1' : '0'),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.sort), onPressed: () {
                      state.scaffoldKey.currentState.openDrawer();
                    }),
                    IconButton(
                        icon: BuJuanUtil.getPlayMode(state.playModeType),
                        onPressed: () {
                          dispatch(PlayViewActionCreator.getChangePlayMode());
                        }),
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
                            onPressed: () {
                              dispatch(PlayViewActionCreator.getLikeOrUnLike(!state.currSong.like));
                            }),
                    IconButton(
                        icon: Icon(Icons.message),
                        onPressed: () {
                          dispatch(PlayViewActionCreator.getSongTalk(
                              state.currSong.id.toString()));
                        }),
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        state.currSong.singer,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        state.currSong.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  child: SliderTheme(
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
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${BuJuanUtil.unix2Time(state.currSongPos)}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${BuJuanUtil.unix2Time(state.currSongAllPos)}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            flex: 4,
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.skip_previous),
                      onPressed: () {
                        dispatch(PlayViewActionCreator.skipPrevious());
                      }),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    width: Screens.setWidth(55),
                    height: Screens.setWidth(55),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius:
                            BorderRadius.circular(Screens.setWidth(55))),
                    child: IconButton(
                        icon: state.playStateType == PlayStateType.Stop ||
                                state.playStateType == PlayStateType.Pause
                            ? Icon(
                                Icons.play_arrow,
                                size: 30,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.pause,
                                size: 30,
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
                ],
              ),
            ),
            flex: 1,
          )
        ],
      ),
    ),
      drawer:  Drawer(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20)),
              ListTile(
                dense: true,
                title: Text(
                  '${state.currSong.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: Screens.text14, color: Colors.red),
                ),
                subtitle: Text('${state.currSong.singer}',
                    style:
                    TextStyle(fontSize: Screens.text14, color: Colors.red)),
                trailing: IconButton(
                    icon: Icon(
                      Icons.play_circle_filled,
                      color: Colors.red,
                    ),
                    onPressed: () {}),
              ),
              Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                        title: Text(
                          '${index + 1}. ${state.songList[index].name}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: Screens.text14),
                        ),
                        subtitle: Text('${state.songList[index].singer}',
                            style: TextStyle(fontSize: Screens.text14)),
                        onTap: () async {
                          await BujuanMusic.playIndex(index: index);
                        },
                      );
                    },
                    itemCount: state.songList.length,
                  ))
            ],
          ),
        ),
      )
  );
}

Widget _body(PlayViewState state, viewService, dispatch) {
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
                          icon: Icon(Icons.favorite_border), onPressed: () {
                            dispatch(PlayViewActionCreator.getLikeOrUnLike(state.currSong.like));
                  }),
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
