import 'package:bujuan/page/top/top_details/action.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    TopDetailsState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: BujuanAppBar.norAppBar(viewService.context, '網易排行榜'),
    body: state.showLoading
        ? LoadingPage()
        : Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
//              return InkWell(
//                child: Container(
//                  padding: EdgeInsets.symmetric(vertical: Screens.height10, horizontal: Screens.width10),
//                  child: Row(
//                    children: <Widget>[
//                      Expanded(
//                          child: Column(
//                            children: <Widget>[
//                              Container(
//                                  alignment: Alignment.centerLeft,
//                                  height: Screens.setHeight(20),
//                                  child: Row(
//                                    children: <Widget>[
//                                      Text(
//                                        '${index + 1}. ',
//                                        style: TextStyle(
//                                            color: Colors.blue,
//                                            fontSize: Screens.text14,
//                                            fontWeight: FontWeight.bold),
//                                      ),
//                                      Expanded(
//                                          child: Text(
//                                            state.list[index].name,
//                                            style: TextStyle(fontSize: Screens.text14),
//                                          ))
//                                    ],
//                                  )),
//                              Container(
//                                  alignment: Alignment.centerLeft,
//                                  height: Screens.setHeight(20),
//                                  child: Text('${state.list[index].singer}',
//                                      maxLines: 1,
//                                      overflow: TextOverflow.ellipsis,
//                                      style: TextStyle(fontSize: Screens.text12, color: Colors.grey)))
//                            ],
//                          )),
////                            state.list[index].mv == 0
////                                ? Container()
////                                : IconButton(
////                                icon: Icon(
////                                  Icons.videocam,
////                                  size: Screens.text18,
////                                ),
////                                onPressed: () {
////                                  Navigator.of(viewService.context)
////                                      .pushNamed('mv_play', arguments: {'mvId': state.list[index].mv}); //注意2
////                                })
//                    ],
//                  ),
//                ),
//                onTap: () => dispatch(TopDetailsActionCreator.onPlaySong(index)),
//              );
                  return ListTile(
                    dense: true,
                    contentPadding:
                    EdgeInsets.only(left: 5, top: 0, bottom: 0),
//                      leading: ImageHelper.getImage('${state.list[index].picUrl??''}?param=100y100',
//                          height: 35, isRound: true),
                    title: Row(
                      children: <Widget>[
                        Text(
                          '${index + 1}. ',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(state.list[index].name))
                      ],
                    ),
                    subtitle: Text(
                      state.list[index].singer,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: state.list[index].mv == 0
                        ? Container(
                      width: 0,
                    )
                        : IconButton(
                        icon: Icon(
                          Icons.videocam,
                          size: 18,
                        ),
                        onPressed: () {
                          Navigator.of(viewService.context)
                              .pushNamed('mv_play', arguments: {
                            'mvId': state.list[index].mv
                          }); //注意2
                        }),
                    onTap: () {
                      dispatch(TopDetailsActionCreator.onPlaySong(index));
                    },
                  );
                },
                itemCount: state.list.length,
              )),
          PlayBarPage().buildPage(null)
        ],
      ),
    ),
  );
}
