import 'dart:ui';

import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/page/login/action.dart';
import 'package:bujuan/widget/bujuan_background.dart';
import 'package:bujuan/widget/color_loaed.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(LoginState state, Dispatch dispatch, ViewService viewService) {
  var width2 = MediaQuery.of(viewService.context).size.width;
  return BujuanBack.back(Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top + 20),
            padding: EdgeInsets.all(Screens.setHeight(30)),
            width: width2,
            child: Image.asset(
              'assets/images/logo.png',
              height: Screens.setHeight(60),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Card(
              elevation: 2,
              shape:
              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                controller: state.phone,
                style: TextStyle(fontSize: Screens.text14),
                decoration: InputDecoration(
                    isDense: true,
                    hintText: '请输入手机号或郵箱',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: Screens.setHeight(12), horizontal: Screens.setWidth(8))),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Card(
              elevation: 2,
              shape:
              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.text,
                maxLines: 1,
                controller: state.pass,
                obscureText: true,
                style: TextStyle(fontSize: Screens.text14),
                decoration: InputDecoration(
                    isDense: true,
                    hintText: '请输入密码',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: Screens.setHeight(12), horizontal: Screens.setWidth(8))),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Screens.setHeight(20), left: Screens.setWidth(20), right: Screens.setWidth(20)),
            width: width2,
            alignment: Alignment.center,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                alignment: Alignment.center,
                width: width2,
                child: Text(
                  '点我登录',
                  style: TextStyle(color: Colors.blue, fontSize: Screens.text16, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                showDialog(
                  context: viewService.context,
                  builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      title: Text("正在登录",style: TextStyle(fontSize: Screens.text16),),
                      content: Container(
                        height: Screens.setHeight(50),
                        width: Screens.setWidth(50),
                        alignment: Alignment.center,
                        child: ColorLoader3(
                          radius: 20.0,
                          dotRadius: 3.0,
                        ),
                      )),
                );
                dispatch(LoginActionCreator.onLogin(state.phone.text, state.pass.text));
              },
            ),
          ),
        ],
      ),
    ),
  ), viewService.context);
}
