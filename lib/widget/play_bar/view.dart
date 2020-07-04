import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/widget/play_bar/action.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';

import '../cache_image.dart';
import 'state.dart';

Widget buildView(
    PlayBarState state, Dispatch dispatch, ViewService viewService) {
  return state.currSong!=null?InkWell(
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
                  '${state.currSong.songCover ?? ''}?param=150y150',
                  isRound: true,
                  height: Screens.setHeight(40)),
              Padding(padding: EdgeInsets.only(left: Screens.width10)),
              Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        height: Screens.setHeight(24),
                        child: Text(state.currSong.songName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: Screens.text14)),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: Screens.setHeight(24),
                        child: Text(state.currSong.artist,
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
                      child: state.playState == PlayState.STOP ||
                          state.playState == PlayState.PAUSE
                          ? Icon(Icons.play_arrow)
                          : Icon(Icons.pause),
                    ),
                    onTap: () => dispatch(PlayBarActionCreator.sendTask()),
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
                    onTap: () => dispatch(PlayBarActionCreator.nextSong()),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ),
    onTap: () {
      dispatch(PlayBarActionCreator.openPlayPage());
    },
  ):Container(
    height: Screens.setHeight(56),
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    alignment: Alignment.centerLeft,
    child: Text('暂无播放歌曲'),
  );
//  return SlidingUpPanel(
//    color: Colors.transparent,
//    minHeight: Screens.setHeight(56),
//    maxHeight: MediaQuery.of(viewService.context).size.height,
//    boxShadow: null,
//    panel: PlayView2Page().buildPage(null),
//    collapsed: InkWell(
//      child: Container(
//        height: Screens.setHeight(56),
//        padding: EdgeInsets.symmetric(horizontal: Screens.width5),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                ImageHelper.getImage(
//                    '${state.currSong.picUrl ?? ''}?param=150y150',
//                    isRound: true,
//                    height: Screens.setHeight(40)),
//                Padding(padding: EdgeInsets.only(left: Screens.width10)),
//                Expanded(
//                    child: Column(
//                      children: <Widget>[
//                        Container(
//                          alignment: Alignment.centerLeft,
//                          height: Screens.setHeight(24),
//                          child: Text(state.currSong.name,
//                              overflow: TextOverflow.ellipsis,
//                              style: TextStyle(fontSize: Screens.text14)),
//                        ),
//                        Container(
//                          alignment: Alignment.centerLeft,
//                          height: Screens.setHeight(24),
//                          child: Text(state.currSong.singer,
//                              overflow: TextOverflow.ellipsis,
//                              style: TextStyle(fontSize: Screens.text12)),
//                        )
//                      ],
//                    )),
//                Wrap(
//                  children: <Widget>[
//                    InkWell(
//                      child: Container(
//                        height: Screens.setHeight(42),
//                        width: Screens.setWidth(42),
//                        child: state.playStateType == PlayStateType.Stop ||
//                            state.playStateType == PlayStateType.Pause
//                            ? Icon(Icons.play_arrow)
//                            : Icon(Icons.pause),
//                      ),
//                      onTap: () => dispatch(PlayBarActionCreator.sendTask()),
//                    ),
//                    Padding(
//                        padding:
//                        EdgeInsets.symmetric(horizontal: Screens.width5)),
//                    InkWell(
//                      child: Container(
//                        height: Screens.setHeight(42),
//                        width: Screens.setWidth(42),
//                        child: Icon(Icons.skip_next),
//                      ),
//                      onTap: () => dispatch(PlayBarActionCreator.nextSong()),
//                    ),
//                  ],
//                ),
//              ],
//            )
//          ],
//        ),
//      ),
//      onTap: () {
//        dispatch(PlayBarActionCreator.openPlayPage());
//      },
//    ),
//  );
}
