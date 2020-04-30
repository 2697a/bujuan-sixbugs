import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/page/mine/history/action.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    HistoryState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: BujuanAppBar.norAppBar(viewService.context, '听歌历史'),
    body: state.showLoading
        ? LoadingPage()
        : Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: <Widget>[
                Expanded(child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: Screens.width5),
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
          ),
  );
}
