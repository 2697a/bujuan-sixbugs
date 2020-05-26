import 'dart:io';
import 'dart:ui';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/page/setting/action.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/background_setting.dart';
import 'package:bujuan/widget/bujuan_bottom_sheet.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

import 'state.dart';

Widget buildView(SettingState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(title: Text('设置'),),
    body: Container(
      decoration: state.isBack?BoxDecoration(
        image: DecorationImage(
          image: FileImage(File(SpUtil.getString(USER_BACKGROUND))), //背景图片
          fit: BoxFit.cover,
        )
      ):BoxDecoration(
          border: null
      ),
      child: ClipRRect(
        // make sure we apply clip it properly
        child: BackdropFilter(
          //背景滤镜
          filter: ImageFilter.blur(sigmaX: SpUtil.getDouble(BLUR, defValue: 0), sigmaY: SpUtil.getDouble(BLUR, defValue: 0)), //背景模糊化
          child:ListView(
            children: <Widget>[
              Container(
                color: Colors.grey.withOpacity(.3),
                child: Text('UI设置'),
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
              ),
              SwitchListTile(
                  title: Text('切换播放页ui(目前就两种，做的比较简陋)',style: TextStyle(fontSize: 14),),
                  value: state.miniPlay,
                  onChanged: (value) {
                    dispatch(SettingActionCreator.onMiniPlay());
                  }),
              SwitchListTile(
                  title: Text(
                    '迷你导航栏',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: false,
                  onChanged: (value) {
                  }),
              SwitchListTile(
                  title: Text(
                    '去除日夜间模式的太阳',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: false,
                  onChanged: (value) {
                  }),
              ListTile(
                title: Text('全局背景(暂时关闭)',style: TextStyle(fontSize: 14),),
                onTap: () async{
                  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  showBujuanBottomSheet(context: viewService.context, builder: (context){
                    return BackSetting(image);
                  }).then((value){
                    dispatch(SettingActionCreator.onChangeBlur(true));
                  });
//              GlobalStore.store.dispatch(GlobalActionCreator.changeBack(image.path));
                },
              ),
              ListTile(
                title: Text('清除全局背景(暂时关闭)',style: TextStyle(fontSize: 14),),
                onTap: () async{
//              GlobalStore.store.dispatch(GlobalActionCreator.changeBack(null));
                },
              ),
              Container(
                color: Colors.grey.withOpacity(.3),
                child: Text('其他设置'),
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
              ),
              SwitchListTile(
                  title: Text('开启高音质',style: TextStyle(fontSize: 14),),
                  value: state.isHigh,
                  onChanged: (value) {
                    dispatch(SettingActionCreator.onIsHigh());
                  }),
              ListTile(
                title: Text(
                  '关于',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () async {
                  await Navigator.of(viewService.context)
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
          ),
        ),
      ),
    ),
  );
}
