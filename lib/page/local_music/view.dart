import 'package:bujuan/page/local_music/action.dart';
import 'package:bujuan/page/local_music/local_list/page.dart';
import 'package:bujuan/page/local_music/local_singer/page.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'local_sheet_list/page.dart';
import 'state.dart';

Widget buildView(LocalMusicState state, Dispatch dispatch, ViewService viewService) {
  var width2 = MediaQuery.of(viewService.context).size.width;
  return Scaffold(
    appBar: AppBar(title: Text('本地歌曲'),),
    body: state.showLoading
        ? LoadingPage()
        : state.list.length > 0
        ? Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.only(right: 10),
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        '本地歌单',
                        style: TextStyle(color: state.index == 0 ? Colors.blue : Colors.grey),
                      ),
                    ),
                  ),
                  onTap: () {
                    dispatch(LocalMusicActionCreator.changeIndex(0));
                  },
                ),
                InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        '本地歌曲',
                        style: TextStyle(color: state.index == 1 ? Colors.blue : Colors.grey),
                      ),
                    ),
                  ),
                  onTap: () {
                    dispatch(LocalMusicActionCreator.changeIndex(1));
                  },
                ),
                InkWell(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        '歌手分類',
                        style: TextStyle(color: state.index == 2 ? Colors.blue : Colors.grey),
                      ),
                    ),
                  ),
                  onTap: () {
                    dispatch(LocalMusicActionCreator.changeIndex(2));
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              children: <Widget>[
                LocalSheetListPage().buildPage({'list': state.list}),
                LocalListPage().buildPage({'list': state.list}),
                LocalSingerPage().buildPage({'list': state.list}),
              ],
              physics: NeverScrollableScrollPhysics(),
              controller: state.pageController,
            ),
          )
        ],
      ),
    )
        : Center(
      child: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            width: width2,
            child: Image.asset(
              'assets/images/loading.jpg',
              height: 60,
            ),
          ),
          Container(
            width: width2,
            child: Text(
              '暂无本地音乐',
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.only(top: 20, bottom: 20),
          ),
        ],
      ),
    ),
  );
}
