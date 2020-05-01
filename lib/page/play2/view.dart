import 'dart:ui';

import 'package:bujuan/bujuan_music.dart';
import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/page/play2/action.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'state.dart';

Widget buildView(
    PlayView2State state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    key: state.scaffoldKey,
    body: Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top+25),
            alignment: Alignment.center,
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                  size: MediaQuery.of(viewService.context).size.width / 1.2,
                  startAngle: 45,
                  angleRange: 300,
                  customColors: CustomSliderColors(
                      trackColor: Colors.grey.withOpacity(.6),
                      progressBarColor: Color.fromRGBO(220, 190, 251, .6)),
                  customWidths:
                  CustomSliderWidths(trackWidth: 1, progressBarWidth: 4)),
              min: 0,
              max: state.currSongAllPos.toDouble(),
              initialValue: state.currSongPos.toDouble(),
              onChange: (double value) {},
              onChangeStart: (double startValue) {
              },
              onChangeEnd: (double endValue) {
                BujuanMusic.seekTo(endValue.toInt().toString());
              },
              innerWidget: (double value) {
                return Center(
                  child: InkWell(
                    child: ImageHelper.getImage(
                        state.currSong.picUrl + "?param=500y500",
                        height:
                        MediaQuery.of(viewService.context).size.width /
                            1.26,
                        isRound: true),
                    onTap: () async {
                      await BujuanMusic.lyric(Constants.dark ? '1' : '0');
                    },
                  ),
                );
              },
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 12)),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.sort),
                  onPressed: () {
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
                          '${index + 1}. ${state.songList[index].name} -- ${state.songList[index].singer}',
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

