import 'dart:ui';

import 'package:bujuan/constant/Screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BujuanAppBar {
  static Widget norAppBar(context,title) {
    return PreferredSize(child: Container(
      padding: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
      child: Row(
        children: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back,size: Screens.setSp(22),), onPressed: ()=>Navigator.pop(context)),
          Padding(padding: EdgeInsets.only(right: Screens.setWidth(8))),
          Expanded(child: Text(title,style: TextStyle(fontSize: Screens.text18),maxLines: 1,overflow: TextOverflow.ellipsis,))
        ],
      ),
    ), preferredSize: Size.fromHeight(Screens.setHeight(48)));
  }

}
