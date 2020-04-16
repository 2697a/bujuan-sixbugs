import 'dart:io';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/page/setting/action.dart';
import 'package:bujuan/widget/bujuan_background.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

import '../../utils/sp_util.dart';
import 'state.dart';

Widget buildView(SettingState state, Dispatch dispatch, ViewService viewService) {
  return BujuanBack.back(Scaffold(
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
          ListTile(
            title: Text('全局背景'),
            onTap: () async{
              File image = await ImagePickerGC.pickImage(
                context: viewService.context,
                source: ImgSource.Gallery,
                cameraIcon: Icon(
                  Icons.add,
                  color: Colors.red,
                ),//cameraIcon and galleryIcon can change. If no icon provided default icon will be present
              );
              GlobalStore.store.dispatch(GlobalActionCreator.changeBack(image.path));
            },
          )
        ],
      ),
    ),
  ),viewService.context);
}
