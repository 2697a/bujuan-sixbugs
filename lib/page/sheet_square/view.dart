import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/page/sheet_square/sheet_square_details/page.dart';
import 'package:bujuan/widget/back_widget.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(SheetSquareState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: Widgets.blackWidget(null, Container(
      child: DefaultTabController(
          length: 8,
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text('歌单广场'),
                backgroundColor: Colors.transparent,
              ),
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                labelStyle: TextStyle(fontSize: Screens.text14),
                tabs: <Widget>[
                  // 全部,华语,欧美,韩语,日语,粤语,小语种,运动,ACG,影视原声,流行,摇滚,后摇,古风,民谣,轻音乐,电子,器乐,说唱,古典,爵士
                  Tab(text: '全部'),
                  Tab(text: '华语'),
                  Tab(text: '欧美'),
                  Tab(text: '韩语'),
                  Tab(text: '日语'),
                  Tab(text: '粤语'),
                  Tab(text: '民谣'),
                  Tab(text: '古风'),
                ],
              ),
              Expanded(
                  child: TabBarView(children: <Widget>[
                    SheetSquareDetailsPage().buildPage({'type': '全部'}),
                    SheetSquareDetailsPage().buildPage({'type': '华语'}),
                    SheetSquareDetailsPage().buildPage({'type': '欧美'}),
                    SheetSquareDetailsPage().buildPage({'type': '韩语'}),
                    SheetSquareDetailsPage().buildPage({'type': '日语'}),
                    SheetSquareDetailsPage().buildPage({'type': '粤语'}),
                    SheetSquareDetailsPage().buildPage({'type': '民谣'}),
                    SheetSquareDetailsPage().buildPage({'type': '古风'}),
                  ])),
              PlayBarPage().buildPage(null)
            ],
          )),
    )),
  );
}
