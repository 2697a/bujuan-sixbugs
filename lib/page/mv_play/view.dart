import 'package:bujuan/widget/loading_page.dart';
//import 'package:fijkplayer/fijkplayer.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    MvPlayViewState state, Dispatch dispatch, ViewService viewService) {
  var width2 = MediaQuery.of(viewService.context).size.width;
  return Scaffold(
    appBar: AppBar(
      title: Text(state.showLoading ? '' : state.mvData.data.name),
    ),
    body: state.showLoading
        ? LoadingPage()
        : Container(
            child: Column(
              children: <Widget>[
                Container(
//                  child: FijkView(
//                    color: Colors.black,
//                    width: width2,
//                    height: width2 / 16 * 9,
//                    player: state.player,
//                  ),
                )
              ],
            ),
          ),
  );
}
