import 'dart:io';
import 'dart:ui';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/back_widget.dart';
import 'package:bujuan/widget/background_setting.dart';
import 'package:bujuan/widget/bujuan_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingState();
}

class SettingState extends State<SettingPage> {
  bool isBack;

  @override
  void initState() {
    super.initState();
    isBack = SpUtil.getString(USER_BACKGROUND, defValue: null) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Widgets.blackWidget(isBack, Column(
        children: <Widget>[
          AppBar(title: Text('设置'),backgroundColor: Colors.transparent,),
          Expanded(child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Container(
                color: Colors.grey[350].withOpacity(.2),
                child: Text('UI设置'),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              ),
              SwitchListTile(
                  title: Text(
                    '切换播放页ui(目前就两种，做的比较简陋)',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: false,
                  onChanged: (value) {}),
              ListTile(
                title: Text(
                  '全局背景(暂时关闭)',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () async {
                  var image = await ImagePicker.pickImage(
                      source: ImageSource.gallery);
                  showBujuanBottomSheet(
                      context: context,
                      builder: (context) {
                        return BackSetting(image);
                      }).then((value) {
                    setState(() {
                      isBack =
                          SpUtil.getString(USER_BACKGROUND, defValue: null) !=
                              null;
                    });
                  });
                },
              ),
              ListTile(
                title: Text(
                  '清除全局背景(暂时关闭)',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () async {
                  SpUtil.putString(USER_BACKGROUND, null);
                  setState(() {
                    isBack = false;
                  });
                },
              ),
              Container(
                color: Colors.grey[350].withOpacity(.2),
                child: Text('其他设置'),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              ),
//                    SwitchListTile(
//                        title: Text('开启高音质',style: TextStyle(fontSize: 14),),
//                        value: state.isHigh,
//                        onChanged: (value) {
//                          dispatch(SettingActionCreator.onIsHigh());
//                        }),
              ListTile(
                title: Text(
                  '关于',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () async {
                  await Navigator.of(context)
                      .pushNamed('about', arguments: null);
                },
              ),
              ListTile(
                title: Text(
                  '检测更新',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () async {
//              dispatch(EntranceActionCreator.onUpdate());
                },
              ),
            ],
          ))
        ],
      )),
    );
  }
}
