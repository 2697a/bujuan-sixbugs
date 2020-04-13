
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Screens{
  static var text22 = ScreenUtil().setSp(22);
  static var text20 = ScreenUtil().setSp(20);
  static var text18 = ScreenUtil().setSp(18);
  static var text16 = ScreenUtil().setSp(16);
  static var text14 = ScreenUtil().setSp(14);
  static var text12 = ScreenUtil().setSp(12);
  static var text10 = ScreenUtil().setSp(10);

  static double setSp(sp) {
    return ScreenUtil().setSp(sp);
  }


  static var height5 = ScreenUtil().setHeight(5);
  static var height10 = ScreenUtil().setHeight(10);
  static var height15 = ScreenUtil().setHeight(15);
  static var height30 = ScreenUtil().setHeight(30);
  static var height36 = ScreenUtil().setHeight(36);
  static var height40 = ScreenUtil().setHeight(40);

  static double setHeight(height){
    return ScreenUtil().setHeight(height);
  }


  static var width5 = ScreenUtil().setWidth(5);
  static var width10 = ScreenUtil().setWidth(10);
  static var width15 = ScreenUtil().setWidth(15);
  static var width30 = ScreenUtil().setWidth(30);
  static var width36 = ScreenUtil().setWidth(36);
  static var width40 = ScreenUtil().setWidth(40);

  static double setWidth(width){
    return ScreenUtil().setWidth(width);
  }
}