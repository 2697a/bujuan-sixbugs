import 'dart:ui';

import 'package:flutter/material.dart';

//主题
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(elevation: 0),
  cardTheme: CardTheme(color: Colors.white, elevation: 0),
);
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[850],
  appBarTheme: AppBarTheme(elevation: 0),
  scaffoldBackgroundColor: Colors.grey[900],
  cardTheme: CardTheme(color: Color.fromRGBO(28, 28, 28, 1)),
);

class AppTheme {
  //白天颜色
  static Color titleColor = Colors.black54;
  static Color subTitleColor = Colors.black26;
  static Color tabSelectColor = Colors.redAccent;
  static Color appBarTitleColor = Colors.white;

//夜间颜色
  static Color darkTitleColor = Colors.white;
  static Color darkSubTitleColor = Colors.white70;
  static Color darkTabSelectColor = Colors.white70;
  static Color darkAppBarTitleColor = Colors.white70;
  bool dark;

//大小
  static double titleSize = 18;
  static double subTitleSize = 16;
  TextStyle titleStyle;

  TextStyle appBarTitleStyle;
  TextStyle subtitleStyle;

  AppTheme._(bool dark) {
    _init(dark);
  }

  static AppTheme _instance;

  static AppTheme getInstance(bool dark) {
    print("appTheme=$dark");
    if (_instance == null || _instance.dark != dark) {
      _instance = AppTheme._(dark);
    }

    return _instance;
  }

  _init(bool dark) {
    this.dark = dark;
    subtitleStyle = new TextStyle(color: dark ? darkSubTitleColor : subTitleColor, fontSize: subTitleSize);
    titleStyle = TextStyle(
      color: dark ? darkTitleColor : titleColor,
      fontSize: titleSize,
    );
    appBarTitleStyle = TextStyle(
      color: appBarTitleColor,
      fontSize: titleSize,
    );
  }
}

class LightTheme {}
