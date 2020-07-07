import 'dart:async';

import 'package:bujuan/constant/Screens.dart';
import 'package:flutter/material.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';
import 'package:flutterstarrysky/song_info.dart';

import '../cache_image.dart';
class BottomPlayBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>BottomPlayBarState();

}

class BottomPlayBarState extends State{
  PlayState _playState;
  SongInfo _songInfo;
  StreamSubscription _songListen;
  StreamSubscription _songPlayState;
  @override
  void initState() {
    super.initState();
    _playState= PlayState.STOP;
    FlutterStarrySky().onPlayerSongChanged.listen((event) {
      setState(() {
        _songInfo = event;
      });
    });
    _songPlayState = FlutterStarrySky().onPlayerStateChanged.listen((event) {
      setState(() {
        _playState = event;
      });
    });
  }

  @override
  void dispose() {
    _songListen?.cancel();
    _songPlayState.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _songInfo!=null?InkWell(
      child: Container(
        color: Colors.transparent,
        height: Screens.setHeight(56),
        padding: EdgeInsets.symmetric(horizontal: Screens.width5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ImageHelper.getImage(
                    '${_songInfo.songCover ?? ''}?param=150y150',
                    isRound: true,
                    height: Screens.setHeight(40)),
                Padding(padding: EdgeInsets.only(left: Screens.width10)),
                Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          height: Screens.setHeight(24),
                          child: Text(_songInfo.songName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: Screens.text14)),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: Screens.setHeight(24),
                          child: Text(_songInfo.artist,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: Screens.text12)),
                        )
                      ],
                    )),
                Wrap(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        height: Screens.setHeight(42),
                        width: Screens.setWidth(42),
                        child: _playState == PlayState.STOP ||
                           _playState == PlayState.PAUSE
                            ? Icon(Icons.play_arrow)
                            : Icon(Icons.pause),
                      ),
                      onTap: () {

                      },
                    ),
                    Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: Screens.width5)),
                    InkWell(
                      child: Container(
                        height: Screens.setHeight(42),
                        width: Screens.setWidth(42),
                        child: Icon(Icons.skip_next),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {

      },
    ):Container(
      height: Screens.setHeight(56),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      alignment: Alignment.centerLeft,
      child: Text('暂无播放歌曲'),
    );
  }

}