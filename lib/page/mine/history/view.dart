import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/page/mine/history/action.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    HistoryState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: BujuanAppBar.norAppBar(viewService.context, '听歌历史'),
    body: state.showLoading
        ? LoadingPage()
        : Container(
            padding: EdgeInsets.only(left: 0, right: 5),
            child: Column(
              children: <Widget>[
                Expanded(child: ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Screens.height10, horizontal: Screens.width10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        height: Screens.setHeight(20),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              '${index + 1}. ',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: Screens.text14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                                child: Text(
                                                  '${state.list[index].name}',
                                                  style: TextStyle(fontSize: Screens.text12),
                                                ))
                                          ],
                                        )),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        height: Screens.setHeight(20),
                                        child: Text('${state.list[index].singer}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: Screens.text10, color: Colors.grey)))
                                  ],
                                )),
//                            state.list[index].mv == 0
//                                ? Container()
//                                : IconButton(
//                                icon: Icon(
//                                  Icons.videocam,
//                                  size: Screens.text18,
//                                ),
//                                onPressed: () {
//                                  Navigator.of(viewService.context)
//                                      .pushNamed('mv_play', arguments: {'mvId': state.list[index].mv}); //注意2
//                                })
                          ],
                        ),
                      ),
                      onTap: () => dispatch(HistoryActionCreator.playSong(index)),
                    );
//                    return ListTile(
//                      dense: true,
//                      title: Row(
//                        children: <Widget>[
//                          Text(
//                            '${index + 1}. ',
//                            style: TextStyle(
//                                color: Colors.blue, fontSize: Screens.text14, fontWeight: FontWeight.bold),
//                          ),
//                          Expanded(child: Text('${state.list[index].name}'))
//                        ],
//                      ),
//                      subtitle: Text('${state.list[index].singer}'),
//                      onTap: (){dispatch(HistoryActionCreator.playSong(index));},
//                    );
                  },
                  itemCount: state.list.length,
                )),
                PlayBarPage().buildPage(null)
              ],
            ),
          ),
  );
}
