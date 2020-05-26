import 'dart:io';
import 'dart:ui';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackSetting extends StatefulWidget {
  final File file;

  BackSetting(this.file);

  @override
  State<StatefulWidget> createState() => BackState();
}

class BackState extends State<BackSetting> {
  double blur;

  @override
  void initState() {
    blur = 5;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(widget.file), //背景图片
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRRect(
        // make sure we apply clip it properly
        child: BackdropFilter(
          //背景滤镜
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur), //背景模糊化
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            child: Column(
              children: <Widget>[
                Expanded(child: Text(''),),
                Slider(
                  value: blur,
                  onChanged: (value) {
                    setState(() {
                      blur = value;
                    });
                  },
                  min: 0.0,
                  max: 10.0,
                  divisions: 10,
                  activeColor: Theme.of(context).accentColor,
                  inactiveColor: Theme.of(context).accentColor.withOpacity(0.3),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                FloatingActionButton(onPressed: (){
                  SpUtil.putString(USER_BACKGROUND, widget.file.path);
                  SpUtil.putDouble(BLUR, blur);
                  Navigator.of(context).pop();
                },child: Icon(Icons.offline_pin),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
