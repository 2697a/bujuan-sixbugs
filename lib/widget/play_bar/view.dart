import 'dart:ui';

import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/play_bar/action.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../cache_image.dart';
import 'state.dart';

Widget buildView(PlayBarState state, Dispatch dispatch, ViewService viewService) {
//  return state.currSong != null
//      ? InkWell(
//          child: AnimatedContainer(
//            duration: Duration(milliseconds: 200),
//            alignment: Alignment.center,
////            decoration: BoxDecoration(
////              color: Colors.white,
////              borderRadius: BorderRadius.circular( Screens.setHeight(46))
////            ),
//            height: Screens.setHeight(60),
//            width: state.isMini?Screens.setHeight(60):MediaQuery.of(viewService.context).size.width,
//            margin: !state.isMini?EdgeInsets.only(left: 30):EdgeInsets.all(0),
//            child: Card(
//              elevation: 13,
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Screens.setHeight(52))),
//              child: ListView(
//                shrinkWrap: true,
//                physics: NeverScrollableScrollPhysics(),
//                scrollDirection: Axis.horizontal,
//                children: <Widget>[
//                  Container(
//                    width: MediaQuery.of(viewService.context).size.width-30,
//                    child: Row(
//                      children: <Widget>[
//                        InkWell(
//                          child: Container(
//                            width: Screens.setHeight(60),
//                            height: Screens.setHeight(60),
//                            alignment: Alignment.center,
//                            child: ImageHelper.getImage('${state.currSong.songCover ?? ''}?param=150y150', isRound: true, height: Screens.setHeight(40)),
//                          ),
//                          onTap: (){
//                            dispatch(PlayBarActionCreator.openPlayPage());
//                          },
//                          onLongPress: (){
//                            dispatch(PlayBarActionCreator.changeView());
//                          },
//                        ),
//                        Padding(padding: EdgeInsets.only(right: 8)),
//                        Expanded(child: Offstage(
//                          offstage: state.isMini,
//                          child: Column(
//                            children: <Widget>[
//                              Container(
//                                alignment: Alignment.centerLeft,
//                                height: Screens.setHeight(24),
//                                child: Text('${state.currSong.songName}', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: Screens.text14)),
//                              ),
//                              Container(
//                                alignment: Alignment.centerLeft,
//                                height: Screens.setHeight(24),
//                                child: Text(state.currSong.artist, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: Screens.text12)),
//                              )
//                            ],
//                          ),
//                        )),
//                        Offstage(
//                          offstage: state.isMini,
//                          child: Wrap(
//                            children: <Widget>[
//                              InkWell(
//                                child: Container(
//                                  width: 42,
//                                  height: 42,
//                                  child: state.playState == PlayState.STOP || state.playState == PlayState.PAUSE ? Icon(Icons.play_arrow) : Icon(Icons.pause),
//                                ),
//                                onTap: () => dispatch(PlayBarActionCreator.sendTask()),
//                              ),
//                              Padding(padding: EdgeInsets.symmetric(horizontal: Screens.width5)),
//                              InkWell(
//                                child: Container(
//                                  width: 42,
//                                  height: 42,
//                                  child: Icon(Icons.keyboard_arrow_right),
//                                ),
//                                onTap: () {
//                                  dispatch(PlayBarActionCreator.changeView());
//                                },
//                              ),
//                            ],
//                          ),
//                        )
//                      ],
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ),
//          onTap: () {
//            dispatch(PlayBarActionCreator.openPlayPage());
//          },
//        )
//      : Container(
////          color: Colors.amber,
////          height: Screens.setHeight(62),
////          width: Screens.setHeight(62),
////          padding: EdgeInsets.symmetric(horizontal: 10.0),
////          alignment: Alignment.centerLeft,
////          child: Text('暂无'),
//        );
//  return SlidingUpPanel(
//    color: Colors.transparent,
//    minHeight: Screens.setHeight(62),
//    maxHeight: MediaQuery.of(viewService.context).size.height,
//    boxShadow: null,
//    panel: PlayView2Page().buildPage(null),
//    collapsed: InkWell(
//      child: Container(
//        height: Screens.setHeight(62),
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

  return state.currSong != null
      ? SlidingUpPanel(
          controller: state.panelController,
          onPanelOpened: () {
            println('state====open${state.panelController.isPanelOpen}');
          },
          onPanelClosed: () {
            println('state====close${state.panelController.isPanelOpen}');
          },
          panel: Scaffold(
            body: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 65),
                            alignment: Alignment.center,
                            child: SleekCircularSlider(
                              appearance: CircularSliderAppearance(
                                  size: MediaQuery.of(viewService.context).size.width / 1.2,
                                  startAngle: 45,
                                  angleRange: 300,
                                  customColors: CustomSliderColors(trackColor: Colors.grey.withOpacity(.6), progressBarColor: Color.fromRGBO(220, 190, 251, 1)),
                                  customWidths: CustomSliderWidths(trackWidth: 1, progressBarWidth: 4)),
                              min: 0,
                              max: state.currSong.duration.toDouble(),
                              initialValue: state.currSongPos.toDouble(),
                              onChange: (double value) {},
                              onChangeStart: (double startValue) {},
                              onChangeEnd: (double endValue) {},
                              innerWidget: (double value) {
                                return Center(
                                  child: Stack(
                                    children: <Widget>[
                                      ImageHelper.getImage(state.currSong.songCover + "?param=500y500", height: MediaQuery.of(viewService.context).size.width / 1.26, isRound: true),
                                      Container(
                                        height: MediaQuery.of(viewService.context).size.width / 1.26,
                                        width: MediaQuery.of(viewService.context).size.width / 1.26,
                                        alignment: Alignment.center,
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 30),
                                          width: Screens.setWidth(55),
                                          height: Screens.setWidth(55),
                                          decoration: BoxDecoration(color: Color.fromRGBO(220, 190, 251, 1), borderRadius: BorderRadius.circular(Screens.setWidth(55))),
                                          child: IconButton(
                                              icon: state.playState == PlayState.STOP || state.playState == PlayState.PAUSE
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
                                                dispatch(PlayBarActionCreator.sendTask());
//                                      dispatch(PlayViewActionCreator.playOrPause());
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
//                          state.scaffoldKey.currentState.openDrawer();
                                  }),
                              IconButton(
                                  icon: BuJuanUtil.getPlayMode(state.playModeType),
                                  onPressed: () {
//                          dispatch(PlayViewActionCreator.getChangePlayMode());
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
//                          dispatch(PlayViewActionCreator.getLikeOrUnLike(
//                              !state.currSong.isLike));
                                  })
                                  : IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  onPressed: () {
//                          dispatch(PlayViewActionCreator.getLikeOrUnLike(!state.currSong.isLike));
                                  }),
                              IconButton(
                                  icon: Icon(Icons.message),
                                  onPressed: () {
//                          dispatch(PlayViewActionCreator.getSongTalk(
//                              state.currSong.songId.toString()));
                                  }),
                            ],
                          ),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        icon: Icon(Icons.keyboard_arrow_down),
                        onPressed: () {
                          Navigator.of(viewService.context).pop();
                        }),
                  ),
                ],
              ),
            ),
          ),
          minHeight: Constants.bottomHeight,
          maxHeight: MediaQuery.of(viewService.context).size.height,
          collapsed: IgnorePointer(
            ignoring: state.panelController.isAttached?state.panelController.isPanelOpen:false,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Screens.width10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ImageHelper.getImage('${state.currSong.songCover ?? ''}?param=150y150', isRound: true, height: Screens.setHeight(48)),
                        Padding(padding: EdgeInsets.only(left: Screens.width10)),
                        Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: Screens.setHeight(24),
                                  child: Text(state.currSong.songName, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: Screens.text14)),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: Screens.setHeight(24),
                                  child: Text(state.currSong.artist, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: Screens.text12)),
                                )
                              ],
                            )),
                        Wrap(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                height: Screens.setHeight(42),
                                width: Screens.setWidth(42),
                                child: state.playState == PlayState.STOP || state.playState == PlayState.PAUSE ? Icon(Icons.play_arrow) : Icon(Icons.pause),
                              ),
                              onTap: () {
                                if (state.panelController.isPanelClosed) dispatch(PlayBarActionCreator.sendTask());
                              },
                            ),
                            Padding(padding: EdgeInsets.symmetric(horizontal: Screens.width5)),
                            InkWell(
                              child: Container(
                                height: Screens.setHeight(42),
                                width: Screens.setWidth(42),
                                child: Icon(Icons.skip_next),
                              ),
                              onTap: () {
                                if (state.panelController.isPanelClosed) dispatch(PlayBarActionCreator.nextSong());
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              onTap: () {
                state.panelController.open();
              },
            ),
          ),
        )
      : Container();
}
