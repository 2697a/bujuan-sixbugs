import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/widget/play_bar/action.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../cache_image.dart';
import 'state.dart';

Widget buildView(
    PlayBarState state, Dispatch dispatch, ViewService viewService) {
  return Offstage(
    offstage: state.currSong == null,
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageHelper.getImage('${state.currSong.picUrl ?? ''}?param=500y500',
                  isRound: true, height: Screens.setHeight(45.0)),
              Padding(padding: EdgeInsets.only(left: Screens.width10)),
              Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        height: Screens.setHeight(22),
                        child: Text(state.currSong.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: Screens.text12)),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: Screens.setHeight(22),
                        child: Text(state.currSong.singer,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: Screens.text10)),
                      )
                    ],
                  )),
              Wrap(
                children: <Widget>[
                  InkWell(
                    child: Container(
                      height: Screens.setHeight(42),
                      width: Screens.setWidth(42),
                      child: state.playStateType == PlayStateType.Stop ||
                          state.playStateType == PlayStateType.Pause
                          ? Icon(Icons.play_arrow, size: Screens.setSp(24))
                          : Icon(Icons.pause, size: Screens.setSp(24)),
                    ),
                    onTap: () => dispatch(PlayBarActionCreator.sendTask()),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: Screens.width5)),
                  InkWell(
                    child: Container(
                      height: Screens.setHeight(42),
                      width: Screens.setWidth(42),
                      child: Icon(Icons.skip_next, size: Screens.setSp(24)),
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
  );

//  return ListTile(
//    dense: true,
//    contentPadding: EdgeInsets.symmetric(horizontal: Screens.width5),
//    leading: ImageHelper.getImage(
//        '${state.currSong.picUrl ?? ''}?param=500y500',
//        isRound: true,
//        height: Screens.setHeight(45.0)),
//    title: Text(state.currSong.name,
//        overflow: TextOverflow.ellipsis,
//        style: TextStyle(fontSize: Screens.text12)),
//    subtitle: Text(state.currSong.singer,
//        overflow: TextOverflow.ellipsis,
//        style: TextStyle(fontSize: Screens.text10)),
//    trailing:Wrap(
//      children: <Widget>[
//        InkWell(
//          child: Container(
//            height: Screens.setHeight(42),
//            width: Screens.setWidth(42),
//            child: state.playStateType == PlayStateType.Stop ||
//                state.playStateType == PlayStateType.Pause
//                ? Icon(Icons.play_arrow, size: Screens.setSp(24))
//                : Icon(Icons.pause, size: Screens.setSp(24)),
//          ),
//          onTap: () => dispatch(PlayBarActionCreator.sendTask()),
//        ),
//        Padding(
//            padding: EdgeInsets.symmetric(horizontal: Screens.width5)),
//        InkWell(
//          child: Container(
//            height: Screens.setHeight(42),
//            width: Screens.setWidth(42),
//            child: Icon(Icons.skip_next, size: Screens.setSp(24)),
//          ),
//          onTap: () => dispatch(PlayBarActionCreator.nextSong()),
//        ),
//      ],
//    ) ,
//  );
}
