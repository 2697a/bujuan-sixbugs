import 'dart:ui';

import 'package:bujuan/constant/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/sp_util.dart';
import 'cache_image.dart';
import 'cache_image.dart';

class BujuanBack {
  static Widget back(Widget body,context,{bool isDark}) {
    if(isDark==null)isDark = Constants.dark;
    var back = SpUtil.getString(Constants.USER_BACKGROUND, defValue: null);
    var size2 = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: back == null,
          child: Stack(
            children: [
              Container(
                child: ImageHelper.getImage(back,height: size2.height),
              ),
              BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: new Container(
                  color: isDark?Colors.black.withOpacity(0.5):Colors.white.withOpacity(0.5),
                ),
              )
            ],
          ),
        ),
        Offstage(
          offstage: back != null,
          child: Container(
            color: isDark?Colors.black:Colors.white,
          ),
        ),
        body
      ],
    );
  }
}
