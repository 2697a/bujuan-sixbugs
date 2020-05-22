import 'package:bujuan/constant/Screens.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(SheetViewState state, Dispatch dispatch, ViewService viewService) {
  var adapter = viewService.buildAdapter();
  return SliverToBoxAdapter(
    child: Column(
      children: <Widget>[
        Offstage(
          offstage: state.result.length == 0,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '推荐歌单',
              style:
              TextStyle(fontSize: Screens.text14, fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.only(top:2,bottom: 12,left: Screens.width5),
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: adapter.itemCount,
          itemBuilder: adapter.itemBuilder,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1.45,
              crossAxisSpacing: 23.0,
              mainAxisSpacing: 0.0),
        )
      ],
    ),
  );
}
