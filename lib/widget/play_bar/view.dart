import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/widget/play_bar/action.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../cache_image.dart';
import 'state.dart';

Widget buildView(PlayBarState state, Dispatch dispatch, ViewService viewService) {
  return Offstage(
    offstage: state.currSong == null,
    child: InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Screens.setHeight(8), horizontal: Screens.width10),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12, width: 0.3)),
        ),
        child: Row(
          children: <Widget>[
            ImageHelper.getImage('${state.currSong.picUrl ?? ''}?param=100y100',
                isRound: true, height: Screens.setHeight(42.0)),
            Padding(padding: EdgeInsets.only(left: Screens.width10)),
            Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      height: Screens.setHeight(21),
                      child: Text(state.currSong.name,
                          overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: Screens.text12)),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: Screens.setHeight(21),
                      child: Text(state.currSong.singer,
                          overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: Screens.text10,color: Colors.grey)),
                    )
                  ],
                )),
            Wrap(
              children: <Widget>[
                InkWell(
                  child: Container(
                    height: Screens.setHeight(40),
                    width: Screens.setWidth(40),
                    child: state.playStateType == PlayStateType.Stop ||
                        state.playStateType == PlayStateType.Pause
                        ? Icon(Icons.play_arrow, size: Screens.setSp(22))
                        : Icon(Icons.pause, size: Screens.setSp(22)),
                  ),
                  onTap: () => dispatch(PlayBarActionCreator.sendTask()),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: Screens.width5)),
                InkWell(
                  child: Container(
                    height: Screens.setHeight(40),
                    width: Screens.setWidth(40),
                    child: Icon(Icons.skip_next, size: Screens.setSp(22)),
                  ),
                  onTap: () => dispatch(PlayBarActionCreator.nextSong()),
                ),
//                  IconButton(
//                      padding: EdgeInsets.all(0),
//                      icon: state.playStateType == PlayStateType.Stop ||
//                          state.playStateType == PlayStateType.Pause
//                          ? Icon(Icons.play_arrow,size: Screens.text18,)
//                          : Icon(Icons.pause,size: Screens.text18,),
//                      onPressed: () {
//                        ///操作
//                        dispatch(PlayBarActionCreator.sendTask());
//                      }),
//                  IconButton(
//                    padding: EdgeInsets.all(0),
//                      icon: Icon(Icons.skip_next,size: Screens.text18,),
//                      onPressed: () {
//                        ///操作
//                        dispatch(PlayBarActionCreator.nextSong());
//                      })
              ],
            ),
          ],
        ),
      ),
      onTap: ()=>dispatch(PlayBarActionCreator.openPlayPage()),
    ),
  );
}
