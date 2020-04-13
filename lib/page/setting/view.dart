import 'package:bujuan/page/setting/action.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(SettingState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(title: Text('设置'),),
    body: Container(
      child: ListView(
        children: <Widget>[
          SwitchListTile(
              title: Text('迷你播放页'),
              value: state.miniPlay,
              onChanged: (value) {
               dispatch(SettingActionCreator.onMiniPlay());
              }),
        ],
      ),
    ),
  );
}
