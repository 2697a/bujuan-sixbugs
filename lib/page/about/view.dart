import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(AboutState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('关于'),
    ),
    body: Container(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30),
            child: Image.asset(
              'assets/images/logo.png',
              height: 60,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              '不倦',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Text(
              '此app由本人业余制作，任何人不得用作商业用途，造成后果本人概不负责。',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Text(
              '本軟件用了Binaryify/NeteaseCloudMusicApi的接口，以及其他github開源框架,就不一一列出了。',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          )
        ],
      ),
    ),
  );
}
