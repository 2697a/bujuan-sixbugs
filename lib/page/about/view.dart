import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
//          Container(
//            padding: EdgeInsets.all(30),
//            child: Image.asset(
//              'assets/images/logo.png',
//              height: 60,
//            ),
//          ),
//          Container(
//            alignment: Alignment.center,
//            child: Text(
//              '不倦',
//              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//            ),
//          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Text(
              '此app由本人业余制作，任何人不得用作商业用途，造成后果本人概不负责。本是个人学习flutter的个人项目，很荣幸得到很多朋友的喜爱，所以开源至github，做交流学习之用。',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            child: Text(
              '使用开源框架:(感谢大佬们开源的优秀框架)',
              style: TextStyle(fontSize: 18, height: 1.5,fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 30,top: 8,bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                'alibaba/fish-redux(点击查看)',
                style: TextStyle(fontSize: 14, height: 1.5,color: Colors.blue),
              ),
            ),
            onTap:()async{
              launch('https://github.com/alibaba/fish-redux');
            },
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 30,top: 8,bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                'ziming1/NeteaseCloudMusicApi(点击查看)',
                style: TextStyle(fontSize: 14, height: 1.5,color: Colors.blue),
              ),
            ),
            onTap:()async{
              launch('https://github.com/ziming1/NeteaseCloudMusicApi');
            },
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 30,top: 8,bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                'EspoirX/StarrySky(点击查看)',
                style: TextStyle(fontSize: 14, height: 1.5,color: Colors.blue),
              ),
            ),
            onTap:()async{
              launch('https://github.com/EspoirX/StarrySky');
            },
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 30,top: 8,bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                '以及其他优秀的开源库...',
                style: TextStyle(fontSize: 14, height: 1.5,color: Colors.blue),
              ),
            ),
            onTap:()async{
              launch('https://pub.dev/');
            },
          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            child: Text(
              '作者信息:',
              style: TextStyle(fontSize: 18, height: 1.5,fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30,top: 8,bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              '酷安ID: 带走我',
              style: TextStyle(fontSize: 14, height: 1.5,color: Colors.blue),
            ),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 30,top: 8,bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                'GitHub: 2697a/bujuan-sixbugs(点击查看)',
                style: TextStyle(fontSize: 14, height: 1.5,color: Colors.blue),
              ),
            ),
            onTap:()async{
              launch('https://github.com/2697a/bujuan-sixbugs');
            },
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 30,top: 8,bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                '个人网站: https://sixbugs.com(点击查看)',
                style: TextStyle(fontSize: 14, height: 1.5,color: Colors.blue),
              ),
            ),
            onTap:()async{
              launch('http://www.sixbugs.com/');
            },
          ),
        ],
      ),
    ),
  );
}
