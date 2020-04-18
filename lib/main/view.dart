import 'dart:ui';

import 'package:bujuan/main/routes.dart';
import 'package:bujuan/widget/bujuan_background.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../constant/theme.dart';
import 'state.dart';

Widget buildView(MainState state, Dispatch dispatch, ViewService viewService) {
  return MaterialApp(
    title: '不倦',
//    showPerformanceOverlay: true,
    // 开启
    debugShowCheckedModeBanner: false,
    darkTheme: ThemeData.dark(),
    theme: state.appTheme.dark ? darkTheme : lightTheme,
    home:  routes.buildPage('entrance_page', null),
    routes: appRoutes,
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}
