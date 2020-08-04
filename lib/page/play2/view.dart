import 'dart:ui';

import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/page/play2/action.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'state.dart';

Widget buildView(
    PlayView2State state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    key: state.scaffoldKey,
    body: Container(
      child: Column(
        children: <Widget>[
          Expanded(child: Column(
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
                          progressBarColor: Color.fromRGBO(220, 190, 251, 1)),
                      customWidths:
                      CustomSliderWidths(trackWidth: 1, progressBarWidth: 4)),
                  min: 0,
                  max: state.currSong.duration.toDouble(),
                  initialValue: state.currSongPos.toDouble(),
                  onChange: (double value) {},
                  onChangeStart: (double startValue) {
                  },
                  onChangeEnd: (double endValue) {
                  },
                  innerWidget: (double value) {
                    return Center(
                      child: Stack(
                        children: <Widget>[
                          ImageHelper.getImage(
                              state.currSong.songCover + "?param=500y500",
                              height:
                              MediaQuery.of(viewService.context).size.width /
                                  1.26,
                              isRound: true),
                          Container(
                            height:
                            MediaQuery.of(viewService.context).size.width /
                                1.26,
                            width:
                            MediaQuery.of(viewService.context).size.width /
                                1.26,
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              width: Screens.setWidth(55),
                              height: Screens.setWidth(55),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(220, 190, 251, 1),
                                  borderRadius:
                                  BorderRadius.circular(Screens.setWidth(55))),
                              child: IconButton(
                                  icon: state.playState == PlayState.STOP ||
                                      state.playState == PlayState.PAUSE
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
                          )
                        ],
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
                      state.currSong.artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      state.currSong.songName,
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
                  state.currSong.isLike != null
                      ? IconButton(
                      icon: state.currSong.isLike
                          ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                          : Icon(
                        Icons.favorite_border,
                      ),
                      onPressed: () {
                        dispatch(PlayViewActionCreator.getLikeOrUnLike(
                            !state.currSong.isLike));
                      })
                      : IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        dispatch(PlayViewActionCreator.getLikeOrUnLike(!state.currSong.isLike));
                      }),
                  IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () {
                        dispatch(PlayViewActionCreator.getSongTalk(
                            state.currSong.songId.toString()));
                      }),
                ],
              ),
            ],
          )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            alignment: Alignment.centerLeft,
            child: IconButton(icon: Icon(Icons.keyboard_arrow_down), onPressed: (){
              Navigator.of(viewService.context).pop();
            }),
          ),
        ],
      ),
    ),
  );
}

