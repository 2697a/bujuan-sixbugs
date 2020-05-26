import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/page/mine/history/action.dart';
import 'package:bujuan/widget/back_widget.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    HistoryState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: Widgets.blackWidget(null, state.showLoading
        ? LoadingPage()
        : Container(
      child: Column(
        children: <Widget>[
          AppBar(title: Text('听歌历史'),backgroundColor: Colors.transparent,),
          Expanded(child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: Screens.width10),
                dense: true,
                title: Row(
                  children: <Widget>[
                    Text(
                      '${index + 1}. ',
                      style: TextStyle(
                          color: Colors.blue, fontSize: Screens.text14, fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: Text('${state.list[index].name}',style: TextStyle(fontSize: Screens.text14),maxLines: 1,overflow: TextOverflow.ellipsis,))
                  ],
                ),
                subtitle: Text('${state.list[index].singer}',style: TextStyle(fontSize: Screens.text12),maxLines: 1,overflow: TextOverflow.ellipsis,),
                onTap: (){dispatch(HistoryActionCreator.playSong(index));},
              );
            },
            itemCount: state.list.length,
          )),
          PlayBarPage().buildPage(null)
        ],
      ),
    )),
  );
}
