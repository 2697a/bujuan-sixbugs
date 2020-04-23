//import 'dart:io';
//import 'dart:ui';
//
//import 'package:bujuan/constant/Screens.dart';
//import 'package:bujuan/constant/constants.dart';
//import 'package:bujuan/page/play/page.dart';
//import 'package:bujuan/widget/play_bar/page.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:sliding_up_panel/sliding_up_panel.dart';
//
//import '../utils/sp_util.dart';
//import 'cache_image.dart';
//
//class BujuanBack {
//  static Widget bujuanBack(child,{path,dark,blur}) {
//    var back =path==null? SpUtil.getString(Constants.USER_BACKGROUND, defValue: null):path;
//    var isdark= dark==null?Constants.dark:dark;
//    var dBlur = blur==null? SpUtil.getDouble(Constants.BLUR,defValue: null):blur;
//    return Container(
//      decoration: back != null
//          ? BoxDecoration(
//              image: DecorationImage(
//                  image: FileImage(File(back)),
//                  colorFilter: ColorFilter.mode(
//                      !isdark?Colors.white.withOpacity(.4):Colors.grey[850].withOpacity(.4), BlendMode.colorDodge),
//                  fit: BoxFit.cover))
//          : BoxDecoration(),
//      child: back != null
//          ? BackdropFilter(
//              filter: ImageFilter.blur(sigmaX: dBlur, sigmaY: dBlur),
//              child: child,
//            )
//          : child,
//    );
//  }
//
//  static Widget back(Widget body, context,
//      {bool isDark, String backPath, double blurs}) {
//    if (isDark == null) isDark = Constants.dark;
//    var back = backPath == null
//        ? SpUtil.getString(Constants.USER_BACKGROUND, defValue: null)
//        : backPath;
//    var blur =
//        blurs == null ? SpUtil.getDouble(Constants.BLUR, defValue: 2.0) : blurs;
////    var size2 = MediaQuery.of(context).size;
//    return Stack(
//      children: <Widget>[
//        Offstage(
//          offstage: back == null,
//          child: Stack(
//            children: [
//              Container(
//                color: Colors.white,
//                child: ImageHelper.getImage(back, height: double.infinity),
//              ),
//              BackdropFilter(
//                filter: new ImageFilter.blur(sigmaX: blur, sigmaY: blur),
//                child: new Container(
//                  color: isDark
//                      ? Colors.grey[850].withOpacity(0.5)
//                      : Colors.white.withOpacity(0.5),
//                ),
//              )
//            ],
//          ),
//        ),
//        Offstage(
//          offstage: back != null,
//          child: Container(
//            color: isDark ? Colors.grey[850] : Colors.white,
//          ),
//        ),
//        body
//      ],
//    );
//  }
//
//  static Widget backAndPlayBar(Widget body, context, panelController,
//      {bool isDark}) {
//    if (isDark == null) isDark = Constants.dark;
//    var back = SpUtil.getString(Constants.USER_BACKGROUND, defValue: null);
//    var size2 = MediaQuery.of(context).size;
//    return Stack(
//      children: <Widget>[
//        Offstage(
//          offstage: back == null,
//          child: Stack(
//            children: [
//              Container(
//                child: ImageHelper.getImage(back, height: size2.height),
//              ),
//              BackdropFilter(
//                filter: new ImageFilter.blur(sigmaX: 3, sigmaY: 3),
//                child: new Container(
//                  color: isDark
//                      ? Colors.black.withOpacity(0.5)
//                      : Colors.white.withOpacity(0.5),
//                ),
//              )
//            ],
//          ),
//        ),
//        Offstage(
//          offstage: back != null,
//          child: Container(
//            color: isDark ? Colors.black : Colors.white,
//          ),
//        ),
//        Scaffold(
//          body: SlidingUpPanel(
//            controller: panelController,
//            minHeight: Screens.setHeight(62),
//            maxHeight: MediaQuery.of(context).size.height,
//            boxShadow: null,
//            border: Border.all(color: Colors.grey, width: 0.1),
//            panel: Container(
//              child: PlayViewPage().buildPage({'panel': panelController}),
//            ),
//            collapsed: InkWell(
//              child: Container(
//                alignment: Alignment.center,
//                padding: EdgeInsets.symmetric(horizontal: Screens.width5),
//                child: PlayBarPage().buildPage(null),
//              ),
//              onTap: () {
//                panelController.open();
//              },
//            ),
//            body: body,
//          ),
//        )
//      ],
//    );
//  }
//}
