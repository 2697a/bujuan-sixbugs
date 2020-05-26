import 'dart:ui';

import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/page/login/action.dart';
import 'package:bujuan/widget/back_widget.dart';
import 'package:bujuan/widget/color_loaed.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(LoginState state, Dispatch dispatch, ViewService viewService) {
  var width2 = MediaQuery.of(viewService.context).size.width;
  return Scaffold(
    resizeToAvoidBottomPadding: false,
    body: Widgets.blackWidget(null, SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: MediaQueryData.fromWindow(window).padding.top + 10),
            padding: EdgeInsets.symmetric(vertical: 25),
            width: width2,
            child: Image.asset(
              'assets/images/login.jpg',
              height: Screens.setHeight(140),
            ),
          ),
//          Container(
//            margin: EdgeInsets.only(left: 25),
//            alignment: Alignment.centerLeft,
//            child: Text('账号&邮箱'),
//          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Card(
              elevation: 2,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
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
                        vertical: Screens.setHeight(12),
                        horizontal: Screens.setWidth(8))),
              ),
            ),
          ),
//          Container(
//            margin: EdgeInsets.only(left: 25),
//            alignment: Alignment.centerLeft,
//            child: Text('密码'),
//          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Card(
              elevation: 2,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
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
                        vertical: Screens.setHeight(12),
                        horizontal: Screens.setWidth(8))),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            width: MediaQuery.of(viewService.context).size.width * 0.8,
            child: MaterialButton(
              color: Colors.blueAccent,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              onPressed: () {
                showDialog(
                  context: viewService.context,
                  builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      title: Text(
                        "正在登录",
                        style: TextStyle(fontSize: Screens.text16),
                      ),
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
                dispatch(LoginActionCreator.onLogin(
                    state.phone.text, state.pass.text));
              },
              child: Text('立即登录'),
            ),
          ),
        ],
      ),
    )),
  );
}
