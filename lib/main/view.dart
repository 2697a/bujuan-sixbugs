import 'dart:ui';

import 'package:bujuan/entrance/page.dart';
import 'package:bujuan/main/routes.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/theme.dart';
import 'state.dart';

Widget buildView(MainState state, Dispatch dispatch, ViewService viewService) {
  if (state.appTheme.dark) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.grey[850],
        systemNavigationBarIconBrightness: Brightness.light));
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));
  }
  return MaterialApp(
    title: '不倦',
//    showPerformanceOverlay: true,
    // 开启
    debugShowCheckedModeBanner: false,
    darkTheme: ThemeData.dark(),
    theme: state.appTheme.dark
        ? darkTheme
        : lightTheme.copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
              },
            ),
          ),
    home: EntrancePage().buildPage(null),
    routes: appRoutes,
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}
